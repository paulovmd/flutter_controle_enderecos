import 'package:flutter_controle_enderecos/domain/models/entity.dart';
import 'package:flutter_controle_enderecos/infra/local/local_database.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class LocalBaseRepository<TEntity extends Entity>{
    //Crianda a instância da classe responsável
    //pela conexão com o banco de dados
    LocalDatabase localDatabase = LocalDatabase();

    Future<void> insert(TEntity entity) async{
       try{
            await localDatabase.openDb();
            //Retornando a conexão com o banco
            Database conexao = localDatabase.database!;
            await conexao.insert(entity.getNameTable(), entity.toMap());
       }catch(ex){
          throw Exception(ex.toString());
       }
       finally{
          localDatabase.closeDatabase();
       }
    }

    Future<void> update(TEntity entity) async{
       try{
            await localDatabase.openDb();
            //Retornando a conexão com o banco
            Database conexao = localDatabase.database!;
            await conexao.update(entity.getNameTable(), entity.toMap(), 
                    where: " id = ? ", whereArgs: [entity.getId()] );
       }catch(ex){
          throw Exception(ex.toString());
       }
       finally{
          localDatabase.closeDatabase();
       }
    }

    Future<void> remove(TEntity entity) async{
       try{
            await localDatabase.openDb();
            //Retornando a conexão com o banco
            Database conexao = localDatabase.database!;
            await conexao.delete(entity.getNameTable(), 
              where: " id = ? ", whereArgs: [entity.getId()] );
       }catch(ex){
          throw Exception(ex.toString());
       }
       finally{
          localDatabase.closeDatabase();
       }
    }


    Future<List<TEntity>> findAll(TEntity entity) async{
       
       //Armazena o resultado da consulta
       List<TEntity> entities = [];

       try{
            await localDatabase.openDb();
            //Retornando a conexão com o banco
            Database conexao = localDatabase.database!;
            /*Realiza um consulta no banco de dados e retorna uma lista
            de Maps, no qual, cada linha, representa uma tupla da tabela.*/
            List<Map<String, Object?>> resultado = 
                           await conexao.query(entity.getNameTable());
            //Convertendo o resultado da consulta em uma lista de objetos 
            for (var elemento in resultado) {
                 TEntity us = entity.fromMap(elemento);
                 entities.add(us);
            }

       }catch(ex){
          throw Exception(ex.toString());
       }
       finally{
          localDatabase.closeDatabase();
       }

       return entities;
    }



}