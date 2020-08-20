import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:qrlector/src/models/scan_model.dart';


class MapaPage extends StatelessWidget {

  
  @override
  Widget build(BuildContext context) {
    final ScanModel scan = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text("cordenadas QR"),
        actions: [
          IconButton(
            icon: Icon(Icons.my_location),
            onPressed: (){},
          )
        ],
      ),
      body: _crearFlutterMap(scan)
    );
  }

  Widget _crearFlutterMap(ScanModel scan) {
    return new FlutterMap(
      options: MapOptions(
        center: scan.getLatLng(),
        zoom: 12
      ),
      layers: [
        _crearMapa(),
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
}