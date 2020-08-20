import 'dart:io';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';


import 'package:qrlector/src/bloc/scans_block.dart';
import 'package:qrlector/src/models/scan_model.dart';
import 'package:qrlector/src/utils/utils.dart' as utils;


import 'direcciones_page.dart';
import 'mapas_page.dart';


class HomePage extends StatefulWidget {
  

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  final scansBloc = new ScansBloc();
  int currentIndex=0;
   


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("QR Scanner"),
        actions: [
          IconButton(
            icon: Icon (Icons.delete_forever),
            onPressed: (){
                scansBloc.borrarTodosScans();
            },
            )
        ],
      ),

      body: _callPage(currentIndex),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(Icons.filter_center_focus),
        onPressed: ()=> _scanQR(context),        
      ),
      
      
      bottomNavigationBar: _crearBottonNavigation(),
    );
  }

  _scanQR(BuildContext context) async {
        //https://www.google.com
        //geo:40.732558,-73.8933331
    String  futureString="https://www.google.com";
    
    try {
       futureString = (await BarcodeScanner.scan()) as String;

    } catch (e) {
      futureString=e.toString();
    }
    

    if(futureString!=null){
      final scan = ScanModel(valor: futureString);
      
      scansBloc.agregarsacan(scan);
        
      if (Platform.isIOS) {
        Future.delayed(Duration(milliseconds:750),(){
          utils.abrirScan(context,scan);
        });        
      }
      else{
        utils.abrirScan(context,scan);
      }
     
    }
    

  }

  Widget _crearBottonNavigation(){
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index){
          setState(() {
          currentIndex =index;            
          });
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          title: Text("mapa")
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.swap_vert),
          title: Text("direcciones")
        ),
      ],
    );

  }

  Widget _callPage(int paginaActual) {

    switch (paginaActual) {
      case 0:
        return MapasPage();
        break;
      case 1:
        return DireccionesPage();
        break;
      default:
        return MapasPage();
        break;
      
    }

  }
}