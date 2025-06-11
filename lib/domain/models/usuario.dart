// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter_controle_enderecos/domain/models/entity.dart';

class Usuario extends Entity {

  int? id = 0;
  String? nome = '';
  String? salt = '';
  String? password = '';
  String? login = '';
  String? email = '';
  DateTime? data = DateTime.now();
  String? status = 'A';
  String? telefone = '';
  Usuario({
    this.id,
    this.nome = '',
    this.salt  = '',
    this.password  = '',
    this.login  = '',
    this.email  = '',
    this.status = '',
    this.telefone = '',
  });

  Usuario copyWith({
    int? id,
    String? nome,
    String? salt,
    String? password,
    String? login,
    String? email,
    String? status,
    String? telefone,
  }) {
    return Usuario(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      salt: salt ?? this.salt,
      password: password ?? this.password,
      login: login ?? this.login,
      email: email ?? this.email,
      status: status ?? this.status,
      telefone: telefone ?? this.telefone,
    );
  }  
  
  @override
  int getId(){
    return id!;
  }

  @override
  dynamic fromMap(Map<String, dynamic> map) {
    return Usuario.fromMap(map);
  }
  
  @override
  String getNameTable() {
    return "usuario";
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nome': nome,
      'salt': salt,
      'password': password,
      'login': login,
      'email': email,
      'status': status,
      'telefone': telefone,
    };
  }

  factory Usuario.fromMap(Map<String, dynamic> map) {
    return Usuario(
      id: map['id'] != null ? map['id'] as int : null,
      nome: map['nome'] != null ? map['nome'] as String : null,
      salt: map['salt'] != null ? map['salt'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      login: map['login'] != null ? map['login'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
      telefone: map['telefone'] != null ? map['telefone'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Usuario.fromJson(String source) => Usuario.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Usuario(id: $id, nome: $nome, salt: $salt, password: $password, login: $login, email: $email, status: $status, telefone: $telefone)';
  }

  @override
  bool operator ==(covariant Usuario other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.nome == nome &&
      other.salt == salt &&
      other.password == password &&
      other.login == login &&
      other.email == email &&
      other.status == status &&
      other.telefone == telefone;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      nome.hashCode ^
      salt.hashCode ^
      password.hashCode ^
      login.hashCode ^
      email.hashCode ^
      status.hashCode ^
      telefone.hashCode;
  }
}
