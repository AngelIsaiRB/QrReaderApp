import 'package:flutter/material.dart';

import 'direcciones_page.dart';
import 'mapas_page.dart';


class HomePage extends StatefulWidget {
  

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int currentIndex=0;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("QR Scanner"),
        actions: [
          IconButton(
            icon: Icon (Icons.delete_forever),
            onPressed: (){},
            )
        ],
      ),

      body: _callPage(currentIndex),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(Icons.filter_center_focus),
        onPressed: _scanQR,        
      ),
      
      
      bottomNavigationBar: _crearBottonNavigation(),
    );
  }

  _scanQR(){

    

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