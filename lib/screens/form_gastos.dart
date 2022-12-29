import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:app_3/theme/app_theme.dart';

class FormGastosScreen extends StatefulWidget {
  FormGastosScreen({Key? key}) : super(key: key);

  @override
  State<FormGastosScreen> createState() => _FormGastosScreenState();
}

class _FormGastosScreenState extends State<FormGastosScreen> {
  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();

    Future createUser({
      required String categoria,
      /*  required int dia,
        required int mes,
        required int valor */
    }) async {
      final docUser = FirebaseFirestore.instance.collection('gastos').doc();

      final user = Gastos(
        categoria: categoria, /* dia: dia, mes: mes, valor: valor */
      );

      final json = user.toJson();

      await docUser.set(json);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Registro de gastos'),
        centerTitle: true,
        backgroundColor: AppTheme.primary,
      ),
      body: Container(
          child: Form(
              child: Column(
        children: [
          TextFormField(
            controller: controller,
            keyboardType: TextInputType.text,
            autocorrect: false,
            decoration: InputDecoration(
                labelText: 'Ingrese un nuevo gasto',
                labelStyle: TextStyle(color: AppTheme.primary),
                prefixIcon: Icon(Icons.sports_outlined)),
          ),
          SizedBox(height: 10),
          TextFormField(
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              autocorrect: false,
              decoration: InputDecoration(
                  labelText: 'Ingrese día del mes (Ejemplo: 02)',
                  labelStyle: TextStyle(color: AppTheme.primary),
                  prefixIcon: Icon(Icons.timelapse_outlined))),
          SizedBox(height: 10),
          TextFormField(
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              autocorrect: false,
              decoration: InputDecoration(
                  labelText: 'Ingrese el mes (Ejemplo: 10)',
                  labelStyle: TextStyle(color: AppTheme.primary),
                  prefixIcon: Icon(Icons.personal_injury_outlined))),
          SizedBox(height: 10),
          TextFormField(
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              autocorrect: false,
              decoration: InputDecoration(
                  labelText: 'Ingrese el valor del gasto (Ejemplo: 100000.00)',
                  labelStyle: TextStyle(color: AppTheme.primary),
                  prefixIcon: Icon(Icons.personal_injury_outlined))),
          SizedBox(height: 50),
          MaterialButton(
            onPressed: () {
              /* FirebaseFirestore.instance
                  .collection('gastos')
                  .add({'categoria': });
              Navigator.pushReplacementNamed(context, 'statistic'); */

              final categoria = controller.text;

              createUser(categoria: categoria);
              Navigator.pushReplacementNamed(context, 'statistic');
            },
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            disabledColor: Colors.grey,
            elevation: 0,
            color: AppTheme.primary,
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                child: Text(
                  'Registrar',
                  style: TextStyle(color: Colors.white),
                )),
          ),
        ],
      ))),
    );
  }
}

class Gastos {
/*   String id; */
  String categoria;
/*   final int dia;
  final int mes;
  final int valor; */

  Gastos({
    /* this.id = '' ,*/
    required this.categoria,
    /*   required this.dia,
      required this.mes,
      required this.valor */
  });

  Map<String, dynamic> toJson() => {
        /* 'id': id, */
        'categoria': categoria,
        /*  'dia': dia,
        'mes': mes,
        'valor': valor */
      };
}
