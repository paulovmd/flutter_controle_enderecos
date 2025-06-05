import 'package:flutter_controle_enderecos/domain/models/usuario.dart';
import 'package:flutter_controle_enderecos/infra/local/local_database.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class LocalUsuarioRepository{
    //Crianda a instância da classe responsável
    //pela conexão com o banco de dados
    LocalDatabase localDatabase = LocalDatabase();

    Future<void> insert(Usuario usuario) async{
       try{
            await localDatabase.openDb();
            //Retornando a conexão com o banco
            Database conexao = localDatabase.database!;
            await conexao.insert("usuario", usuario.toMap());
       }catch(ex){
          throw Exception(ex.toString());
       }
       finally{
          localDatabase.closeDatabase();
       }
    }

    Future<void> update(Usuario usuario) async{
       try{
            await localDatabase.openDb();
            //Retornando a conexão com o banco
            Database conexao = localDatabase.database!;
            await conexao.update("usuario", usuario.toMap(), 
                    where: " id = ? ", whereArgs: [usuario.id] );
       }catch(ex){
          throw Exception(ex.toString());
       }
       finally{
          localDatabase.closeDatabase();
       }
    }

    Future<void> remove(Usuario usuario) async{
       try{
            await localDatabase.openDb();
            //Retornando a conexão com o banco
            Database conexao = localDatabase.database!;
            await conexao.delete("usuario", where: " id = ? ", whereArgs: [usuario.id] );
       }catch(ex){
          throw Exception(ex.toString());
       }
       finally{
          localDatabase.closeDatabase();
       }
    }


    Future<List<Usuario>> findAll() async{
       
       //Armazena o resultado da consulta
       List<Usuario> usuarios = [];

       try{
            await localDatabase.openDb();
            //Retornando a conexão com o banco
            Database conexao = localDatabase.database!;
            /*Realiza um consulta no banco de dados e retorna uma lista
            de Maps, no qual, cada linha, representa uma tupla da tabela.*/
            List<Map<String, Object?>> resultado = 
                           await conexao.query("usuario");
            //Convertendo o resultado da consulta em uma lista de objetos 
            for (var elemento in resultado) {
                 Usuario us = Usuario.fromMap(elemento);
                 usuarios.add(us);
            }

       }catch(ex){
          throw Exception(ex.toString());
       }
       finally{
          localDatabase.closeDatabase();
       }

       return usuarios;
    }



}