import 'package:flutter/material.dart';
import 'package:flutter_controle_enderecos/infra/local/local_database.dart';
import 'package:flutter_controle_enderecos/presentation/home/home_screen.dart';
import 'package:flutter_controle_enderecos/presentation/usuario/form_usuario_screen.dart';
import 'package:flutter_controle_enderecos/presentation/usuario/search_usuario_screen.dart';

void main() async {
  LocalDatabase databaseTest = LocalDatabase();
  await databaseTest.openDb();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(    
      debugShowCheckedModeBanner: false, 
      routes : routes
    );
  }
}

/*Variável responsável por registrar as rotas das páginas da aplicação*/
var routes = {FormUsuarioScreen.routeName : (context) => FormUsuarioScreen(),
              SearchUsuarioScreen.routeName : (context) => SearchUsuarioScreen(),
       "/" : (context) => HomeScreen()};
