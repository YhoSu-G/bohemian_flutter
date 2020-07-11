/*
 * @file initial_page.js
 *
 * @brief Página inicial de la app.
 *
 * @author Josué Gutiérrez Quino <josuandroidg7@gmail.com>
 *
 */

import 'package:bohemian/src/utils/constants.dart' as CONSTANTS;
import 'package:bohemian/src/utils/fonts_utils.dart' as FONTS;
import 'package:bohemian/src/utils/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InitialPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  Utils utils = new Utils();
  final size = MediaQuery.of(context).size;
    return Scaffold(
      body: LayoutBuilder(
        builder: ( context, constraints ) {
          if ( constraints.maxWidth > 600 ) {
            return _buildLayoutTablet( utils, context, size );
          } 
          return _buildLayoutMobile( utils, context, size );
        },
      )
    );
  }

  Widget _buildLayoutTablet(
    Utils utils, 
    BuildContext context, 
    Size size 
  ) {
    return Stack(
      children: [
        utils.buildBackground(),
        SafeArea(
          child: Padding(
            padding: EdgeInsets.only( top: size.height * 0.2 ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildBodyMessagesTablet( utils, context, size )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildBodyMessagesTablet(
    Utils utils, 
    BuildContext context, 
    Size size 
  ) {
    return Row(
      children: [
        Flexible(
          child: Text( 
            CONSTANTS.companyName,
            style: FONTS.title,
            textAlign: TextAlign.center,
          ),
        ),
        Flexible(
          child: Column(
            children: [
              CircleAvatar(
                radius: 70,
                backgroundColor: Colors.white.withOpacity( 0.5 ),
                child: Text(
                  '18+',
                  style: TextStyle(
                    fontSize: 55,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox( height: 15.0 ),
              Text( 
               'El consumo excesivo de alcohol es dañino para la salud. Venta prohibida a menores de 18 años de edad',
                style: FONTS.normal,
              ),
              SizedBox( height: 15.0 ),
              utils.builBtn(
                size: size, 
                onPressed: () {
                  Navigator.pushReplacementNamed(context, 'home' );
                }, 
                faIcon: FontAwesomeIcons.arrowRight, 
                textButton: 'Ingresar'
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _buildLayoutMobile( 
    Utils utils, 
    BuildContext context, 
    Size size 
  ) {
    return Stack(
        children: <Widget>[
          utils.buildBackground(),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric( horizontal: 40.0, vertical: 50 ),
              child: SingleChildScrollView(
                child: Center(
                  child: _bodyMessages( context, size, utils ),
                ),
              ),
            ),
          )
        ],
    );
  }


  Widget _bodyMessages( BuildContext context, Size size, Utils utils ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text( 
          CONSTANTS.companyName,
          style: FONTS.title,
          textAlign: TextAlign.center,
        ),
        SizedBox( height: 50 ),
        CircleAvatar(
          radius: 70,
          backgroundColor: Colors.white.withOpacity( 0.5 ),
          child: Text(
            '18+',
            style: TextStyle(
              fontSize: 55,
              color: Colors.black,
              fontWeight: FontWeight.bold,
              // fontFamily: FONTS.fontFamily
            ),
          ),
        ),
        SizedBox( height: 50 ),
        Text( 
          'El consumo excesivo de alcohol es dañino para la salud. Venta prohibida a menores de 18 años de edad',
          style: FONTS.normal,
        ),
        SizedBox( height: 70 ),
        utils.builBtn(
          size: size, 
          onPressed: () {
            Navigator.pushReplacementNamed(context, 'home' );
          }, 
          faIcon: FontAwesomeIcons.arrowRight, 
          textButton: 'Ingresar'
        )
      ],
    );
  }

}
