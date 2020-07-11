/*
 * @file home_page.js
 *
 * @brief Pantalla de presentación de la app
 * Brinda información acerca de los productos.
 * departamentos y de toda Bolivia.
 *
 * @author Josué Gutiérrez Quino <josuandroidg7@gmail.com>
 *
 */

import 'package:bohemian/src/bloc/provider.dart';
import 'package:bohemian/src/pages/home_page.dart';
import 'package:bohemian/src/pages/information_page.dart';
import 'package:bohemian/src/pages/initial_page.dart';
import 'package:bohemian/src/pages/producto_detalle.dart';
import 'package:flutter/material.dart';
 
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp( MyApp() );
} 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: '/',
        routes: {
          '/'       : ( BuildContext context ) => InitialPage(),
          'home'    : ( BuildContext context ) => HomePage(),
          'detalle' : ( BuildContext context ) => ProductoDetalle(),
          'info'    : ( BuildContext context ) => InformationPage()
        },
      ),
    );
  }
}