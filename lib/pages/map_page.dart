import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  _MapPageState createState() => _MapPageState();
  static const googlePlex = LatLng(40.99203, 29.12649);
}

class _MapPageState extends State<MapPage> {



 @override
  void initState() {
   super.initState();
 }

 @override
  Widget build(BuildContext context) => Scaffold(
   appBar: AppBar(
     title: const Text(
       '  Google Maps  ',
       style: TextStyle(
         fontSize: 26,
         color: Colors.white,
         fontWeight: FontWeight.bold,
       ),
     ),
     centerTitle: true,
     backgroundColor: Colors.red,
     elevation: 5,
     iconTheme: const IconThemeData(color: Colors.white, size: 25),
   ),
   body: GoogleMap(
     initialCameraPosition: CameraPosition(
       target: MapPage.googlePlex,
       zoom: 14,
     ),
     markers: {
       const Marker(
         markerId: MarkerId('sourceLocation'),
         icon: BitmapDescriptor.defaultMarker,
         position: MapPage.googlePlex,
       ),
     },
   ),

 );
}
