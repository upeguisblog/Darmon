import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:app_3/theme/app_theme.dart';
import 'package:app_3/modelos/fuentes.dart';

//void main() => runApp(const DummyScreen());

class DummyScreen extends StatelessWidget {
  const DummyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title:
                Text('Estadísticas', style: TextStyle(fontFamily: subtitulo)),
            backgroundColor: AppTheme.primary),
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              FadeInLeft(
                  child: MaterialButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, 'statistic');
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      disabledColor: Colors.grey,
                      elevation: 0,
                      color: AppTheme.primary,
                      child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 2, vertical: 9),
                          child: Text(
                            'Visualizar estadísticas del mes',
                            style: TextStyle(
                                color: Colors.white, fontFamily: subtitulo),
                          )))),
              FadeInUp(child: const Square()),
              FadeInDown(child: const Square()),
              FadeInRight(child: const Square()),
            ],
          ),
        ),
      ),
    );
  }
}

class Square extends StatelessWidget {
  const Square({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      color: Colors.blueAccent,
    );
  }
}
