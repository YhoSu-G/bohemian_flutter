/*
 * @file productos_detalle.js
 *
 * @brief Detalle de productos
 *
 * @author Josué Gutiérrez Quino <josuandroidg7@gmail.com>
 *
 */

import 'dart:io';
import 'package:bohemian/src/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductoDetalle extends StatefulWidget {
  @override
  _ProductoDetalleState createState() => _ProductoDetalleState();
}

class _ProductoDetalleState extends State<ProductoDetalle> {
  String codigoPais = '591';
  String numeroLocal = '60619409';
  int cantidadProductos = 0;
  @override
  Widget build(BuildContext context) {
    String numeroFinal = '$codigoPais$numeroLocal';
    final size = MediaQuery.of(context).size;
    final ProductModel producto = ModalRoute.of(context).settings.arguments;
    // print( producto );
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _customAppBar(producto, size),
          SliverList(
            delegate: SliverChildListDelegate([
              _productInfo(context, producto),
              _cantidadRow(context, producto, size),
              _btnPedido(context, producto, size, numeroFinal)
            ]),
          )
        ],
      ),
    );
  }

  Widget _cantidadRow(BuildContext context, ProductModel producto, Size size) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 100.0),
        height: 55.0,
        width: size.width * 0.5,
        decoration: BoxDecoration(
            color: Colors.grey, borderRadius: BorderRadius.circular(12.0)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              onPressed: () {
                setState(() {
                  cantidadProductos = cantidadProductos < 0 
                                      ? 0 
                                      : cantidadProductos - 1;
                });
              },
              icon: FaIcon(FontAwesomeIcons.minus, color: Colors.white),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                cantidadProductos < 0 ? '0' : cantidadProductos.toString(),
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  cantidadProductos++;                  
                });
              },
              icon: FaIcon(
                FontAwesomeIcons.plus,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _btnPedido(
      BuildContext context, ProductModel producto, Size size, String numero) {
    return GestureDetector(
      onTap: () {
        launchWhatsApp(
            message: 'Quisiera adquirir ${producto.producto}', phone: numero);
      },
      child: Container(
        height: 60,
        width: size.width * 0.7,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Colors.brown.withOpacity(0.8),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.black26,
                  offset: Offset(0.0, 4.0),
                  spreadRadius: 2.0)
            ]),
        margin: EdgeInsets.symmetric(horizontal: 40.0, vertical: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            FaIcon(
              FontAwesomeIcons.whatsapp,
              color: Colors.white,
              size: 30,
            ),
            Text(
              'SOLICITAR PEDIDO',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontFamily: 'Yellowtail',
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(),
          ],
        ),
      ),
    );
  }

  Widget _customAppBar(ProductModel producto, Size size) {
    return SliverAppBar(
      elevation: 1.0,
      backgroundColor: Colors.grey,
      expandedHeight: size.height * 0.3,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: EdgeInsets.symmetric(vertical: 40.0),
        collapseMode: CollapseMode.parallax,
        title: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                producto.producto,
                style: TextStyle(
                fontSize: 35, color: Colors.white, fontFamily: 'Yellowtail'),
              ),
              Container(
                  width: 100,
                  padding: EdgeInsets.symmetric( horizontal: 10.0, vertical: 0.0 ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular( 15.0 ),
                    color: Colors.black
                  ),
                  child: Row(
                    children: <Widget>[
                      Text(
                        'Bs.',
                        style: TextStyle(color: Colors.white, fontFamily: 'Yellowtail'),
                      ),
                      Text(
                        producto.costoUnitario.toString(),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 35.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Yellowtail'),
                      )
                    ],
                  ),
              )
              
            ],
          ),
        ),
        background: FadeInImage(
          image: AssetImage('assets/background.png'),
          placeholder: AssetImage('assets/loading.gif'),
          fit: BoxFit.cover,
        ),
      ),
    );
    
  }

  Widget _productInfo(BuildContext context, ProductModel producto) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
      child: Row(
        children: <Widget>[
          Hero(
            tag: producto.idProducto,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image(
                height: size.height * 0.4,
                // fit: BoxFit.contain,
                image: NetworkImage(
                  producto.photo,
                ),
              ),
            ),
          ),
          SizedBox(width: 20.0),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Descripción:',
                  style: TextStyle(
                      fontFamily: 'Yellowtail',
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0),
                ),
                Text(
                  producto.descripcion,
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Yellowtail',
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void launchWhatsApp({
    @required String phone,
    @required String message,
  }) async {
    String url() {
      return "whatsapp://send?phone=$phone&text=${Uri.parse(message)}";
    }

    if (await canLaunch(url())) {
      await launch(url());
    } else {
      throw 'Could not launch ${url()}';
    }
  }
}
