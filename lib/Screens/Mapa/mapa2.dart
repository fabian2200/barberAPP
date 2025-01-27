import 'dart:async';
import 'package:flutter/material.dart';

import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/http/consultas.dart';
import 'package:flutter_auth/modelos/barberia.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'dart:math';

import 'package:range_slider_dialog/range_slider_dialog.dart';

class MapSample2 extends StatefulWidget {
  MapSample2({Key key}) : super(key: key);
  @override
  State<MapSample2> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample2> {
  String currentAddress = 'My Address';
  Position currentposition;
  ConsultasHTTP consultas = ConsultasHTTP();
  List<Barberia> listaBarberias;
  final Set<Marker> markers = new Set();
  Set<Circle> circles = new Set();
  BitmapDescriptor customIcon;

  RangeValues _rangeValues = RangeValues(0, 1);
  
  @override
  void initState() {
    super.initState();
    _setIcon();
  }

  _setIcon() async {
    customIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), 'assets/images/icon_position.png');
    _cargarBarberias();
  }

  _cargarBarberias() async {
    listaBarberias = [];
    var request = await consultas.listarBarberias();
    setState(() {
      listaBarberias = request;
      _determinePosition();
    });
  }

  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(0, 0),
    zoom: 13.4746,
  );

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: ColorMenu,
        title: Center(child: Text("BARBERÍAS CERCANAS")),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        circles: circles,
        initialCameraPosition: _kGooglePlex,
        markers: markers,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromRGBO(216, 172, 124, 1),
        onPressed: () {
          showRangeSliderDialog(context, this._rangeValues, (e) {
            setState(() {
              this._rangeValues = e;
              this._generateCircle();
            });
          });
        },
        child: const Icon(Icons.add_location_alt_rounded)
      )
    );
  }

   void showRangeSliderDialog(BuildContext context, RangeValues defaultValue,
      Function(RangeValues) callback) async {
    await RangeSliderDialog.display(context,
        minValue: 0,
        maxValue: 10,
        acceptButtonText: 'ACEPTAR',
        cancelButtonText: 'CANCELAR',
        headerText: 'Seleccione un rango de busqueda en (Km)',
        selectedRangeValues: defaultValue, onApplyButtonClick: (value) {
      callback(value);
      Navigator.pop(context);
    });
  }

  _generateCircle() {
    circles = Set.from([
      Circle(
          circleId: CircleId("myCircle"),
          radius: _rangeValues.end * 1000,
          center: LatLng(currentposition.latitude, currentposition.longitude),
          fillColor: Color.fromARGB(22, 234, 45, 174),
          strokeColor: Color.fromARGB(125, 233, 11, 170),
          strokeWidth: 2)
    ]);
  }

  _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Fluttertoast.showToast(msg: 'Please enable Your Location Service');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Fluttertoast.showToast(msg: 'Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Fluttertoast.showToast(
          msg:
              'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      Placemark place = placemarks[0];

      setState(() {
        currentposition = position;
        currentAddress =
            "${place.locality}, ${place.postalCode}, ${place.country}";
        _goToPosition(currentposition);
        _addMarkers();
      });
    } catch (e) {
      print(e);
    }
  }

  void _addMarkers() {
    markers.add(Marker(
      //add first marker
      markerId: MarkerId("Mi posición"),
      position: LatLng(currentposition.latitude, currentposition.longitude),
      infoWindow: InfoWindow(
        //popup info
        title: "Mi posición",
        snippet: "Actual",
      ),
      icon: BitmapDescriptor.defaultMarker,
    ));

    for (var item in listaBarberias) {
      markers.add(Marker(
        //add first marker
        markerId: MarkerId(item.id),
        position: LatLng(item.lat, item.long),
        infoWindow: InfoWindow(
          //popup info
          title: item.nombre,
          snippet: item.horario,
        ),
        icon: customIcon,
      ));
    }
    _generateCircle();
  }

  Future<void> _goToPosition(Position posicion) async {
    final CameraPosition _kLake = CameraPosition(
        target: LatLng(posicion.latitude, posicion.longitude),
        zoom: getZoomLevel(_rangeValues.end * 1000));

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }

  double getZoomLevel(double radius) {
    double zoomLevel = 11;
    if (radius > 0) {
      double radiusElevated = radius + radius / 2;
      double scale = radiusElevated / 500;
      zoomLevel = 16 - log(scale) / log(2);
    }
    zoomLevel = num.parse(zoomLevel.toStringAsFixed(2));
    return zoomLevel;
  }
}
