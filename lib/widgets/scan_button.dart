import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';

class ScanButton extends StatelessWidget {
  const ScanButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      child: const Icon(Icons.filter_center_focus),
      onPressed: () async{
        // String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        //                                             '#3D8BEF', 
        //                                             'Cancelar', 
        //                                             false, 
        //                                             ScanMode.QR);
        const barcodeScanRes = 'https://pub.dev/packages/flutter_barcode_scanner';

        final scanListProvider = Provider.of<ScanListProvider>(context, listen: false);

        scanListProvider.newScan(barcodeScanRes);
        scanListProvider.newScan('geo:15.33,15.66');
        // print(barcodeScanRes);
      },
    );
  }
}