import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:app_3/theme/app_theme.dart';

class MarcarAsistencia extends StatefulWidget {
  @override
  _MarcarAsistenciaState createState() => _MarcarAsistenciaState();
}

class _MarcarAsistenciaState extends State<MarcarAsistencia> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('usuarios').snapshots();

  //double _sliderValue = 100;
  bool _sliderEnabled = true;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pushReplacementNamed(context, 'asistencia');
              },
            ),
            centerTitle: true,
            title: Text('Registro de asistencia'),
            backgroundColor: AppTheme.primary,
          ),
          body: ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              return Card(
                child: CheckboxListTile(
                  onChanged: (bool? value) {
                    _sliderEnabled = value ?? false;
                    setState(() {});
                  },
                  value: _sliderEnabled,
                  title: Text(data['nombre']),
                  subtitle: Text(data['categoria']),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
