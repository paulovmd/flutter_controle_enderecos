import 'package:flutter/material.dart';
import 'package:flutter_controle_enderecos/presentation/usuario/search_usuario_screen.dart';

class MenuDrawerHome extends StatefulWidget {
  const MenuDrawerHome({ Key? key }) : super(key: key);

  @override
  _MenuDrawerHomeState createState() => _MenuDrawerHomeState();

}

class _MenuDrawerHomeState extends State<MenuDrawerHome> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
          child: _buildMenu(),
     );
  }

  Widget _buildMenu(){
    return ListView(
        children: [
          DrawerHeader(child: Text("Home")),
          ListTile(title: Text("Estado")),
          ListTile(title: Text("Usuário"), onTap: () {
                //Chama a janela de pesquisa de usuário
                Navigator.of(context).pushNamed(SearchUsuarioScreen.routeName);
                //Fecha o menu Drawer
               // Navigator.pop(context);
          },),
        ],
    );   
  }
}