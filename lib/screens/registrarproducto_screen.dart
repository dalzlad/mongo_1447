import 'package:flutter/material.dart';
import 'package:mongo_1447/models/productos.dart';
import 'package:mongo_1447/mongodb.dart' ;
import 'package:mongo_dart/mongo_dart.dart'as mongo_dart;

class RegistrarProductoScreen extends StatefulWidget {
  const RegistrarProductoScreen({super.key});

  @override
  State<RegistrarProductoScreen> createState() => _RegistrarProductoScreenState();
}

class _RegistrarProductoScreenState extends State<RegistrarProductoScreen> {
  final codigo = TextEditingController();

  final nombre = TextEditingController();

  final precio = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Registrar Producto'),
      ),

      body: Padding(padding: EdgeInsets.all(10),
      child:Column(
        children: [
          TextFormField(controller: codigo),
          const SizedBox(height: 10,),
          TextFormField(controller: nombre),
          const SizedBox(height: 10,),
          TextFormField(controller: precio),
          const SizedBox(height: 10,),
          ElevatedButton(onPressed: () {
            print(codigo.text);
            insertarProducto(int.parse(codigo.text), nombre.text, int.parse(precio.text));
          }, child: Text('Registrar'))
        ],
      ),
      )

     
    );
  }
}

Future<void> insertarProducto(codigo, nombre, precio) async{
    final id = mongo_dart.ObjectId();
    final datos = Productos(id:id, codigo: codigo, nombre:nombre, precio:precio);
    print(datos.toJson());
    await Mongodb.insertar(datos);
}