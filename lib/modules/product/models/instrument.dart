import 'dart:convert';

class Instrumento {
  String nombre;
  String tipo;
  String imagenUrl;
  String precio;
  String descripcion;
  Instrumento(
      {required this.nombre,
      required this.tipo,
      required this.imagenUrl,
      required this.precio,
      required this.descripcion});

  factory Instrumento.fromJson(Map<String, dynamic> json) {
    return Instrumento(
      nombre: json['nombre'],
      tipo: json['tipo'],
      imagenUrl: json['imagenUrl'],
      precio: json['precio'],
      descripcion: json['descripcion'],
    );
  }
}
