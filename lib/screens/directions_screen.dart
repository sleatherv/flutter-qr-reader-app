import 'package:flutter/material.dart';
import 'package:qr_reader/widgets/scan_tiles.dart';

class DirectionsScreen extends StatelessWidget {
   
  const DirectionsScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    
    return const ScanTiles(type: 'http');
  }
}