import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';
import 'package:qr_reader/utils/utils.dart';


class ScanTiles extends StatelessWidget {
  final String type;

  const ScanTiles({ Key? key, required this.type }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scanListProvider = Provider.of<ScanListProvider>(context);
    final scans = scanListProvider.scans;

    return  ListView.builder(
      itemCount: scans.length,
      itemBuilder: (_, i) => Dismissible(
        key: UniqueKey(), //generate a unique key
        background: Container(
          color: Colors.red,
          child: const Icon(Icons.delete),
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 30),
        ),
        child: ListTile(
          leading: Icon(
            type == 'http'
            ? Icons.directions
            : Icons.map_outlined,
            color: Theme.of(context).primaryColor
          ),
          title: Text(scans[i].value),
          subtitle:  Text(scans[i].id.toString()),
          trailing:  const Icon(Icons.keyboard_arrow_right, color: Colors.grey),
          onTap: () => launchURL(context, scans[i]),
        ),
        onDismissed: (DismissDirection direction) {
          Provider.of<ScanListProvider>(context, listen: false).deleteScanById(scans[i].id!);
        },
      ),
    
    );
  }
}