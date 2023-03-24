import 'package:flutter/material.dart';

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
          SizedBox(height: 10,),
          TextFormField(controller: nombre),
          SizedBox(height: 10,),
          TextFormField(controller: precio),
          SizedBox(height: 10,),
          ElevatedButton(onPressed: () {
            print(codigo.text);
          }, child: Text('Registrar'))
        ],
      ),
      )

     
    );
  }
}