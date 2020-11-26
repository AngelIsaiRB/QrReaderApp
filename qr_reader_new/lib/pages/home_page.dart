import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader_new/pages/direcciones_page.dart';
import 'package:qr_reader_new/pages/mapas_page.dart';
import 'package:qr_reader_new/providers/ui_provider.dart';
import 'package:qr_reader_new/widgets/custom_navigationbar.dart';
import 'package:qr_reader_new/widgets/scan_button.dart';


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Historial"),
        centerTitle: true,
        actions: [
          IconButton(icon: Icon(Icons.delete_forever), 
          onPressed: (){

          }),
        ],
      ),
      body: _HomePageBody(),
      bottomNavigationBar: CustomNavigationBar(),
      floatingActionButton: ScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

    );
  }
}

class _HomePageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //obtener el selected menu opt

    final uiProvider = Provider.of<UiProvider>(context);
    final currentIndex=uiProvider.selectedMenuOpt;

    switch (currentIndex) {
      case 0:
        return MapasPage();
        break;
      case 1:
        return DireccionesPage();
        break;
      default:
      return MapasPage();
    }
  }
}