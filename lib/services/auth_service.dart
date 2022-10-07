////////////////////////////////////////////////////////////////////////////////////////////////////
import 'package:flutter/material.dart';
////////////////////////////////////////////////////////////////////////////////////////////////////
import 'package:http/http.dart' as http;
import 'dart:convert';
////////////////////////////////////////////////////////////////////////////////////////////////////
class AuthService extends ChangeNotifier {
  final String _authority = "identitytoolkit.googleapis.com";
  final String _signUpUnencodedPath = "/v1/accounts:signUp";
  final String _signInUnencodedPath = "/v1/accounts:signInWithPassword";
  final String _fireBaseTocken = "AIzaSyA78qTgUwU3eVLIp8W3tbccR3xQOb7RKIA";
  String _sucessMessage = "";
  String _fireBaseIdToken ="";
  //
  String get sucessMessage => _sucessMessage;
  String get fireBaseIdToken => _fireBaseIdToken;
  // https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyA78qTgUwU3eVLIp8W3tbccR3xQOb7RKIA
  // con keys email y password en boby
  //info de post
  //solo retorna si algo no ha ido bien
  //Future<String?> createUser(String email, String pass)async{
  void signUp(String email, String pass)async{
      final Map<String, dynamic> authData = {
        "email":email,
        "password":pass
      };
      //url
      final url = Uri.https(
          _authority,
          _signUpUnencodedPath,
          {"key": _fireBaseTocken}//mapa
      );
      //lanzamos petición
      final resp = await http.post(url,body: json.encode(authData));
      //decodificamos
      final Map<String, dynamic> decodedResp = json.decode(resp.body);
      if(decodedResp.containsKey("idToken")){//respuesta de que todo ha ido bien
        print("idToken:"+ decodedResp["idToken"]);
        _sucessMessage = "Perfect !";
        _fireBaseIdToken = decodedResp["idToken"];
        notifyListeners();
      }else{
        String error = decodedResp["error"]["message"];
        _sucessMessage = error;
        print(_sucessMessage);
        notifyListeners();
      }

    }
  void signIn(String email, String pass)async{
    final Map<String, dynamic> authData = {
      "email":email,
      "password":pass
    };
    //url
    final url = Uri.https(
        _authority,
        _signInUnencodedPath,
        {"key": _fireBaseTocken}//mapa
    );
    //lanzamos petición
    final resp = await http.post(url,body: json.encode(authData));
    //decodificamos
    final Map<String, dynamic> decodedResp = json.decode(resp.body);
    if(decodedResp.containsKey("idToken")){//respuesta de que todo ha ido bien
      _sucessMessage = "Perfect !";
      print(_sucessMessage);
      _fireBaseIdToken = decodedResp["idToken"];
      notifyListeners();
    }else{
      String error = decodedResp["error"]["message"];
      _sucessMessage = error;
      print(_sucessMessage);
      _fireBaseIdToken="";
      notifyListeners();
    }

  }

}
////////////////////////////////////////////////////////////////////////////////////////////////////
