import 'package:flutter/material.dart';
import 'package:qrlector/src/bloc/scans_block.dart';
import 'package:qrlector/src/models/scan_model.dart';
import 'package:qrlector/src/utils/utils.dart' as utils;



class DireccionesPage extends StatelessWidget {
final scansBloc = ScansBloc();

  @override
  Widget build(BuildContext context) {
    
    scansBloc.obtenerScans();


    return StreamBuilder<List<ScanModel>>(

      stream: scansBloc.scansStreamHttp,


      builder: (BuildContext context, AsyncSnapshot<List<ScanModel>> snapshot) {
        if (!snapshot.hasData){
          return Center(child: CircularProgressIndicator(),);
        }
        final scans = snapshot.data;
        if(scans.length ==0){
          return Center(
            child: Text("no hay informacion"),
          );
        }
        return ListView.builder(
          itemCount: scans.length,
          itemBuilder: (context,i)=> Dismissible(
            key: UniqueKey(),
            background: Container(
              color: Colors.red,              
            ),
            onDismissed: (direccion)=> scansBloc.borrarScan(scans[i].id),
            child: ListTile(
              leading: Icon(Icons.cloud, color: Colors.pink,),
              title: Text(scans[i].valor),
              subtitle: Text(scans[i].id.toString()),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: (){
                utils.abrirScan(context,scans[i]);
              },
            ),
          ),

        );
      },
    );
  }
}