import 'dart:async';

import 'package:mongo_1447/context.dart';
import 'package:mongo_1447/models/productos.dart';
import 'package:mongo_dart/mongo_dart.dart';

class Mongodb{
  static late Db db;
  static late DbCollection coleccion;

  static conexion() async{
    db = await Db.create(mongoURL);
    await db.open();
    coleccion = db.collection(nombreColeccion);
    /*await coleccion.insertOne({
      "codigo": 777,
      "nombre": 'Papaya',
      "precio": 3000
    });
    */
  }

    static insertar(Productos producto) async {
      await coleccion.insertOne(producto.toMap());
      print(producto);
  } 

  
  static actualizar(Productos producto) async {
    var result = await coleccion.updateOne(where.eq('_id', producto.id), 
    modify.set('precio', producto.precio));
      //await coleccion.insertOne(producto.toMap());
      print(producto);
  } 


  static Future<List<Map<String, dynamic>>> Listar() async {
    try {
      final productos = await coleccion.find().toList();
      print(productos);
      return productos;
    } catch (e) {
      //print(e);
      return Future.value(e as FutureOr<List<Map<String, dynamic>>>?);
    }
  }

}