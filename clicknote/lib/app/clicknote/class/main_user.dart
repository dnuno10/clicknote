import 'package:flutter/material.dart';

class MainUser extends ChangeNotifier {
  String idUser;
  String name;
  String email;

  MainUser({
  this.idUser = '',
  this.name = '',
  this.email = '',
});


  void updateID(String idUsuario) {
    idUsuario = idUsuario;
    notifyListeners(); // Notifica a los listeners sobre el cambio
  }
  // Método para actualizar el nombre
  void updateName(String nuevoNombre) {
    name = nuevoNombre;
    notifyListeners(); // Notifica a los listeners sobre el cambio
  }

  // Método para actualizar el correo
  void updateEmail(String nuevoCorreo) {
    email = nuevoCorreo;
    notifyListeners(); // Notifica a los listeners sobre el cambio
  }

  void resetUserData() {
      idUser = '';
      name = '';
      email = '';
      notifyListeners(); // Notifica a los listeners sobre los cambios
    }
    
  // Método para actualizar todos los valores principales
  void updateUserData({
    required String nuevoIdUsuario,
    required String nuevoNombre,
    required String nuevoCorreo,
  }) {
    idUser = nuevoIdUsuario;
    name = nuevoNombre;
    email = nuevoCorreo;
    notifyListeners(); // Notifica a los listeners sobre los cambios
  }
}
