/*
 * @file home_page.js
 *
 * @brief Pantalla de presentación de la app
 * Brinda información acerca de los productos.
 *
 * @author Josué Gutiérrez Quino <josuandroidg7@gmail.com>
 *
 */
import 'package:bohemian/src/bloc/productos_bloc.dart';
import 'package:bohemian/src/bloc/provider.dart';
import 'package:bohemian/src/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:bohemian/src/utils/widget_utils.dart';
import 'package:bohemian/src/utils/constants.dart' as GLB;


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    Utils utils = new Utils();
    final productosBloc = Provider.productosBloc(context);
    productosBloc.cargarProductos();
    return Scaffold(
      body: Stack(
        children: <Widget>[
          utils.buildBackground(),
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox( height: 40 ),
                _buildAppbar( size, context, utils ),
                _swiperProductos( context, size, productosBloc ),
              ],
            ),
          )
        ],
      ),
      
    );
  }
  
  Widget _buildAppbar( 
    Size size, 
    BuildContext context,
    Utils utils
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        SizedBox( width: 15.0 ),
        _buildTitle( utils ),
        IconButton(
           icon: Icon( Icons.info, color: Colors.white, size: 35,),
           onPressed: () {
             Navigator.pushNamed(context, 'info' );
           },
        ),
      ],
    );
  }

  Widget _buildTitle( Utils utils ) {
    return Center(
      child: utils.buildText(
        typeText: 'subtitle',
        text: GLB.companyName,
        align: TextAlign.center
      ),
    );
  }

  Widget _swiperProductos( BuildContext context, Size size, ProductosBloc productosBloc ) {
    return StreamBuilder(
      stream: productosBloc.productosStream,
      builder: (BuildContext context, AsyncSnapshot<List<ProductModel>> snapshot) {
        if ( snapshot.hasData ) {
          return CardSwiperWidget( productos: snapshot.data );
        } else {
          return Container(
            height: 300,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}

class CardSwiperWidget extends StatelessWidget {

  final List<ProductModel> productos;
  CardSwiperWidget( {@required this.productos });

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric( vertical: 25.0 ),
      child: Swiper(
        itemCount: productos.length,
        layout: SwiperLayout.CUSTOM,
        customLayoutOption: new CustomLayoutOption(
          startIndex: -1,
          stateCount: 3
        ).addRotate([
          -45.0/180,
          0.0,
          45.0/180
        ]).addTranslate([
          new Offset(-370.0, -40.0),
          new Offset(0.0, 0.0),
          new Offset(370.0, -40.0)
        ]),
        itemHeight: _screenSize.height * 0.7,
        itemWidth: _screenSize.width * 0.65,
        itemBuilder: (BuildContext context, int index) {
          return Hero(
            tag: productos[index].idProducto,
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed( context, 'detalle', arguments: productos[index] );
              },
              child: Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular( 15.0 ),
                      color: Color( 0xFF424242 ).withOpacity( 0.5 )
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Flexible(
                          child: Container(
                            padding: EdgeInsets.symmetric( vertical: 50.0, horizontal: 10.0 ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular( 20.0 ),
                              child: FadeInImage(
                                placeholder: AssetImage( 'assets/no-image.jpg' ),
                                image: NetworkImage( productos[index].photo ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox( width: 15.0 ),
                        Flexible(
                          child: Text( 
                            productos[index].producto,
                            style: TextStyle(
                              fontSize: 50,
                              color: Colors.white,
                              fontFamily: 'Yellowtail'
                            ), 
                          ),
                        )
                      ],
                    ),
                  ),
                  Positioned( 
                    right: 0,
                    bottom: 30,
                    child: Container(
                      height: 50,
                      width: 100,
                      padding: EdgeInsets.symmetric( horizontal: 10, vertical: 5 ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular( 5.0 ),
                          bottomLeft: Radius.circular( 5.0 ),
                        ),
                        color: Colors.black
                      ),
                      child: Row(
                        children: <Widget>[
                          Text( 
                            'Bs.',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Yellowtail'
                            ), ),
                          Text( 
                            productos[index].costoUnitario.toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 35.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Yellowtail'
                            ), 
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        }, 
      ),
    );
  }
}