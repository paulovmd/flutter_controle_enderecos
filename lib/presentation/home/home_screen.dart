import 'package:flutter/material.dart';
import 'package:flutter_controle_enderecos/presentation/home/menu_drawer_home.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        title: const Text('Title'),
      ),
      body: Container(),
      drawer: MenuDrawerHome(),
    ));
  }
}
