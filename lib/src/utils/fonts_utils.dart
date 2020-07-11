/*
 * @file information_page.js
 *
 * @brief Estilos de letra
 *
 * @author Josué Gutiérrez Quino <josuandroidg7@gmail.com>
 *
 */
import 'package:flutter/material.dart';

String fontFamily = 'Yellowtail';
Color letterColor = Colors.white;

  
  TextStyle title = TextStyle(
    color         : letterColor,
    fontSize      : 50,
    fontFamily    : fontFamily,
    fontWeight    : FontWeight.bold,
    letterSpacing : 3,
  );

  TextStyle subtitle = TextStyle(
    color         : letterColor,
    fontSize      : 35,
    fontFamily    : fontFamily,
    fontWeight    : FontWeight.w500,
    // letterSpacing : 3
  );

  TextStyle normalYelloTail = TextStyle(
    color         : letterColor,
    fontSize      : 20,
    fontFamily    : fontFamily,
  );

  TextStyle normal = TextStyle(
    color         : letterColor,
  );