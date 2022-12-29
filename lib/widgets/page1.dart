//import 'dart:ui';

//import 'package:app_3/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:app_3/theme/app_theme.dart';
import 'package:app_3/modelos/categoria.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:app_3/services/auth_services.dart';
//import 'package:app_3/providers/login_form_provider.dart';
//import 'package:animate_do/animate_do.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:app_3/modelos/fuentes.dart';
//import 'package:rnd/rnd.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);
  //final user = FirebaseFirestore.instance.collection('usuarios').doc().get();

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    //final loginForm = Provider.of<LoginFormProvider>(context);
    final authService = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  authService.logout();
                  Navigator.pushReplacementNamed(context, 'inicio');
                },
                icon: Icon(Icons.logout_outlined))
          ],
          title: Image.asset('assets/rino4.png', height: 100),
          backgroundColor: AppTheme.primary,
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Container(
                height: 150,
                color: Colors.white,
                child: Column(
                  children: [
                    SizedBox(width: 100),
                    Expanded(
                      child: Card(
                          shadowColor: Color.fromRGBO(38, 166, 153, 10),
                          elevation: 20,
                          child: ListTile(
                            hoverColor: AppTheme.primary,
                            title: Text('Bienvenido (a):',
                                style: TextStyle(
                                    fontFamily: titulo, fontSize: 23)),
                            subtitle: Text('¿Qué quieres hacer hoy?',
                                style: TextStyle(
                                    fontFamily: titulo, fontSize: 20)),
                            trailing:
                                Lottie.asset('assets/basket.json', height: 400),
                          )),
                    ),
                  ],
                )),
            Expanded(
              child: Container(
                child: Stack(children: [
                  Card(
                    elevation: 10,
                    child: Container(
                      child: GridView.builder(
                          itemCount: Menu.length,
                          gridDelegate:
                              new SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2),
                          itemBuilder: (context, index) {
                            return Container(
                                margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            Color.fromRGBO(38, 166, 153, 100),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(10)),
                                child: GestureDetector(
                                  onTap: () {
                                    if (Menu[index].nombre == "Estadísticas") {
                                      Navigator.pushReplacementNamed(
                                          context, 'statistic');
                                    }
                                    if (Menu[index].nombre == "Eventos") {
                                      Navigator.pushReplacementNamed(
                                          context, 'eventos');
                                    }
                                    if (Menu[index].nombre == "Asistencia") {
                                      Navigator.pushReplacementNamed(
                                          context, 'asistencia');
                                    }
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset("assets/" + Menu[index].foto,
                                          width: 50),
                                      Text(Menu[index].nombre,
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontFamily: subtitulo,
                                            color: Colors.black,
                                          )),
                                    ],
                                  ),
                                ));
                          }),
                    ),
                  ),
                ]),
              ),
            ),
          ],
        ));
  }
}
