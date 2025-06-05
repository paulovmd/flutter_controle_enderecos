import 'package:flutter/material.dart';
import 'package:flutter_controle_enderecos/domain/models/usuario.dart';
import 'package:flutter_controle_enderecos/domain/repositories/fake_usuario_repository.dart';
import 'package:flutter_controle_enderecos/domain/repositories/local_usuario_repository.dart';

class FormUsuarioScreen extends StatefulWidget {

  static final String routeName = "/formUsuarioScreen";

  const FormUsuarioScreen({ Key? key }) : super(key: key);

  @override
  _FormUsuarioScreenState createState() => _FormUsuarioScreenState();
}

class _FormUsuarioScreenState extends State<FormUsuarioScreen> {
  
  /*Utilizado para realizar as validações no Formulário.
  Devemos associar esse objeto a propriedade key do Widget Form.*/
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();

  /*Os objetos do tipo TextEditionController são utilizados 
  para trabalhar com a edição das caixas de texto.*/
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();
  final TextEditingController _passWordController = TextEditingController();
  final TextEditingController _confirmPassWordController = TextEditingController();

  LocalUsuarioRepository  fakeUsuarioRepository = LocalUsuarioRepository();

  /*Utilizado para armazenar os dados do usuário
  que serão salvos na base de dados*/
  Usuario? usuario;

  @override
  void initState() { 
    super.initState();
  }

  void _updateForm(){    
      _nomeController.text = usuario!.nome!;
      _loginController.text = usuario!.login!;
      _emailController.text = usuario!.email!;
      _telefoneController.text = usuario!.telefone!;
     _passWordController.text = usuario!.password!;
  }


  @override
  Widget build(BuildContext context) { 
    /*Recuperando parâmetros enviados por outra página*/
    var args = ModalRoute.of(context)!.settings.arguments;
    if (args != null && args is Usuario){
        usuario = args;
        _updateForm();
    }   
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro Usuário'),
        actions: [
          IconButton(onPressed: () => submit(), 
              icon: const Icon(Icons.check))
        ],
      ),
      body: _buildBody(),
    ));
  }
  
  /*Realiza as validações e confirma as operações do cadastro*/
  void submit() async{
    /*O metodo validate realiza as validações nos campos
    do formulário. Para isso, devemos utilizar a propriedade
    validator dos Widget TextFormField*/       
    if (_formState.currentState!.validate()){

        if (usuario == null){
          usuario = Usuario(); 
        }
        
        usuario!.nome = _nomeController.text;
        usuario!.email = _emailController.text;
        usuario!.login = _loginController.text;
        usuario!.password = _passWordController.text;
        usuario!.telefone = _telefoneController.text;              
       
        if (usuario!.id == null){        
          usuario!.salt = '';
          usuario!.status = 'A';
          usuario!.data = DateTime.now();          
          await fakeUsuarioRepository.insert(usuario!);
        }
        else{
          await fakeUsuarioRepository.update(usuario!);
        }

        //Fecha o formulário
        Navigator.pop(context);
    }

  }

  /*Método para validar se o campo está vazio.*/
  String? validateEmptyField(String? value){
    if (value == null || value.isEmpty){
      return "Campo Obrigatório!";
    } 
    return null;
  }

  String? validatePassword(String? value){
      if (_passWordController.text != _confirmPassWordController.text){
          return "As senhas devem ser iguais!";
      }   

      return validateEmptyField(value);

  }

  Widget _buildBody(){
    return Padding(padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: _buildForm()),    
    );
  }

  Form _buildForm() {
    return Form(   
      key: _formState, //Importante para validações        
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [            
            TextFormField(  
              controller: _nomeController,              
              validator: (value) => validateEmptyField(value),
              decoration: const InputDecoration(labelText: "Nome"),                                
            ),              
            TextFormField(
              controller: _loginController,
              validator: (value) => validateEmptyField(value),
              decoration: const InputDecoration(labelText: "Login")                
            ),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              validator: (value) => validateEmptyField(value),              
              decoration: const InputDecoration(labelText: "Email")                
            ),
            TextFormField(
              controller: _telefoneController,
              keyboardType: TextInputType.phone,                            
              validator: (value) => validateEmptyField(value),
              decoration: const InputDecoration(labelText: "Telefone")                
            ),
            TextFormField(   
              validator: (value) => validatePassword(value), 
              controller: _passWordController,          
              obscureText: true,
              decoration: const InputDecoration(labelText: "Senha")                
            ),
            TextFormField(
              validator: (value) => validatePassword(value),
              controller: _confirmPassWordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: "Confirmar Senha")                
            ),                                          
        ],
      ),);
  }

}