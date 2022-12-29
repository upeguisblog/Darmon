import 'package:flutter/material.dart';
import 'package:app_3/modelos/eventos.dart';
import 'package:app_3/theme/app_theme.dart';
import 'package:lottie/lottie.dart';
import 'package:app_3/modelos/fuentes.dart';

class Pantallaeventos extends StatefulWidget {
  Pantallaeventos({Key? key}) : super(key: key);

  @override
  State<Pantallaeventos> createState() => _PantallaeventosState();
}

class _PantallaeventosState extends State<Pantallaeventos> {
  final controller = TextEditingController();
  List<Evento> eventos = allEvents;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, 'home');
              },
              icon: Icon(Icons.arrow_back_ios)),
          actions: [
            IconButton(
              icon: Icon(Icons.calendar_month),
              onPressed: () {
                Navigator.pushReplacementNamed(context, 'calendario');
              },
            )
          ],
          title: Text('Eventos', style: TextStyle(fontFamily: titulo)),
          centerTitle: true,
          backgroundColor: AppTheme.primary),
      body: Column(
        children: [
          Container(
              height: 150,
              color: Colors.white,
              child: Row(
                children: [
                  Lottie.asset('assets/trophy.json', height: 200),
                  SizedBox(width: 10),
                  Center(
                      child: Text("Próximos eventos: ",
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: titulo,
                            fontSize: 20,
                          ))),
                ],
              )),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: "Busque un evento",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: AppTheme.primary))),
              onChanged: searchEvent,
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
                itemCount: eventos.length,
                itemBuilder: (context, index) {
                  final evento = eventos[index];

                  return Card(
                    child: ListTile(
                        dense: true,
                        trailing:
                            Icon(Icons.arrow_forward_ios_outlined, size: 15),
                        leading: Image.network(evento.urlImage,
                            fit: BoxFit.fill, width: 50, height: 50),
                        title: Text(evento.title,
                            style: TextStyle(fontFamily: titulo)),
                        subtitle: Text(evento.lugar),
                        onTap: () {
                          if (eventos[index].title ==
                              'JUEGOS DEPORTIVOS SURAMERICANOS 2022') {
                            Navigator.pushReplacementNamed(
                                context, 'inscripcion');
                          }
                        }),
                  );
                }),
          ),
        ],
      ),
    );
  }

  void searchEvent(String query) {
    final suggestions = allEvents.where((evento) {
      final eventoTitle = evento.title.toLowerCase();
      final input = query.toLowerCase();

      return eventoTitle.contains(input);
    }).toList();

    setState(() => eventos = suggestions);
  }
}
