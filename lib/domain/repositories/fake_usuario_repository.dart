import 'package:flutter_controle_enderecos/domain/models/usuario.dart';
import 'package:flutter_controle_enderecos/infra/fake/fake_database.dart';

class FakeUsuarioRepository{

  //Armazena os dados em memória
  List<Usuario> listaUsuarios = fakeDataUsuario;

  void insert(Usuario usuario){
    listaUsuarios.add(usuario);
  }

  void remove(Usuario usuario){    
    listaUsuarios.remove(usuario);
  }
  
  void update(Usuario usuario){    
    int index = listaUsuarios.indexWhere(
      (element) => element.id == usuario.id);    
    listaUsuarios[index] = usuario;
  }

  Usuario findById(int id){
    Usuario user = listaUsuarios.firstWhere(
      (element) => element.id == id);
    return user;
  }

  Usuario findByLogin(String login, String password){
    Usuario user = listaUsuarios.firstWhere(
      (element) => element.login == login && 
                   element.password == password);
    return user;             
  }

  List<Usuario> findAll(){
    return listaUsuarios;
  }

}