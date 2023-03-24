// To parse this JSON data, do
//
//     final productos = productosFromMap(jsonString);

import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart';

class Productos {
    Productos({
        required this.id,
        required this.codigo,
        required this.nombre,
        required this.precio,
    });

    ObjectId id;
    final int codigo;
    final String nombre;
    final int precio;

    factory Productos.fromJson(String str) => Productos.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Productos.fromMap(Map<String, dynamic> json) => Productos(
        id: json["_id"],
        codigo: json["codigo"],
        nombre: json["nombre"],
        precio: json["precio"],
    );

    Map<String, dynamic> toMap() => {
        "_id": id,
        "codigo": codigo,
        "nombre": nombre,
        "precio": precio,
    };
}
