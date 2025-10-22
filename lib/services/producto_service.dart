import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';

import 'package:productos_app/models/producto_model.dart';

import 'package:http/http.dart' as http;

class ProductoService  extends ChangeNotifier {
  final String _baseUrl = 'productosbd-99253-default-rtdb.firebaseio.com';
 
  final List<Producto> productos = [];

  bool isLoading = true;
  bool isSaving = false;

  Producto? productoSeleccionado;

  //constructor
  ProductoService(){
    this.obtenerProductos();
  }

  //método para obtener los productos de la BD
  Future obtenerProductos() async {
    this.isLoading = true;
    notifyListeners();
    final url = Uri.https(_baseUrl, 'productos.json');
    final resp = await http.get(url);
    final Map<String, dynamic> productosMap = json.decode(resp.body);
    //print(productosMap);

    //recorremos el mapa de la respuesta y vamos agregamos 
    //productos a la lista
    productosMap.forEach((key, value) {
      final tempProducto = Producto.fromMap(value);
      tempProducto.id = key;
      this.productos.add(tempProducto);
    });

    this.isLoading = false;
    notifyListeners();

    return this.productos;
  }

  //método para actualizar productos
  Future<String> updateProducto(Producto producto) async {
    final url = Uri.https(_baseUrl, 'productos/${producto.id}.json');
    final resp = await http.put(
      url, 
      body: producto.toJson()
      );
    
    final decodedData = resp.body;
    print(decodedData);

    //actualizar el listado de productos
    final index = 
      this.productos.indexWhere((element) => element.id == producto.id);
    
    this.productos[index] = producto;

    return producto.id!;
  }

  //método para crear un nuevo producto o actualizar

  Future crearOActualizarProducto(Producto producto) async {
    isSaving = true;
    notifyListeners();

    if (producto.id == null) {
      //producto nuevo
    } else {
      //producto existente
      await updateProducto(producto);
    }

    isSaving = false;
    notifyListeners();
  }
}