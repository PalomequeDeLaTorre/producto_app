import 'dart:convert';

class Producto {
  bool disponible;
  String nombre;
  double precio;
  String? imagen;
  String? id;

  Producto({
    required this.disponible,
    required this.nombre,
    required this.precio,
    this.imagen,
    this.id
  });

  factory Producto.fromJson(String str) => Producto.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Producto.fromMap(Map<String, dynamic> json) => Producto(
    disponible: json["disponible"],
    nombre: json["nombre"],
    precio: json["precio"].toDouble(),
    imagen: json["imagen"],
  );

  Map<String, dynamic> toMap() => {
    "disponible": disponible,
    "nombre": nombre,
    "precio": precio,
    "imagen": imagen,
  };

  Producto copy() => Producto(
    disponible: this.disponible,
    nombre: this.nombre,
    precio: this.precio,
    imagen: this.imagen,
    id: this.id
);
}