/*
 * @file provider.js
 *
 * @brief Provider Bloc 
 *
 * @author Josué Gutiérrez Quino <josuandroidg7@gmail.com>
 *
 */

import 'package:bohemian/src/bloc/productos_bloc.dart';
import 'package:flutter/cupertino.dart';

class Provider extends InheritedWidget {
  final _productosBloc = new ProductosBloc();
  static Provider _instancia;

  factory Provider( { Key key, Widget child } ) {
    if ( _instancia == null ) {
      _instancia = Provider._internal(
        key: key,
        child: child
      );
    }
    return _instancia;
  }

  Provider._internal( { 
    Key key,
    Widget child
  }) : super( key : key, child: child );
  
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;
  static ProductosBloc productosBloc ( BuildContext context ) {
    return ( context.inheritFromWidgetOfExactType(Provider) as Provider )._productosBloc;
  }

}