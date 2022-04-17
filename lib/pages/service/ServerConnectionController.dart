import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart' as http;
class ServerController {
  static const BASE_URL = '';

  static Future<http.Response> safeGetRequest(
      {String url, String errorDescription}) async {
    http.Response response;
    try {
      final result = await Connectivity().checkConnectivity();
      if (result != ConnectivityResult.none){
        response = await http.get(Uri.parse(BASE_URL + url)).timeout(Duration(seconds: 5));
      }else{
        throw ConnectionError();
      } 
    } on SocketException catch (_) {
      throw ServerConnectionError();
    } on TimeoutException catch (_) {
      throw ServerConnectionError();
    } on ConnectionError catch (e){
      throw e;
    } 
    if (response.statusCode == 200) {
      return response;
    } else {
      throw ServerError(response.statusCode, errorDescription);
    }
  }

/*
  static Future<http.Response> safePutRequest(
      {String url, String errorDescription, PostRequestBody body}) async {
    http.Response response;
    try {
      final result = await Connectivity().checkConnectivity();
      if (result != ConnectivityResult.none){
        response = await http
          .put(Uri.parse(BASE_URL + url),
              headers: {
                "Accept": "application/json",
                "content-type": "application/json"
              },
              body: jsonEncode(body.toJson()))
          .timeout(Duration(seconds: 5));
      }else{
        throw ConnectionError();
      } 
    } on SocketException catch (_) {
      throw ServerConnectionError();
    } on TimeoutException catch (_) {
      throw ServerConnectionError();
    } on ConnectionError catch (e){
      throw e;
    }
    if (response.statusCode == 200) {
      return response;
    } else {
      throw ServerError(response.statusCode, errorDescription);
    }
  }*/
}

class ConnectionError extends TextException {

  ConnectionError():super(text: "Соединение с сетью отсутствует.");
}

class TextException implements Exception {
  final String text;
  TextException({this.text});
}

class ServerConnectionError extends TextException {

  ServerConnectionError():super(text: "Соединение с сервером отсутствует, проверьте соединение с сетью, или попробйте подсоедениться позднее.");
}

class ServerError extends TextException {
  final int status;

  ServerError(this.status,text):super(text: text);
}