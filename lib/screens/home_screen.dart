import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/db_provider.dart';
import 'package:qr_reader/providers/ui_provider.dart';
import 'package:qr_reader/screens/directions_screen.dart';
import 'package:qr_reader/screens/maps_screen.dart';
import 'package:qr_reader/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Historial'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.delete_forever),
          )
        ],
      ),
      body: _HomePageBody(),
      bottomNavigationBar: const CustomNavigationBar(),
      floatingActionButton: const ScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _HomePageBody extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    //get the selected menu opt
    final uiProvider = Provider.of<UiProvider>(context);

    //change to show page
    final currentIndex = uiProvider.selectedMenuOpt;

    //Todo; temp read database
    final tempScan = ScanModel(value: 'https://google.com');
    // DBProvider.db.newSan(tempScan);
    // DBProvider.db.getScanById(14).then((scan) => print(scan!.value));
    // DBProvider.db.getAllScans().then(print);
    DBProvider.db.deleteAllScans().then(print);

    

    switch (currentIndex) {
      case 0:
        return const MapsScreen();
      case 1:
        return const DirectionsScreen();
      default:
        return const MapsScreen();
    }
  }
}