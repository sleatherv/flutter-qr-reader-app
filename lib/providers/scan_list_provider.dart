import 'package:flutter/material.dart';
import 'package:qr_reader/providers/db_provider.dart';

class ScanListProvider extends ChangeNotifier{
  
  List<ScanModel> scans = [];
  String selectedType = 'http';

  newScan(String aValue) async{
    final newScan = ScanModel(value: aValue);

    final id = await DBProvider.db.newSan(newScan);
    //Assign created ID from Database to model
    newScan.id = id;

    if(selectedType == newScan.type){
      scans.add(newScan);
      notifyListeners();
    }
  }

  loadScans() async{
    final scans = await DBProvider.db.getAllScans();
    this.scans = [...scans];
    notifyListeners();
  }

  loadScanByType(String aType) async{
    final scans = await DBProvider.db.getScanByType(aType);
    this.scans = [...scans];
    notifyListeners();
  }

  deleteAllScans() async{
    await DBProvider.db.deleteAllScans();
    scans = [];
    notifyListeners();
  }

  deleteScanById(int id) async{
    await DBProvider.db.deleteScan(id);
    loadScanByType(selectedType); //this method also call notifyListeners();
  }

}