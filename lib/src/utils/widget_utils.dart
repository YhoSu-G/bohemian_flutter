/*
 * @file widget_utils.js
 *
 * @brief Widget re utilizables
 *
 * @author Josué Gutiérrez Quino <josuandroidg7@gmail.com>
 *
 */

import 'package:bohemian/src/utils/fonts_utils.dart' as FONTS;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class Utils {

  Widget buildText( 
    { 
      @required String text,
      String typeText = 'normal', 
      TextAlign align = TextAlign.justify,
    } 
    ) {

    TextStyle finalStyle;
    switch( typeText ) {
      case 'normal':
        finalStyle = FONTS.normal;
      break;
      case 'normal_italic':
        finalStyle = FONTS.normalYelloTail;
      break;
      case 'subtitle':
        finalStyle = FONTS.subtitle;
      break;
      case 'title':
        finalStyle = FONTS.title;
      break;
    }    
    return Text(
      text,
      textAlign: align,
      style: finalStyle,
    );

  }

  Widget buildBackground() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Image(
        fit: BoxFit.cover,
        image: AssetImage( 'assets/background.png' ),
      ),
    );
  }

  Widget builBtn( 
    {
      @required Size size,
      @required Function onPressed,
      @required IconData faIcon,
      @required String textButton
    }   
    ) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 60,
        width: size.width * 0.7,
        margin: EdgeInsets.symmetric(horizontal: 40.0, vertical: 15.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Colors.brown.withOpacity(0.8),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.black26,
                  offset: Offset(0.0, 4.0),
                  spreadRadius: 2.0)
            ]
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            FaIcon(
              faIcon,
              color: Colors.white,
              size: 30,
            ),
            buildText(
              text: textButton,
              typeText: 'subtitle' 
            ),
            SizedBox(),
          ],
        ),
      ),
    );
  }
}
