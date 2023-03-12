import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../../add_instrument/models/instrument.dart';

class InstrumentosProvider extends ChangeNotifier {
  var db = FirebaseFirestore.instance;

  final List<Instrumento> listaInstrumentos = [];
  List<Instrumento> _carInstrumentos = [];

  Future<List<Instrumento>> getInstruments() async {
    final snapshot = await db.collection("Instrumentos").get();
    if (snapshot.docs.isNotEmpty) {
      for (var doc in snapshot.docs) {
        var data = doc.data();
        if (data != null) {
          listaInstrumentos.add(Instrumento.fromJson(data));
        }
      }
    }
    return listaInstrumentos;
  }

  List<Instrumento> get carInstruments => _carInstrumentos;
  addProductCar(Instrumento p) {
    bool existProduct = false;
    _carInstrumentos.forEach((instru) {
      if (p.nombre == instru.nombre) {
        instru.cantidad++;
        existProduct = true;
      }
    });
    if (!existProduct) {
      _carInstrumentos.add(p);
    }
    notifyListeners();
  }
}
