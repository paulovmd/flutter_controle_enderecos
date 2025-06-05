import 'dart:io';

import 'package:flutter_controle_enderecos/infra/local/sql.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class LocalDatabase{

  Database? database;
  
  Future<void> openDb() async{    
      
      if (Platform.isWindows){
        /*Inicializa as configurações da biblioteca SQLite
        para apliações Desktop*/
        sqfliteFfiInit();
        //Alterando como sistema cria o banco de dados na plataforma
        //Desktop
        databaseFactory = databaseFactoryFfi;
      }

      /*A função getDatabasesPath() recupera o local padrão de instalação
      da aplicação para o banco de dados. A função join, é utilizada para
      concatenar o diretório do banco com o nome do arquivo do banco de
      dados.*/
      String path = join(await getDatabasesPath(), "controleendereco.db");    
      
      /*Cria a conexão com o banco de dados */
      /*A atributo version define a versão atual do banco de dados
      da aplicação. O atributo onCreate é responsável por gerenciar
      a criação das tabelas do banco de dados.*/
      database = await openDatabase(path, 
          onCreate: (db, version) => _createTable(db, version),
          version: 1); 
  }
  
  void _createTable(Database db, int version) {
      db.execute(sqlCreateTable);
  }

  Future<void> closeDatabase() async{
      /*Se a instância da conexão foi criada e a conexão 
      esta aberta, fecha a conexão com o banco.*/
      if (database != null && database!.isOpen){
          //Fecha a conexão com o banco
          await database!.close();
      }
  }
  



}