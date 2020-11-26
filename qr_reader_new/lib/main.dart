import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader_new/pages/home_page.dart';
import 'package:qr_reader_new/pages/mapa_page.dart';
import 'package:qr_reader_new/providers/ui_provider.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(      
      providers: [
        ChangeNotifierProvider(create: (_)=>UiProvider()),
        
      ],
      child: MaterialApp(
        title: 'QR Reader',
        debugShowCheckedModeBanner: false,
        initialRoute: "home",
        routes: {
          "home" : (_)=>HomePage(),
          "mapa" : (_)=>MapaPage(),
        },
        theme: ThemeData(
          primaryColor: Colors.deepPurple,
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: Colors.deepPurple
          )
        ),
      ),
    );
  }
}