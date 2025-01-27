import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'constant.dart';
import 'dart:convert' as convert;

class Login {
  String usuario;
  String password;

  Login(this.usuario, this.password);

  Future<dynamic> loguear() async {
    dynamic respuesta;
    final link = Uri.parse(BaseUrl + "api/login.php");
    final response = await http.post(link, body: {
      "usuario": usuario,
      "pass": password,
    });

    if (response.statusCode != 200) {
      respuesta.mensaje = "no existe esa URL";
      respuesta.success = 0;
    } else {
      var json = convert.jsonDecode(response.body);
      respuesta = json;
      if (json["success"] == 1) {
        _guardarPreferences(json);
      }
    }
    return respuesta;
  }

  _guardarPreferences(var jsonResponse) async {
    var json = jsonResponse["usuario"][0];
   
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.clear();
    await pref.setString('id', json[0]);
    await pref.setString('nombre', json[1]);
    await pref.setString('password', json[2]);
    await pref.setString('tipo', json[4]);
  }
}
