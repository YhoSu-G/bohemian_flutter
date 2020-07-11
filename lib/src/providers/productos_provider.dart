/*
 * @file productos_provider.js
 *
 * @brief Servicio de productos
 *
 * @author Josué Gutiérrez Quino <josuandroidg7@gmail.com>
 *
 */

import 'dart:convert';

import 'package:bohemian/src/models/product_model.dart';
import 'package:http/http.dart' as http;

class ProductosProvider {

  Future<List<ProductModel>> cargarProductos() async {
    final url = 'http://192.168.0.104:3000/bohemian/productos/obtener';

    http.Response resp = await http.get( 
      url,
      headers: {
        "Accept": "application/json",
      },
    );
    final Map<String, dynamic> decodedData = json.decode( resp.body );
    final List<ProductModel> productos = new List();
    print( decodedData ); 
    if ( decodedData['status'] == 'nok' ) {
      return [];
    } 
    decodedData['data'].forEach( ( producto ) {
      final prodTemp = ProductModel.fromJson( producto );
      productos.add( prodTemp );
    });
    return productos;
  }

}