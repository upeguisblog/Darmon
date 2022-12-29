import 'dart:io';

//import 'package:app_3/responsive/dimensions.dart';
//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app_3/theme/app_theme.dart';
import 'package:app_3/modelos/elementos_perfil.dart';
//import 'package:app_3/screens/editor_perfil.dart';
//import 'package:app_3/responsive/responsive_layout.dart';
import 'package:app_3/modelos/fuentes.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? imagen;
  List<Perfil> elementos = allElements;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pushReplacementNamed(context, 'home');
            },
          ),
          title:
              Text('Perfil personal', style: TextStyle(fontFamily: subtitulo)),
          centerTitle: true,
          backgroundColor: AppTheme.primary),
      body: Column(
        children: [
          Container(
              height: 200,
              color: Colors.grey[200],
              child: Row(children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                  ),
                  child: CircleAvatar(
                    maxRadius: 60,
                    backgroundImage: AssetImage('assets/profile1.png'),
                  ),
                ),
                Padding(padding: EdgeInsets.only(left: 20)),
                Column(
                  children: [
                    SizedBox(
                      height: 60,
                    ),
                    Text(
                      'John Doe',
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.black,
                          fontFamily: titulo),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5, right: 20),
                      child: TextButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(AppTheme.primary)),
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, 'editor');
                        },
                        child: Text('Editar Perfil',
                            style: TextStyle(
                                fontFamily: titulo, color: Colors.white)),
                      ),
                    )
                  ],
                ),
              ])),
          Expanded(
            child: ListView(children: [
              Card(
                child: ListTile(
                    onTap: () {},
                    trailing: Icon(Icons.arrow_forward_ios_outlined, size: 15),
                    leading: const Icon(Icons.headset_mic_outlined),
                    title: Text('Contacto con soporte',
                        style: TextStyle(fontFamily: subtitulo))),
              ),
              Card(
                child: ListTile(
                    onTap: () {},
                    trailing: Icon(Icons.arrow_forward_ios_outlined, size: 15),
                    leading: const Icon(Icons.receipt),
                    title: Text('Privacidad',
                        style: TextStyle(fontFamily: subtitulo))),
              ),
              Card(
                child: ListTile(
                    onTap: () {},
                    trailing: Icon(Icons.arrow_forward_ios_outlined, size: 15),
                    leading: const Icon(Icons.info_outline_rounded),
                    title: Text('Acerca de Darmon',
                        style: TextStyle(fontFamily: subtitulo))),
              ),
              Card(
                child: ListTile(
                    onTap: () {},
                    trailing: Icon(Icons.arrow_forward_ios_outlined, size: 15),
                    leading: const Icon(Icons.logout_outlined),
                    title: Text('Cerrar sesión',
                        style: TextStyle(fontFamily: subtitulo))),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
