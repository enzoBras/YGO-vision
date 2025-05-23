import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';



/// widget pour afficher le widget de chargement de données dans un futurebuilder (par exemple)
Widget widgetCercleProgression() {
  return const Center(
    child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 20),
          Text(
            'Chargement en cours...',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              inherit: false,
              fontSize: 30.0,
            ),
          ),
        ]
    ),
  );
}

/// widget pour afficher les erreur dans un futurebuilder (par exemple)
Widget widgetError() {
  return const Center(
    child: Text(
      'Une erreur est survenue...',
      style: TextStyle(fontWeight: FontWeight.bold, inherit: false, fontSize: 32.0),
    ),
  );
}

void callToast(msg) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      textColor: Colors.white,
      fontSize: 16.0
  );
}