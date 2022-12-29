import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app_3/theme/app_theme.dart';
import 'dart:async';

class AsistenciaScreen extends StatefulWidget {
  const AsistenciaScreen({Key? key}) : super(key: key);

  @override
  State<AsistenciaScreen> createState() => _AsistenciaScreenState();
}

class _AsistenciaScreenState extends State<AsistenciaScreen> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('usuarios').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Algo ha ido mal...');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        return Scaffold(
          appBar: AppBar(
            actions: [
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, 'home');
                      },
                      icon: Icon(Icons.home)),
                  IconButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, 'statistic');
                      },
                      icon: Icon(Icons.emoji_events_sharp)),
                ],
              )
            ],
            centerTitle: false,
            title: Text('Asistencias del mes'),
            backgroundColor: AppTheme.primary,
          ),
          body: ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              return Column(
                children: [
                  Card(
                    child: ListTile(
                      title: Text('Nombres y apellidos',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),
                      tileColor: AppTheme.primary,
                      trailing: Text('# de asistencias',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: Text(data['nombre'],
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17)),
                      subtitle: Text(data['categoria']),
                      trailing: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Text(data['asistencias'],
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18)),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
