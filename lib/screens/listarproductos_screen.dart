import 'package:flutter/material.dart';
import 'package:mongo_1447/mongodb.dart';
import 'package:mongo_1447/models/productos.dart';
import 'package:mongo_dart/mongo_dart.dart'as mongo_dart;


class ListarProductosScreen extends StatefulWidget {
  const ListarProductosScreen({super.key});

  @override
  State<ListarProductosScreen> createState() => _ListarProductosScreenState();
}

class _ListarProductosScreenState extends State<ListarProductosScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('ListarProductos'),
        elevation: 0,
      ),

      body:FutureBuilder(
        future: Mongodb.Listar(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
              return ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) {
                    final producto = Productos(
                      id:snapshot.data?[index]['_id'],
                      codigo:snapshot.data?[index]['codigo'],
                      nombre:snapshot.data?[index]['nombre'],
                      precio:snapshot.data?[index]['precio'],
                    );
                      print(snapshot.data?[index]['codigo']);
                      var imagen = snapshot.data?[index]['codigo'];
                      return(Card(
                        child: ListTile(
                          leading: Image.asset('lib/assets/img/$imagen.jpg'),
                          title:Text(snapshot.data?[index]['nombre']),
                          subtitle:Text("${snapshot.data?[index]['precio']}"),
                          trailing: const Icon(Icons.abc_sharp),

                          onTap: () {
                          Navigator.push(context, 
                          MaterialPageRoute(builder: (context) => 
                            EditarProductoScreen(producto)
                                  ,)  );
                          },   

                        ),
                      ));
                    }
              );
          }else if (snapshot.hasError) {
                return Text("${snapshot.error}");
          }
           return const CircularProgressIndicator();
        },
      )

    );
  }
}

class EditarProductoScreen extends StatelessWidget {
  
  final Productos producto;
  EditarProductoScreen(this.producto, {super.key});

  final codigo = TextEditingController();

  final nombre = TextEditingController();

  final precio = TextEditingController();

  @override
  Widget build(BuildContext context) {
    codigo.text = producto.codigo.toString();
    nombre.text = producto.nombre.toString();
    precio.text = producto.precio.toString();
    return Scaffold(
      appBar: AppBar(
        title:const Text('Editar Producto'),
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
            actualizarProducto(producto.id,int.parse(codigo.text), nombre.text, int.parse(precio.text));
          }, child: Text('Actualizar'))
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


Future<void> actualizarProducto(id, codigo, nombre, precio) async{
    final datos = Productos(id:id, codigo: codigo, nombre:nombre, precio:precio);
    print(datos.toJson());
    await Mongodb.actualizar(datos);
}