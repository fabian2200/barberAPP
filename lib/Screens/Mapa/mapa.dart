import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Mapa/size_config.dart';

import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/http/consultas.dart';
import 'package:flutter_auth/modelos/barberia.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'dart:math';
import 'package:url_launcher/url_launcher.dart';

import '../../components/BouncyPageRoute.dart';
import '../Principal/Cita.dart';

class MapSample extends StatefulWidget {
  final double lat;
  final double long;
  final String horario;
  final String nombre;
  final double distancia;
  final Barberia barberiaSeleccionada;
  MapSample(this.lat, this.long, this.horario, this.nombre, this.distancia, this.barberiaSeleccionada, {Key key}) : super(key: key);
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  String currentAddress = 'My Address';
  Position currentposition;
  ConsultasHTTP consultas = ConsultasHTTP();
  List<Barberia> listaBarberias;
  final Set<Marker> markers = new Set();
  Set<Circle> circles = new Set();
  BitmapDescriptor customIcon;

  double alto = -190;
  SizeConfig _sc = SizeConfig();

  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(0, 0),
    zoom: 13.4746,
  );

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    Size size = MediaQuery.of(context).size;
    return new Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: ColorMenu,
        title: Center(child: Text(widget.nombre)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
      ),
      body: Stack( 
        children: [
          GoogleMap(
            mapType: MapType.normal,
            circles: circles,
            initialCameraPosition: _kGooglePlex,
            markers: markers,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 500),
            bottom: alto,
            child: Container(
              height: 190,
              width: size.width,
              padding: const EdgeInsets.symmetric(horizontal: 0),
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 0, 0, 0),
                   borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(255, 119, 117, 117).withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
              ),
              child:  Column(
                children : <Widget>[
                  Positioned(
                    top: 35,
                    right: 30,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(top: 10, right: 10),
                          child: IconButton(
                            icon: const Icon(Icons.close, color: Colors.red),
                            tooltip: 'Cerrar ventana',
                            onPressed: () {
                              setState(() {
                                
                                cerrarmodal();
                              });
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(0),
                              child: Image.asset(
                                'assets/images/ruta.png',
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 20),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.nombre, style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white)),
                            Text("Horario: "+widget.horario, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color.fromRGBO(182, 149, 113, 1))),
                            Text("A "+widget.distancia.toString()+" KM de distancia", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color.fromRGBO(182, 149, 113, 1)))
                          ],
                        ),
                         SizedBox(width: 20),
                        Column(
                          children: [
                            IconButton(
                              iconSize: 46,
                              color: Color.fromRGBO(221, 165, 105, 1),
                              icon: const Icon(Icons.directions),
                              onPressed: () {
                                openGoogleMaps(widget.lat, widget.long);
                              },
                            ),
                             IconButton(
                              iconSize: 46,
                              color: Color.fromRGBO(221, 165, 105, 1),
                              icon: const Icon(Icons.calendar_month),
                              onPressed: () {
                                Navigator.push(
                                  context, BouncyPageRoute(widget: Cita(widget.barberiaSeleccionada))
                                );
                              },
                            ),
                          ],
                        ),
                        
                      ],
                    ),
                  )
                ]
              )
            )
          )
        ]
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _setIcon();
  }

  void openGoogleMaps(double lat, double lng) async {
    final url = 'https://www.google.com/maps/dir/?api=1&destination=$lat,$lng';
    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      // ignore: deprecated_member_use
      await launch(url);
    } else {
      throw 'No se pudo abrir Google Maps';
    }
  }

  _setIcon() async {
    customIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(), 'assets/images/icon_position.png'
    );
    _determinePosition();
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

   
    markers.add(Marker(
      //add first marker
      markerId: MarkerId(widget.nombre),
      position: LatLng(widget.lat, widget.long),
      infoWindow: InfoWindow(
        //popup info
        title: widget.nombre,
        snippet: widget.horario,
      ),
      icon: customIcon,
      onTap: () {
        mostrarBarberiaDetalle();
      }
    ));
    
  }

  mostrarBarberiaDetalle() {
     setState(() {     
      alto = 0; 
    });
  }

  cerrarmodal() {
    double alto_2 =  _sc.getProportionateScreenHeight(190);
    setState(() {
      alto = -1 * alto_2;
    });
  }

  Future<void> _goToPosition(Position posicion) async {
    final CameraPosition _kLake = CameraPosition(
        target: LatLng(posicion.latitude, posicion.longitude),
        zoom: getZoomLevel(widget.distancia * 1000));

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
