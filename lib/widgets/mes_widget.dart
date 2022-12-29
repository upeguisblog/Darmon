//import 'dart:math';

//import 'package:app_3/widgets/linear_charts.dart';
import 'package:app_3/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
//import 'package:app_3/theme/app_theme.dart';
//import 'package:app_3/widgets/estadisticas.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MesWidget extends StatefulWidget {
  final List<DocumentSnapshot> docs;
  final double total;
  final List<double> perDay;
  final Map<String, double> categories;

  MesWidget({
    Key? key,
    required this.docs,
  })  : total = docs.map((doc) => doc['valor']).fold(0.0, (a, b) => a + b),
        perDay = List.generate(20, (int index) {
          return docs
              .where((docs) => docs['dia'] == (index + 1))
              .map((doc) => doc['valor'])
              .fold(0.0, (a, b) => a + b);
        }),
        categories = docs.fold({}, (Map<String, double> map, document) {
          if (!map.containsKey(document['categoria'])) {
            map[document['categoria']] = 0.0;
          }

          map[document['categoria']] = document['valor'] + 1.0 - 1.0;
          return map;
        }),
        super(key: key);

  @override
  _MesWidgetState createState() => _MesWidgetState();
}

class _MesWidgetState extends State<MesWidget> {
  @override
  Widget build(BuildContext context) {
    print(widget.categories);
    return Expanded(
      child: Column(
        children: [
          _textGastos(),
          _graph(),
          /*  LinearCharts(data: widget.perDay), */
          _listView()
        ],
      ),
    );
  }

  Widget _textGastos() {
    return Column(children: <Widget>[
      Text('\$${widget.total.toStringAsFixed(2)}',
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
      Text('Gastos totales',
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey))
    ]);
  }

  Widget _graph() {
    return Container(
      height: 250.0,
      child: GraphWidget(data: widget.perDay),
    );
  }

  Widget _listView() {
    return Expanded(
      child: ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          var key = widget.categories.keys.elementAt(index);
          var data = widget.categories[key];
          return _item(FontAwesomeIcons.cartShopping, key,
              100 * data! ~/ widget.total, data);
        },
        separatorBuilder: (BuildContext context, int index) {
          return Container();
        },
        itemCount: widget.categories.keys.length,
      ),
    );
  }

  Widget _item(IconData icon, String name, int percent, double value) {
    return ListTile(
      leading: Icon(
        icon,
        size: 32.0,
      ),
      title: Text(
        name,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
      ),
      subtitle: Text(
        "$percent% de los gastos totales",
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.blueGrey,
        ),
      ),
      trailing: Container(
        decoration: BoxDecoration(
          color: Colors.blueAccent.withOpacity(0.2),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "\$$value",
            style: TextStyle(
              color: Colors.blueAccent,
              fontWeight: FontWeight.w500,
              fontSize: 16.0,
            ),
          ),
        ),
      ),
    );
  }
}
