
import 'package:flutter_controle_enderecos/domain/models/usuario.dart';

List<Usuario> gerarUsuarios(){
  List<Usuario> usuarios = [];
  for (int i = 0; i < 20; i++){
    Usuario user = Usuario();
    user.id = i+1;
    user.nome = "Usuario${i}";
    user.login = "usuario${i}";
    user.password = "usuario${i}";
    user.email = "usuario${i}@email.com.br";
    user.telefone = "123456";
    user.salt = "123456";
    usuarios.add(user);
  }
  return usuarios;
}
//Representa a lista de usuários fakes gerados
List<Usuario> fakeDataUsuario = gerarUsuarios();

