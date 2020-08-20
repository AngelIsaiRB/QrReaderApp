

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:qrlector/src/models/scan_model.dart';


class MapaPage extends StatefulWidget {


  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
 
 
  final MapController map=MapController();
  String tipoMapa = "streets";


  @override
  Widget build(BuildContext context) {
    final ScanModel scan = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text("cordenadas QR"),
        actions: [
          IconButton(
            icon: Icon(Icons.my_location),
            onPressed: (){
                map.move(scan.getLatLng(), 12);
            },
          )
        ],
      ),
      body: _crearFlutterMap(scan),
      floatingActionButton: _crarbotonflotante(context),
    );
  }

  Widget _crearFlutterMap(ScanModel scan) {
    return new FlutterMap(
      mapController: map,
      options: MapOptions(
        center: scan.getLatLng(),
        zoom: 12
      ),
      layers: [
        _crearMapa(),
        _crearMarcadores(scan),
      ],
      
      );

  }

   _crearMapa() {

    return TileLayerOptions(
      urlTemplate: 'https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}',
      additionalOptions: {
        'accessToken': 'pk.eyJ1IjoiYW5nZWxpc2FpIiwiYSI6ImNrZTI3Y2JjczAwZXIyeXFmeG5qOW9rYTIifQ.IqkA6iYrWMsHM_aUAgUaqg',
        'id': 'mapbox/streets-v11'
      }
    );


  }

  _crearMarcadores(ScanModel scan) {
    return MarkerLayerOptions(
      markers: <Marker>[
        Marker(
          width: 100.0,
          height: 100.0,
          point: scan.getLatLng(),
          builder: (context)=>Container(
            child: Icon(Icons.location_on, size: 70.0,color: Colors.purple,),
          )
        )
      ]
    );

  }

  Widget _crarbotonflotante(BuildContext context) {
    return FloatingActionButton(
      onPressed: (){
        

      },
      child: Icon(Icons.repeat),
      backgroundColor:  Theme.of(context).primaryColor,
    );
  }
}