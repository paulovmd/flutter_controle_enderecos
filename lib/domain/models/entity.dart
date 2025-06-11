/*Classe abstrata Entity que todas as classes de entidade
DEVEM herdar para que seja possível utilizar a classe
LocalBaseRepository.*/
abstract class Entity{
  
  //Deve retornar o valor do Id
  int getId();

  //Método que deve retornar o nome da tabela
  String getNameTable();

  //Retorna um map com os valores dos campos do objeto
  Map<String, dynamic> toMap();

  //Transforma um Map para um objeto apropriado
  dynamic fromMap(Map<String, dynamic> map);

}