import 'package:flutter/material.dart';
import 'package:flutter_auth/components/BouncyPageRoute.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sweetalertv2/sweetalertv2.dart';



class AppbarPrincipal {
  Widget Menu(BuildContext context) {
   return  AppBar(
          toolbarHeight: 100,
          backgroundColor: ColorMenu,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.menu, color: Colors.white),
                onPressed: () => print('hi on menu icon'),
              );
            },
          ), 
          title: Container(
            child: Image.asset('assets/images/lema.png'),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: new Icon(Icons.login),
              onPressed: () {
                SweetAlertV2.show(context,
                  title: "Cerrando sesión",
                  subtitle: "¿realmente desea cerrar sesión?",
                  style: SweetAlertV2Style.confirm,
                  cancelButtonText: "No",
                  confirmButtonText: "Si",
                  confirmButtonColor: Colors.black,
                  cancelButtonColor: Color.fromRGBO(216,172,124, 1),
                  showCancelButton: true, onPress: (bool isConfirm) {
                    if (isConfirm) {
                      _borrarDatos(context);
                    }
                  }
                );
              },
            ),
          ],
        );
  }
  Future <void> _borrarDatos(BuildContext context) async{
   SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
    Navigator.push(
    context,
      BouncyPageRoute(widget: LoginPage())
    );
  } 
}