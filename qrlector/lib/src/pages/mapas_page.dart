import 'package:flutter/material.dart';
import 'package:qrlector/src/models/scan_model.dart';
import 'package:qrlector/src/providers/db_provider.dart';

class MapasPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ScanModel>>(
      future: DBProvider.db.getTodosScans(),      
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
            onDismissed: (direccion)=>  DBProvider.db.deleteScan(scans[i].id),
            child: ListTile(
              leading: Icon(Icons.cloud, color: Colors.pink,),
              title: Text(scans[i].valor),
              subtitle: Text(scans[i].id.toString()),
              trailing: Icon(Icons.keyboard_arrow_right),
            ),
          ),

        );
      },
    );
  }
}