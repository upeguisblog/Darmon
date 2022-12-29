import 'package:app_3/modelos/eventos.dart';
import 'package:flutter/material.dart';
import 'package:app_3/theme/app_theme.dart';
import 'package:app_3/modelos/fuentes.dart';

class InscripcionScreen extends StatefulWidget {
  InscripcionScreen({Key? key}) : super(key: key);

  @override
  State<InscripcionScreen> createState() => _InscripcionScreenState();
}

class _InscripcionScreenState extends State<InscripcionScreen> {
  List<Evento> eventos = allEvents;

  @override
  Widget build(BuildContext context) {
    //final evento = eventos[index];
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, 'eventos');
                },
                icon: Icon(Icons.arrow_back_ios)),
            actions: [
              IconButton(
                icon: Icon(Icons.chat),
                onPressed: () {},
              )
            ],
            title: Text('Inscripcion de eventos'),
            centerTitle: true,
            backgroundColor: AppTheme.primary),
        body: Column(
          children: [
            Card(
              elevation: 10,
              child: ListTile(
                  leading: Image.network(
                      'https://pbs.twimg.com/media/FcqhoZfWYAE6odv?format=jpg&name=large'),
                  title: Text(
                    'JUEGOS DEPORTIVOS SURAMERICANOS 2022',
                    style: TextStyle(
                        fontSize: 20, fontFamily: titulo, color: Colors.black),
                  ),
                  subtitle: Text(
                    'Patinaje de Velocidad',
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: subtitulo,
                        color: Colors.black),
                  ),
                  trailing: Icon(Icons.info_outline_rounded)),
            ),
            Card(
                elevation: 10,
                child: Column(
                  children: [
                    ListTile(
                        title: Text('Categoría:',
                            style: TextStyle(fontFamily: titulo)),
                        subtitle: Text('Mayores',
                            style: TextStyle(fontFamily: titulo)),
                        leading: Icon(Icons.category_outlined)),
                    ListTile(
                        title: Text('Organizador:',
                            style: TextStyle(fontFamily: titulo)),
                        subtitle: Text('ODESUR'),
                        leading: Icon(Icons.account_balance_outlined)),
                    ListTile(
                        title: Text('Lugar:',
                            style: TextStyle(fontFamily: titulo)),
                        subtitle: Text('ASUNCIÓN - PARAGUAY'),
                        leading: Icon(Icons.map)),
                    Padding(
                      padding: const EdgeInsets.only(right: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: const Text('Inscribirse'),
                          ),
                        ],
                      ),
                    )
                  ],
                ))
          ],
        ));
  }
}
