import 'package:flutter/material.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/http/Cita.dart';
import 'package:flutter_auth/http/constant.dart';
import 'package:flutter_auth/http/response.dart';
import 'package:flutter_auth/modelos/Barbero.dart';
import 'package:flutter_auth/http/consultas.dart';
import 'package:flutter_auth/modelos/Cita.dart';
import 'package:flutter_auth/modelos/Servicio.dart';
import 'package:flutter_auth/modelos/barberia.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter_week_view/flutter_week_view.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ReservaCita extends StatefulWidget {
  final Barbero barberoSeleccionado;
  ReservaCita(this.barberoSeleccionado);
  ReservaCitaState createState() => new ReservaCitaState(barberoSeleccionado);
}

class ReservaCitaState extends State<ReservaCita> {
  bool loading = false;
  var selectedDate = DateTime.now();
  var selectedTime = TimeOfDay.now();
  String hora = "";
  String minuto = "";
  ConsultasHTTP consultas = new ConsultasHTTP();
  final Barbero barberoSeleccionado;
  ReservaCitaState(this.barberoSeleccionado);
  Size size;

  List<Servicio> servicios = [];
  List<CitaModel> citasBarbero = [];
  List<Servicio> turnos = [];
  String id_barberia;
  String id_barbero;

  double precio = 0.0;
  int tiempo = 10;
  String serviciosSeleccionados;

  CitaHttp http = new CitaHttp();

  Barberia barberia;

  String id_usuario = "";

  @override
  void initState() {
    super.initState();
    this._id_usuario();
    _listarServiciosBarbero();
    _obtenerListaServicios();
    _consultarBarberia();
    this.hora = this.selectedTime.hour.toString();
    this.minuto = this.selectedTime.minute.toString();
   
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: ColorMenu,
        title: Center(child: Text("RESERVA DE CITA")),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: new Icon(Icons.save_sharp),
            onPressed: () {
              _guardarCita(this.context);
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/myteams.png'),
                fit: BoxFit.cover)),
        child: Container(
          color: Colors.transparent,
          padding: EdgeInsets.only(top: 150, left: 20, right: 20),
          width: size.width,
          child: Column(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(70),
                child: Image.network(
                  BaseUrl + "fotos_perfil/" + barberoSeleccionado.foto_perfil,
                  width: 130,
                  height: 130,
                  fit: BoxFit.cover,
                ),
              ),
              Text(barberoSeleccionado.nombre,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'quick',
                  shadows: [
                    Shadow(
                      color: Colors.black,
                      offset: Offset(1.0, 1.0),
                      blurRadius: 10,
                    ),
                  ]
                )
              ),
              SizedBox(height: 20),
              Container(
                child: TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    disabledForegroundColor: Colors.red,
                    backgroundColor: Colors.black,
                    minimumSize: Size(200, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    side: BorderSide(
                      color: Color.fromRGBO(216, 172, 124, 1), 
                      width: 3
                    ),
                  ),
                  onPressed: () { 
                    _selectTime(context);
                  },
                  child: Text('Ver Disponibilidad'),
                ),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      GestureDetector(
                          onTap: () {
                            _selectDate(context);
                          },
                          child: Container(
                            width: 200,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  WidgetSpan(
                                    child: Icon(Icons.calendar_today_sharp,
                                        size: 20),
                                  ),
                                  WidgetSpan(
                                    child: Text(
                                      "  " +
                                          selectedDate.day.toString() +
                                          "-" +
                                          selectedDate.month.toString() +
                                          "-" +
                                          selectedDate.year.toString(),
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      GestureDetector(
                          onTap: () {
                            _selectTimeReloj(context);
                          },
                          child: Container(
                            width: 100,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  WidgetSpan(
                                    child: Icon(Icons.watch_later, size: 20),
                                  ),
                                  WidgetSpan(
                                    child: Text(
                                          selectedTime.hour.toString() +
                                          ":" +
                                          selectedTime.minute.toString(),
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ))
                    ],
                  ),
                ],
              ),
              SizedBox(height: 30),
              Container(
                height: 350,
                child: loading
                    ? ListView.builder(
                        padding: const EdgeInsets.all(0),
                        itemCount: servicios.length,
                        itemBuilder: (context, index) {
                          return Card(
                              child: CheckboxListTile(
                            contentPadding: EdgeInsets.all(10),
                            title: Text("Nombre: " + servicios[index].nombre),
                            subtitle: Text("Precio: " +
                                servicios[index].precio +
                                " Pesos. \n" +
                                "Duracion:  " +
                                servicios[index].tiempo +
                                " minutos"),
                            secondary: const Icon(Icons.arrow_right),
                            autofocus: false,
                            activeColor: Color.fromRGBO(216, 172, 124, 1),
                            checkColor: Colors.white,
                            selected: servicios[index].value,
                            value: servicios[index].value,
                            onChanged: (bool value) {
                              setState(() {
                                servicios[index].value = value;
                                _calcularPrecio();
                              });
                            },
                          ));
                        })
                    : Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(
                              Color.fromRGBO(216, 172, 124, 0.7)),
                          backgroundColor: Colors.transparent,
                          strokeWidth: 7,
                        ),
                      ),
              ),
              SizedBox(height: 4),
              Container(
                padding:
                    EdgeInsets.only(top: 10, bottom: 10, right: 20, left: 20),
                color: Color.fromRGBO(3, 3, 3, 1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("TIEMPO: " + tiempo.toString() + " Mts",
                        style: TextStyle(color: Colors.white)),
                    Text("PRECIO: " + precio.toString() + " COP",
                        style: TextStyle(color: Colors.white))
                  ],
                ),
              ),
              SizedBox(height: 5),
              Container(
                child: TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    disabledForegroundColor: Colors.red,
                    backgroundColor: Color.fromRGBO(216, 172, 124, 1),
                    minimumSize: Size(300, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    
                  ),
                  onPressed: () { 
                    _guardarCita(this.context);
                  },
                  child: Text('Guardar reservación'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _id_usuario() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
      this.id_usuario = preferences.getString('id');
  }
  _selectDate(BuildContext context) async {
    final DateTime selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(selectedDate.year),
      lastDate: DateTime(selectedDate.year + 1),
    );
    if (selected != null && selected != selectedDate)
      setState(() {
        selectedDate = selected;
      });
  }

  _selectTime(BuildContext context) async {

    await _listarServiciosBarbero();

    DateTime now = DateTime.now();
    DateTime date = DateTime(now.year, now.month, now.day);


    String hora1String = barberia.horarioa;
    String hora2String = barberia.horarioc;

    String fecha = selectedDate.year.toString() +
        "-" +
        selectedDate.month.toString() +
        "-" +
        selectedDate.day.toString();

    var arrayFecha = fecha.split("-");

    var mes = arrayFecha[1];
    var dia = arrayFecha[2];

    if (int.parse(mes) < 10) {
      mes = "0" + mes;
    }

    if (int.parse(dia) < 10) {
      dia = "0" + dia;
    }

    DateTime hora1 = DateTime.parse(
        arrayFecha[0] + '-' + mes + '-' + dia + " " + hora1String + ":00");
    DateTime hora2 = DateTime.parse(
        arrayFecha[0] + '-' + mes + '-' + dia + " " + hora2String + ":00");

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          actions: <Widget>[
            Container(
              width: 100,
              child: TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.black,
                  minimumSize: Size(300, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [Icon(Icons.close)],
                    ),
                    Column(
                      children: [
                        Text("Cerrar")
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
          title: const Text('Selecciona la hora'),
          content: Container(
            width: 400,
            height: 700,
            child: WeekView(
              hoursColumnStyle: HoursColumnStyle(interval: Duration(minutes: 30)),
              initialTime: now,
              dates: [date, date.add(const Duration(days: 1)), date.add(const Duration(days: 2))],
              events: pintar_turnos(),
            )
          ) 
        );
      },
    );
  }

  Future<Null> _selectTimeReloj(BuildContext context) async {
    String _setTime, _setDate;
    String _hour, _minute, _time;
    String dateTime;
    TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);

    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null){
      setState(() {
        selectedTime = picked;
        _hour = selectedTime.hour.toString();
        _minute = selectedTime.minute.toString();
       
        this.hora = _hour;
        this.minuto = _minute;

        this.selectedTime = TimeOfDay(hour: int.parse(this.hora), minute: int.parse(this.minuto));

      });
    }
  }

  Future<void> _obtenerListaServicios() async {
    List<Servicio> respuesta;
    id_barberia = barberoSeleccionado.idBarberia;
    respuesta = await consultas.listarServicios(id_barberia);

    setState(() {
      servicios = [];
      servicios.addAll(respuesta);
    });
  }

  Future<void> _listarServiciosBarbero() async {
    List<CitaModel> respuesta;
    id_barbero = barberoSeleccionado.id;
    respuesta = await consultas.listarCitasBarbero(id_barbero);
    print(respuesta);
    setState(() {
      citasBarbero = [];
      citasBarbero.addAll(respuesta);
    });
  }

  Future<void> _consultarBarberia() async {
    dynamic barberia_res = await consultas.consultarBarberia(id_barberia);
    print(barberia_res);
    setState(() {
      barberia = barberia_res;
      loading = true;
    });
  }

  List<FlutterWeekViewEvent> pintar_turnos() {
    List<FlutterWeekViewEvent> turnos = [];

    for (var element in this.citasBarbero) {
      List<DateTime> horas_cita = convertirAFechaHora(int.parse(element.hora_inicio), int.parse(element.minuto_inicio), int.parse(element.hora_final), int.parse(element.minuto_final), element.fecha_cita);
      turnos.add(
        FlutterWeekViewEvent(
          title: 'Ocupado',
          description:  this.id_usuario == element.id_usuario ? 'Toca para ver detalles' : '',
          start: horas_cita[0],
          end: horas_cita[1],
          backgroundColor: this.id_usuario == element.id_usuario ? Colors.green : Colors.red
        )
      );
    }

    return turnos;
  }

  List<DateTime> convertirAFechaHora(int horaInicio, int minutoInicio, int horaFinal, int minutoFinal, String fechaCita) {
    // Dividir la fecha en día, mes y año
    List<String> fechaSplit = fechaCita.split('-');
    int dia = int.parse(fechaSplit[0]);
    int mes = int.parse(fechaSplit[1]);
    int anio = int.parse(fechaSplit[2]);

    // Crear objetos DateTime
    DateTime horaInicio2 = DateTime(anio, mes, dia, horaInicio, minutoInicio);
    DateTime horaFinal2 = DateTime(anio, mes, dia, horaFinal, minutoFinal);

    // Retornar ambos DateTime
    return [horaInicio2, horaFinal2];
  }

  _calcularPrecio() {
    serviciosSeleccionados = "";
    precio = 0;
    tiempo = 10;
    for (var item in servicios) {
      if (item.value) {
        precio = precio + double.parse(item.precio);
        tiempo = tiempo + int.parse(item.tiempo);
        serviciosSeleccionados = serviciosSeleccionados + item.id + " ";
      }
    }
  }

  bool _verificar(String hora, String minuto){
    if(citasBarbero.where((i) => i.hora_inicio == hora && i.minuto_inicio == minuto).toList().length > 0){
      return true;
    }else{
      return false;
    }
  }

  Future<void> _guardarCita(BuildContext context) async {
    if (_validarFecha(this.selectedDate)) {
      
      if(this.serviciosSeleccionados != null && this.serviciosSeleccionados != ""){
        showDialog(
          context: context,
          builder: (_) {
            return const Center(
                child: CircularProgressIndicator.adaptive(
              valueColor:
                  AlwaysStoppedAnimation(Color.fromRGBO(216, 172, 124, 0.7)),
            ));
        });

        ResponseHttp response = await http.ReservarCita(
          this.selectedDate,
          this.selectedTime,
          this.barberoSeleccionado,
          this.tiempo,
          this.precio,
          this.serviciosSeleccionados
        );
        if (response.success == 1) {
          Navigator.of(context).pop();
          Alert(
            padding: EdgeInsets.only(top: 10, bottom: 10, right: 20, left: 20),
            context: context,
            type: AlertType.success,
            title: "CORRECTO",
            desc: response.mensaje,
            buttons: [
              DialogButton(
                child: Text(
                  "OK",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  setState(() {
                    _obtenerListaServicios();
                    tiempo = 10;
                    precio = 0;
                    selectedDate = DateTime.now();
                  });
                },
                width: 120,
              )
            ],
          ).show();
        } else {
          Navigator.of(context).pop();
          Alert(
            padding: EdgeInsets.only(top: 10, bottom: 10, right: 20, left: 20),
            context: context,
            type: AlertType.error,
            title: "ERROR",
            desc: response.mensaje,
            buttons: [
              DialogButton(
                child: Text(
                  "OK",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                width: 120,
              )
            ],
          ).show();
        }
      }else{
        Alert(
          padding: EdgeInsets.only(top: 10, bottom: 10, right: 20, left: 20),
          context: context,
          type: AlertType.error,
          title: "ERROR",
          desc: "Debe seleccionar al menos un servicio",
          buttons: [
            DialogButton(
              child: Text(
                "OK",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              width: 120,
            )
          ],
        ).show();
      }
    } else {
      Alert(
        padding: EdgeInsets.only(top: 10, bottom: 10, right: 20, left: 20),
        context: context,
        type: AlertType.error,
        title: "ERROR",
        desc: "La hora de la cita no puede \n ser menor a la hora actual.",
        buttons: [
          DialogButton(
            child: Text(
              "OK",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            width: 120,
          )
        ],
      ).show();
    }
  }

  _validarFecha(DateTime fecha) {
    var fechaActual = DateTime.now();
    var horaActual = TimeOfDay.now();

    var hora = new TimeOfDay(hour: int.parse(this.hora), minute: int.parse(this.minuto));

    if (fechaActual.day == fecha.day &&
        fechaActual.month == fecha.month &&
        fechaActual.year == fecha.year) {
      if (horaActual.hour <= hora.hour) {
        double oa = horaActual.hour + horaActual.minute / 60.0;
        double os = hora.hour + hora.minute / 60.0;
        if (oa <= os) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } else {
      return true;
    }
  }
}
