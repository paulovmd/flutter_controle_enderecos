import 'package:flutter/material.dart';
import 'package:flutter_controle_enderecos/domain/models/usuario.dart';
import 'package:flutter_controle_enderecos/domain/repositories/fake_usuario_repository.dart';
import 'package:flutter_controle_enderecos/domain/repositories/local_usuario_repository.dart';
import 'package:flutter_controle_enderecos/presentation/usuario/form_usuario_screen.dart';

class SearchUsuarioScreen extends StatefulWidget {

  static final String routeName = "/search_usuario_screen";

  const SearchUsuarioScreen({ Key? key }) : super(key: key);

  @override
  _SearchUsuarioScreenState createState() => _SearchUsuarioScreenState();
}

class _SearchUsuarioScreenState extends State<SearchUsuarioScreen> {

  /*Criando a instância da classe responsável por gerenciar
  a persistência dos dados. */
  LocalUsuarioRepository fakeUsuarioRepository =  LocalUsuarioRepository();
  /*Armazena os dados que serão utilizados na lista e posteriormente
  para realizar um filtro na lista */
  List<Usuario> listUsuarios = [];
  
  /*Armazena os resultados do filtro*/
  List<Usuario> filterResultsUsuarios = [];

  //Defini se esta carregando algo
  bool isLoading = false;
  
  @override
  void initState(){    
    super.initState();
    /*Este método initState deve ser utilizado SEMPRE que você
    quiser atualizar algum conteúdo na tela assim que uma página ou
    janela for chamada pela primeira vez.*/
    _findAllUsuarios();      
  }

  Future<void> _findAllUsuarios() async{    
    isLoading = true;
    listUsuarios =  await fakeUsuarioRepository.findAll();
    filterResultsUsuarios = listUsuarios;
    //Força atualização do estado da aplicação
    setState(() {
      isLoading = false;            
    });  
    
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        title: const Text('Usuário'),
      ),
      body: _buildBody(),
      floatingActionButton: 
        FloatingActionButton(onPressed: () => _showFormUsuario(),
        child: const Icon(Icons.add)),
    ));
  }
  
  void _showFormUsuario() async{
    //Chama uma janela utilizando o nome da Rota
    await Navigator.of(context).pushNamed(FormUsuarioScreen.routeName);
    await _findAllUsuarios();
    //Força atualização do estado da aplicação
    setState(() {            
    });

  }
  
  Widget _buildBody() {
    if (isLoading){
      return CircularProgressIndicator();
    }

    return Padding(padding: const EdgeInsets.all(16),
        child: Column(children: [
            TextField(
              decoration: const InputDecoration(hintText: "Digite o valor de pesquisa"),
              onChanged: (value) { 

                setState(() {
                  filter(value);                        
                });

                 
              },
            ),  
            /*O Expanded DEVE ser utilizado nos componentes
            que precisam se redimensionar na tela de acordo com
            o seu conteúdo*/
            Expanded(child: _buildListView() )            

        ],)    
    );
  }

  Widget _buildListView(){
    return ListView.builder(
      /*O itemCount define a quantidade de elementos que 
      serão visiveis no ListView. */
      itemCount: filterResultsUsuarios.length,      
      itemBuilder: (context, index) {
          /*Durante a construção dos items do ListView
          ele utilizada a quantidade dos itens para construir
          cada item que será visualizado. O parâmetro index representa
          o indíce atual de uma lista e utilizado esse parâmetro
          para acessar o contéudo que será visualizado no ListView */
          Usuario usuario = filterResultsUsuarios[index];

          return InkWell(onTap: () async{
            /*Chamando o formulário de cadastro e passando
            parâmetros para essa janela.*/            
            await Navigator.
                  of(context).
                  pushNamed(FormUsuarioScreen.routeName,
                    arguments: usuario);
            setState(() {              
            });
            
          }, child: _buildListTile(usuario) );

          
    },);
  }

  ListTile _buildListTile(Usuario usuario) {
    return ListTile(          
      title: Text(usuario.nome!),
      trailing: IconButton(icon: const Icon(Icons.delete), onPressed: () {               
          
          fakeUsuarioRepository.remove(usuario);
    
          setState(() {
              listUsuarios.remove(usuario);
              filterResultsUsuarios = listUsuarios;
              /*listUsuarios = fakeUsuarioRepository.findAll();
              filterResultsUsuarios = listUsuarios; */                  
          });
      },),          
    );
  }

  void filter(String value){
    String valueFilter = value.toLowerCase();
    /*Realiza um filtro verificando se o valor
    digitado existe na lista, neste caso, o valor
    é comparado com o atributo nome do objeto Usuário.*/
    filterResultsUsuarios = listUsuarios.where((element) 
      => element.nome!.toLowerCase().contains(valueFilter)       
      ).toList();  
  }

}