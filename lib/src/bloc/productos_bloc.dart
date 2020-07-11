/*
 * @file productos_bloc.js
 *
 * @brief Productos bloc
 *
 * @author Josué Gutiérrez Quino <josuandroidg7@gmail.com>
 *
 */

import 'package:bohemian/src/models/product_model.dart';
import 'package:bohemian/src/providers/productos_provider.dart';
import 'package:rxdart/rxdart.dart';

class ProductosBloc {
  final _productosController = BehaviorSubject<List<ProductModel>>();
  final _cargandoController = BehaviorSubject<bool>();

  final _productosProvider = ProductosProvider();
  Stream<List<ProductModel>> get productosStream => _productosController.stream;
  Stream<bool> get cargando => _cargandoController.stream;

  void cargarProductos() async {
    final productos = await _productosProvider.cargarProductos();

    _productosController.sink.add( productos );
  }

  dispose() {
    _productosController?.close();
    _cargandoController?.close();
  }
}