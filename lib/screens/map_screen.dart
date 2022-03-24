import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qr_reader/providers/db_provider.dart';
import 'package:qr_reader/models/scan_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    final CameraPosition initialPoint = CameraPosition(
      target: LatLng(37.42796133580664, -122.085749655962),
      zoom: 14.4746,
    );
    final ScanModel scan = ModalRoute.of(context)!.settings.arguments as ScanModel; //Read the scan from argument

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Coordenadas'),
      ),
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: initialPoint,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}