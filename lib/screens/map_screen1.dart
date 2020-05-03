import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vtg1flutter/services/location.dart';

class MapScreen1 extends StatefulWidget {
  @override
  MapScreen1State createState() => MapScreen1State();
}

class MapScreen1State extends State<MapScreen1> {
  Completer<GoogleMapController> _controller = Completer();

  //Location location = Location();
  @override
  void initState() {
    super.initState();
    //location.getCurrentLocation();
  }

  double zoomVal = 5.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(FontAwesomeIcons.arrowLeft),
            onPressed: () {
              //
            }),
        title: Text("Hyderabad"),
        actions: <Widget>[
          IconButton(
              icon: Icon(FontAwesomeIcons.search),
              onPressed: () {
                //
              }),
        ],
      ),
      body: Stack(
        children: <Widget>[
          _buildGoogleMap(context),
          _zoomminusfunction(),
          _zoomplusfunction(),
          _buildContainer(),
        ],
      ),
    );
  }

  Widget _zoomminusfunction() {
    return Align(
      alignment: Alignment.topLeft,
      child: IconButton(
          icon: Icon(FontAwesomeIcons.searchMinus, color: Color(0xff6200ee)),
          onPressed: () {
            zoomVal--;
            _minus(zoomVal);
          }),
    );
  }

  Widget _zoomplusfunction() {
    return Align(
      alignment: Alignment.topRight,
      child: IconButton(
          icon: Icon(FontAwesomeIcons.searchPlus, color: Color(0xff6200ee)),
          onPressed: () {
            zoomVal++;
            _plus(zoomVal);
          }),
    );
  }

  Future<void> _minus(double zoomVal) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(17.4554, 78.5008), zoom: zoomVal)));
  }

  Future<void> _plus(double zoomVal) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(17.4554, 78.5008), zoom: zoomVal)));
  }

  Widget _buildContainer() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20.0),
        height: 150.0,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            SizedBox(width: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                  "https://lh3.googleusercontent.com/proxy/ji9VkhAIv-L07Iv8c1z3ojoANKbppBC-Msz0ya6qNKAELnhKAhCySk2Sta3zVHtEK4VrRD7t_GitPPnQkwnHq0oYMweVTJdIus5OLjWPiaOaRwW147m29pYwmPA",
                  17.4062,
                  78.4691,
                  "Birla Mandir"),
            ),
            SizedBox(width: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                  "https://img.theculturetrip.com/768x432/wp-content/uploads/2016/06/24498998325_f451c67aae_o.jpg",
                  17.3616,
                  78.4747,
                  "CharMinar"),
            ),
            SizedBox(width: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                  "https://3.bp.blogspot.com/-y62A9HnXRr4/U7f8wnsQFeI/AAAAAAAABq4/bxFT15Bc1Xk/s1600/Golconda-Fort.jpg",
                  17.3833,
                  78.4011,
                  "Golconda Fort"),
            ),
            SizedBox(width: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                  "https://img.traveltriangle.com/blog/wp-content/uploads/2019/11/Best-Time-To-Visit-Nehru-Zoological-Park.jpg",
                  17.3507,
                  78.4513,
                  "Nehru Zoological Park"),
            ),
            SizedBox(width: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                  "https://www.nkrealtors.com/blog/wp-content/uploads/2017/12/Salar-Jung-Museum-730x410.jpg",
                  17.3713,
                  78.4804,
                  "Salar Jung Museum"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _boxes(String _image, double lat, double long, String placeName) {
    return GestureDetector(
      onTap: () {
        _gotoLocation(lat, long);
      },
      child: Container(
        child: new FittedBox(
          child: Material(
              color: Colors.white,
              elevation: 14.0,
              borderRadius: BorderRadius.circular(24.0),
              shadowColor: Color(0x802196F3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 180,
                    height: 200,
                    child: ClipRRect(
                      borderRadius: new BorderRadius.circular(24.0),
                      child: Image(
                        fit: BoxFit.fill,
                        image: NetworkImage(_image),
                      ),
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: myDetailsContainer1(placeName),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }

  Widget myDetailsContainer1(String placeName) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
            child: Text(
              placeName,
              style: TextStyle(
                  color: Color(0xff6200ee),
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGoogleMap(BuildContext context) {
    //Location location = Location();
//    var lat = location.latitude;
//    var lon = location.longitude;

    return Container(
      height: MediaQuery
          .of(context)
          .size
          .height,
      width: MediaQuery
          .of(context)
          .size
          .width,
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition:
        CameraPosition(target: LatLng(17.4554, 78.5008), zoom: 12),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: {
          vikrampuriMarker1,
          birlaMandirMarker,
          charminarMarker,
          golcondaMarker,
          salarJungMuseumMarker,
          nehruZoologicalParkMarker
        },
      ),
    );
  }

  Future<void> _gotoLocation(double lat, double long) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(lat, long),
      zoom: 15,
      tilt: 50.0,
      bearing: 45.0,
    )));
  }
}

Marker golcondaMarker = Marker(
  markerId: MarkerId('GolcondaFort'),
  position: LatLng(17.3833, 78.4011),
  infoWindow: InfoWindow(title: 'Golconda Fort'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueBlue,
  ),
);

Marker salarJungMuseumMarker = Marker(
  markerId: MarkerId('SalarJungMuseum'),
  position: LatLng(17.3713, 78.4804),
  infoWindow: InfoWindow(title: 'Salar Jung Museum'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueBlue,
  ),
);
Marker nehruZoologicalParkMarker = Marker(
  markerId: MarkerId('NehruZoologicalPark'),
  position: LatLng(17.3507, 78.4513),
  infoWindow: InfoWindow(title: 'Nehru Zoological Park'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueBlue,
  ),
);

Marker vikrampuriMarker1 = Marker(
  markerId: MarkerId('Vikrampuri'),
  position: LatLng(17.4554, 78.5008),
  infoWindow: InfoWindow(title: 'VikramPuri'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueBlue,
  ),
);
Marker birlaMandirMarker = Marker(
  markerId: MarkerId('BirlaMandir'),
  position: LatLng(17.4062, 78.4691),
  infoWindow: InfoWindow(title: 'Birla Mandir'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueBlue,
  ),
);
Marker charminarMarker = Marker(
  markerId: MarkerId('charminar'),
  position: LatLng(17.3616, 78.4747),
  infoWindow: InfoWindow(title: 'Charminar'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueBlue,
  ),
);
