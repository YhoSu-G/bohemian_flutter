/*
 * @file information_page.js
 *
 * @brief Página de información de la app
 *
 * @author Josué Gutiérrez Quino <josuandroidg7@gmail.com>
 *
 */

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:bohemian/src/utils/widget_utils.dart';
import 'package:bohemian/src/utils/fonts_utils.dart' as FONTS;

class InformationPage extends StatefulWidget {
  @override
  _InformationPageState createState() => _InformationPageState();
}

class _InformationPageState extends State<InformationPage> {
  Set<Marker> _markers = {};

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final Utils utils = new Utils();
    _markers.add(Marker(
      markerId: MarkerId( 'Licoreria' ),
      position: LatLng(-16.481376, -68.120075),
      infoWindow: InfoWindow(
        title: "Bohemia",
        snippet: "",
      ),
    ));
    return Scaffold(
      body: Stack(
        children: <Widget>[
          utils.buildBackground(),
          SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
                child: Column(
                  children: <Widget>[
                    _buildAppBarInfo(),
                    _buildMessage( utils ),
                    SizedBox( height: 20.0 ),
                    _buildImgStayAtHome(),
                    SizedBox( height: 15.0 ),
                    _buildGoogleMaps( size ),
                    SizedBox( height: 15.0 ),
                    _buildTextDirection( utils ),
                    SizedBox( height: 15.0 ),
                    _buildBtnSocialNetwork(),
                    SizedBox( height: 100 ),
                    _buildCopyRight( utils ),
                    SizedBox( height: 5.0 ),
                    _buildContact( utils )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildImgStayAtHome() {
    return Image(
      image: AssetImage('assets/stayathome.png'),
    );
  }
  Widget _buildMessage( Utils utils ) {
    return utils.buildText(
      text: 'El consumo excesivo de alcohol es dañino para la salud. Venta prohibida a menores de 18 años de edad.\nLa comunicación de las marcas de bebidas con niveles de alcohol, son exclusivas para personas mayores de 18 años bajo la ley del Estado Plurinacional de Bolivia y se prohíbe compartir o/y reproducir el contenido a menores de edad. La venta de bebidas con niveles de alcohol se encuentran prohibidas a menores de 18 años.'
    );
  }

  Widget _buildContact( Utils utils ) {
    return utils.buildText(
      text: 'Contacto con el programador: josuandroidg7@gmail.com',
      align: TextAlign.center 
    );
  }

  Widget _buildCopyRight( Utils utils ) {
    return utils.buildText(
      text: 'Copyright © 2020\nJosué Abraham Gutiérrez Quino',
      align: TextAlign.center 
    );
  }

  Widget _buildBtnSocialNetwork() {
    return Container(
      width: 150,
      height: 70,
      padding: EdgeInsets.symmetric(
          horizontal: 15.0, vertical: 10.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Color(0xff263238)),
      child: Center(
        child: Row(
          children: <Widget>[
            IconButton(
              onPressed: () {
                launchWhatsApp(phone: '59160619409');
              },
              icon: FaIcon(
                FontAwesomeIcons.whatsapp,
                color: Colors.white,
                size: 37,
              ),
            ),
            VerticalDivider(
              color: Colors.grey,
              thickness: 1.0,
            ),
            IconButton(
              onPressed: () {
                launchFacebook();
              },
              icon: FaIcon(
                FontAwesomeIcons.facebook,
                color: Colors.white,
                size: 37,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTextDirection( Utils utils ) {
    return utils.buildText(
      text: 'Encuéntranos en \nVilla fatima calle Yolosa esquina Mayor Lopera. Ciudad La Paz, La Paz, Bolivia',
      align: TextAlign.center
    );
  }

  Widget _buildGoogleMaps( Size size ) {
    return Container(
      width: size.width * 0.7,
      height: size.height * 0.6,
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular( 15.0 )
      ),
      child: GoogleMap(
        markers: _markers,
        initialCameraPosition: CameraPosition(
            zoom: 20, target: LatLng(-16.481376, -68.120075)),
        myLocationEnabled: true,
      ),
    );
  }

  void launchWhatsApp({@required String phone}) async {
    String url() {
      return "whatsapp://send?phone=$phone";
    }

    if (await canLaunch(url())) {
      await launch(url());
    } else {
      throw 'Could not launch ${url()}';
    }
  }

  Widget _buildAppBarInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        IconButton(
          icon: FaIcon(
            FontAwesomeIcons.angleLeft,
            color: Colors.white,
            size: 35,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        Text(
          'Licoreria Bohemian',
          style: FONTS.subtitle,
        ),
        SizedBox(),
      ],
    );
  }

  void launchFacebook() async {
    String url() {
      return "https://www.facebook.com/Licoreria-bohemia-106039600948007/";
    }

    if (await canLaunch(url())) {
      await launch(url());
    } else {
      throw 'Could not launch ${url()}';
    }
  }
}
