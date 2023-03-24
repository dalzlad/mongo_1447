import 'package:mongo_1447/context.dart';
import 'package:mongo_dart/mongo_dart.dart';

class Mongodb{
  static late Db db;
  static late DbCollection coleccion;

  static conexion() async{
    db = await Db.create(mongoURL);
    await db.open();
    coleccion = db.collection(nombreColeccion);
    await coleccion.insertOne({
      "codigo": 777,
      "nombre": 'Papaya',
      "precio": 3000
    });
  }
}