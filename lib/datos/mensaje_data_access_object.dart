import 'package:firebase_database/firebase_database.dart';
import 'mensaje.dart';

class MensajeDAO {
  final DatabaseReference _mensajeRef =
      FirebaseDatabase.instance.ref().child('mensajes');

  void guardarMensaje(Mensaje mensaje) {
    _mensajeRef.push().set(mensaje.toJson());
  }

  DatabaseReference getMensajes() {
    return _mensajeRef;
  }
}
