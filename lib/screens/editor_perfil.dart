import 'dart:io';

import 'package:app_3/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:app_3/theme/app_theme.dart';

class EditorPage extends StatefulWidget {
  const EditorPage({Key? key}) : super(key: key);

  @override
  State<EditorPage> createState() => _EditorPageState();
}

class _EditorPageState extends State<EditorPage> {
  File? imagen;
  final picker = ImagePicker();
  Future selImagen(op) async {
    var pickedFile;

    if (op == 1) {
      pickedFile = await picker.getImage(source: ImageSource.camera);
    } else {
      pickedFile = await picker.getImage(source: ImageSource.gallery);
    }

    setState(() {
      if (pickedFile != null) {
        imagen = File(pickedFile.path);
      } else {
        print("No selecciono ninguna foto");
      }
    });
  }

  opciones(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: EdgeInsets.all(0),
            content: SingleChildScrollView(
                child: Column(
              children: [
                InkWell(
                    onTap: () {
                      selImagen(1);
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom:
                                  BorderSide(width: 1, color: Colors.grey))),
                      child: Row(
                        children: [
                          Expanded(
                              child: Text(
                            'Tomar una foto',
                            style: TextStyle(fontSize: 19),
                          )),
                          Icon(Icons.camera_alt)
                        ],
                      ),
                    )),
                InkWell(
                    onTap: () {
                      selImagen(2);
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom:
                                  BorderSide(width: 1, color: Colors.grey))),
                      child: Row(
                        children: [
                          Expanded(
                              child: Text(
                            'Seleccione una foto',
                            style: TextStyle(fontSize: 19),
                          )),
                          Icon(Icons.image_search_outlined)
                        ],
                      ),
                    )),
                InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: AppTheme.primary,
                          border: Border(
                              bottom:
                                  BorderSide(width: 1, color: Colors.grey))),
                      child: Row(
                        children: [
                          Expanded(
                              child: Text(
                            'Cancelar',
                            style: TextStyle(fontSize: 19, color: Colors.white),
                          )),
                          Icon(Icons.exit_to_app, color: Colors.white)
                        ],
                      ),
                    ))
              ],
            )),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    //final GlobalKey<FormState> myFormKey = GlobalKey<FormState>();
    final Map<String, String> formValues = {
      'nombre': 'Sebastián Felipe Upegui Mora',
      'usuario': 'sebastian.upegui',
      'descripcion': 'Atleta',
    };
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pushReplacementNamed(context, 'perfil');
            },
          ),
          title: Text('Editar perfil'),
          centerTitle: true,
          backgroundColor: AppTheme.primary),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                imagen == null
                    ? Center()
                    : Image.file(imagen!, width: 160, height: 160),
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(AppTheme.primary)),
                    onPressed: () {
                      opciones(context);
                    },
                    child: Text('Seleccione una foto de perfil',
                        style: TextStyle(fontSize: 20))),
                SizedBox(height: 30),
                Form(
                  child: Column(
                    children: [
                      CustomInputField(
                          labelText: 'Nombre',
                          hintText: 'Sebastián Felipe Upegui Mora',
                          formProperty: 'nombre',
                          formValues: formValues),
                      SizedBox(height: 30),
                      CustomInputField(
                          labelText: 'Nombre de usuario',
                          hintText: 'sebastian.upegui',
                          formProperty: 'usuario',
                          formValues: formValues),
                      SizedBox(height: 30),
                      CustomInputField(
                          labelText: 'Breve descripción',
                          hintText: 'Atleta',
                          formProperty: 'descripcion',
                          formValues: formValues),
                      SizedBox(height: 30),
                      ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(AppTheme.primary)),
                        child: SizedBox(
                          width: double.infinity,
                          child: Center(child: Text('Guardar')),
                        ),
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, 'perfil');
                        },
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
