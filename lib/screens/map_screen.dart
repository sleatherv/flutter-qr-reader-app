import 'package:flutter/material.dart';
import 'package:qr_reader/providers/db_provider.dart';
import 'package:qr_reader/models/scan_model.dart';
class MapScreen extends StatelessWidget {
  const MapScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final ScanModel scan = ModalRoute.of(context)!.settings.arguments as ScanModel; //Read the scan from argument

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Coordenadas'),
      ),
      body: Center(
        child: Text(scan.value),
      ),
    );
  }
}