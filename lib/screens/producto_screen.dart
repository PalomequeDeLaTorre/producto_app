import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:productos_app/providers/producto_form_provider.dart';
import 'package:productos_app/services/producto_service.dart';
import 'package:productos_app/widgets/producto_imagen.dart';
import 'package:provider/provider.dart';

class ProductoScreen extends StatelessWidget {
  const ProductoScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final productoService = Provider.of<ProductoService>(context);

    //return _ProductoScreenBody(productoService: productoService);
    return ChangeNotifierProvider(
      create: (context) => 
      ProductoFormProvider(productoService.productoSeleccionado!),
      child: _ProductoScreenBody(productoService: productoService),
    );
  }
}

class _ProductoScreenBody extends StatelessWidget {
  const _ProductoScreenBody({
    super.key,
    required this.productoService,
  });

  final ProductoService productoService;

  @override
  Widget build(BuildContext context) {
    final productoForm = Provider.of<ProductoFormProvider>(context);


    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [ 
              Stack(
                children: [
                  ProductoImagen(
                    imagenUrl: productoService.productoSeleccionado?.imagen,  
                  ),
                  Positioned(
                    top: 60,
                    left: 20,
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios_new, 
                        size: 40, 
                        color: Colors.white,
                        ),
                      onPressed: () => Navigator.of(context).pop(), 
                    ),
                  ),
                  Positioned(
                    top: 60,
                    right: 20,
                    child: IconButton(
                      icon: Icon(
                        Icons.camera_alt_outlined, 
                        size: 40, 
                        color: Colors.white,
                        ),
                      onPressed: () {
                      }, 
                    ),
                  ),
                ],
              ),
              _ProductoForm(),
              SizedBox(height: 100),
            ],
          ),
         ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save_outlined),
        onPressed: () async {
          //productoForm.isValidForm();
          if (!productoForm.isValidForm()) return;
          
          await productoService.crearOActualizarProducto(productoForm.producto);
        },
      ),
    );
  }
}

class _ProductoForm extends StatelessWidget {
  const _ProductoForm({super.key});

@override
Widget build(BuildContext context) {

  final productoForm = Provider.of<ProductoFormProvider>(context);
  final producto = productoForm.producto;

  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 10),
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      //height: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(45),
          bottomRight: Radius.circular(45),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 7),
          ),
        ],
      ),
      child: Form(
        key: productoForm.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              SizedBox(height: 10,),
              TextFormField(
                initialValue: producto.nombre,
                onChanged: (value) => producto.nombre = value,
                validator: (value) {
                  if (value == null || value.length < 1) {
                    return 'El nombre es obligatorio';
                  }
                },
                decoration: InputDecoration(
                  labelText: 'Nombre del producto',
                  hintText: 'Nombre del producto',
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.deepPurple
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.deepPurple,
                      width: 2
                    ),
                  ),
                  labelStyle: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
              SizedBox(height: 15,),
              TextFormField(
                initialValue: '${producto.precio}',
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))
                ],
                onChanged: (value) {
                  if (double.tryParse(value) == null) {
                    producto.precio = 0;
                  } else {
                    producto.precio = double.parse(value);
                  }
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Precio',
                  hintText: '\$150.00',
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.deepPurple
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.deepPurple,
                      width: 2
                    ),
                  ),
                  labelStyle: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
                SizedBox(height: 15,),
                SwitchListTile(
                  value: producto.disponible, 
                  title: Text('Disponible'),
                  activeColor: Colors.indigo,
                  onChanged: (value) {
                    productoForm.updateDisponible(value);
                  },
                ),
                SizedBox(height: 15,),
            ],
         ),
      ),
    ),
  );
 }
}