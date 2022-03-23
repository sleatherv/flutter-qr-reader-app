
import 'package:flutter/material.dart';
import 'package:qr_reader/models/scan_model.dart';
import 'package:url_launcher/url_launcher.dart';

void launchURL(BuildContext context, ScanModel scan) async {
  final url = scan.value;

  if(scan.type == 'http'){
    if (!await launch(url)) throw 'Could not launch $url';
  }else{
    Navigator.pushNamed(context, 'map', arguments: scan);
  }
}
