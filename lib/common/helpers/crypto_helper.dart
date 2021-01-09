/*
*  crypto_helper.dart
*
*  Created by Yakub Pasha.
*  Copyright © 2020 Tara.id. All rights reserved.
*/

import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tara_app/services/config/psp_config.dart';

const platform = const MethodChannel('flutter.native/tokenFetch');

class CryptoHelper{

  static const ENCRYPTION_FUNCTION = "encryptionFunction";
  static const ENCRYPTION_FUNCTION2 = "encryptionFunction2";
  static const ENCODE_ENCRYPTION_FUNCTION = "encryptAndEncode";
  static const DECRYPTION_FUNCTION = "decryptionFunction";
  static const DECRYPTION_FUNCTION2 = "decryptionFunction2";
  static const DECODE_DECRYPTION_FUNCTION = "decodeAndDecrypt";
  static const DECODE_DECRYPTION_FUNCTION2 = "decodeAndDecrypt2";
  static const GET_AES_FUNCTION = "generateAes";
  // Future<String> encryptObj<T>(T obj) async => await _getEncryption(json.encode(obj.toJson()), PSPConfig.INITIAL_LOGIN_ENCRYPTION_KEY);
  Future<String> encrypt( text,{ key = PSPConfig.INITIAL_LOGIN_ENCRYPTION_KEY}) async => await _getEncryption(ENCRYPTION_FUNCTION,text, key);
  Future<String> encryptCustomKey( text,key) async => await _getEncryption(ENCRYPTION_FUNCTION2,text, key);
  Future<String> decryptCustomKey( text,key) async => await _getDecryption(DECRYPTION_FUNCTION2,text, key);
  Future<String> decrypt( text,{key = PSPConfig.INITIAL_LOGIN_ENCRYPTION_KEY}) async => await _getDecryption(DECRYPTION_FUNCTION,text, key);
  Future<String> encryptAndEncode(text, key) async => await _getEncryption(ENCODE_ENCRYPTION_FUNCTION,text, key);
  Future<String> decodeAndDecrypt( text, key) async => await _getDecryption(DECODE_DECRYPTION_FUNCTION,text, key);
  Future<dynamic> decodeAndDecrypt2( text, key) async => await _getDecryption2(DECODE_DECRYPTION_FUNCTION2,text, key);

  /*Future<T> decrypt<T extends JsonSerializable>(String text) async{
    final decryptObj = await _getDecryption(text, PSPConfig.INITIAL_LOGIN_ENCRYPTION_KEY);
    return T.fromJ(decryptObj).;
  }*/

  Future<String> _getEncryption(String method, dynamic token, key) async {
    String response = "";
    try {
      final dynamic result = await platform
          .invokeMethod(method, <String, dynamic>{'data': token, 'key': key});
      response = result.toString();
      return response;
    } on PlatformException catch (e) {
      response = "Failed to Invoke: '${e.message}'.";
      return response;
    }
  }
  Future<dynamic> _getDecryption2(String method, dynamic res, dynamic key) async {
    String response;
    try {
      final dynamic result = await platform
          .invokeMethod(method, <String, dynamic>{'data': res, 'key': key});
      return result;
    } on PlatformException catch (e) {
      response = "Failed to Invoke: '${e.message}'.";
      return response;
    }
  }
  Future<String> _getDecryption(String method, dynamic res, dynamic key) async {
    String response;
    try {
      final dynamic result = await platform
          .invokeMethod(method, <String, dynamic>{'data': res, 'key': key});
      response = result.toString();
      return response;
    } on PlatformException catch (e) {
      response = "Failed to Invoke: '${e.message}'.";
      return response;
    }
  }
  Future<Uint8List> getAES() async {
    try {
      final dynamic result = await platform
          .invokeMethod(GET_AES_FUNCTION);
      return result;
    } on PlatformException catch (e) {
        throw e;
    }
  }

  Future<Map<String,dynamic>> encryptDataWithRandomKey(data,sessionKey) async {
    try {
      final dynamic result = await platform
          .invokeMethod("encryptWithAutoRandomKey",<String, dynamic>{'data': data, 'sessionKey': sessionKey});
      print(result.toString());
      return Map<String, dynamic>.from(result);
    } on PlatformException catch (e) {
      throw e;
    }
  }
  Future<String> decryptDataWithSymmetricKey(data,symmetricKey,sessionKey) async {
    try {
      final dynamic result = await platform
          .invokeMethod("decryptWithSymmetricKey",<String, dynamic>{'data': data, 'sessionKey': sessionKey,'symmetricKey':symmetricKey});
      return result;
    } on PlatformException catch (e) {
      throw e;
    }
  }

}