


import 'package:tara_app/services/config/psp_config.dart';
import 'dart:convert';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';
import 'package:tuple/tuple.dart';

class PKICryptoUtils {
  PKICryptoUtils();

  static decryptData(text,key,iv) async{
    // return await Cipher2.encryptAesCbc128Padding7(text, key, iv);
  }

  String encryptAESCryptoJS(String plainText, String passphrase) {
    try {
      final salt = genRandomWithNonZero(8);
      var keyndIV = deriveKeyAndIV(passphrase, salt);
      final key = encrypt.Key(keyndIV.item1);
      final iv = encrypt.IV(keyndIV.item2);

      final encrypter = encrypt.Encrypter(
          encrypt.AES(key, mode: encrypt.AESMode.cbc, padding: "PKCS7"));
      final encrypted = encrypter.encrypt(plainText, iv: iv);
      Uint8List encryptedBytesWithSalt = Uint8List.fromList(
          createUint8ListFromString("Salted__") + salt + encrypted.bytes);
      return base64.encode(encryptedBytesWithSalt);
    } catch (error) {
      throw error;
    }
  }
  String decryptAESCryptoJS(String encrypted, String passphrase) {
    try {
      Uint8List encryptedBytesWithSalt = base64.decode(encrypted);

      Uint8List encryptedBytes =
      encryptedBytesWithSalt.sublist(16, encryptedBytesWithSalt.length);
      final salt = encryptedBytesWithSalt.sublist(8, 16);
      var keyndIV = deriveKeyAndIV(passphrase, salt);
      final key = encrypt.Key(keyndIV.item1);
      final iv = encrypt.IV(keyndIV.item2);

      final encrypter = encrypt.Encrypter(
          encrypt.AES(key, mode: encrypt.AESMode.cbc, padding: "PKCS7"));
      final decrypted =
      encrypter.decrypt64(base64.encode(encryptedBytes), iv: iv);
      return decrypted;
    } catch (error) {
      throw error;
    }
  }

  Tuple2<Uint8List, Uint8List> deriveKeyAndIV(String passphrase, Uint8List salt) {
    var password = createUint8ListFromString(passphrase);
    Uint8List concatenatedHashes = Uint8List(0);
    Uint8List currentHash = Uint8List(0);
    bool enoughBytesForKey = false;
    Uint8List preHash = Uint8List(0);

    while (!enoughBytesForKey) {
      int preHashLength = currentHash.length + password.length + salt.length;
      if (currentHash.length > 0)
        preHash = Uint8List.fromList(
            currentHash + password + salt);
      else
        preHash = Uint8List.fromList(
            password + salt);

      currentHash = md5.convert(preHash).bytes;
      concatenatedHashes = Uint8List.fromList(concatenatedHashes + currentHash);
      if (concatenatedHashes.length >= 48) enoughBytesForKey = true;
    }

    var keyBtyes = concatenatedHashes.sublist(0, 32);
    var ivBtyes = concatenatedHashes.sublist(32, 48);
    return new Tuple2(keyBtyes, ivBtyes);
  }

  Uint8List createUint8ListFromString(String s) {
    var ret = new Uint8List(s.length);
    for (var i = 0; i < s.length; i++) {
      ret[i] = s.codeUnitAt(i);
    }
    return ret;
  }
  static String decodeQrCode(String encryptedString) {
    try {
      // pad the encrypted base64 string with '=' characters until length matches a multiple of 4
      final int toPad = encryptedString.length % 4;
      // if (toPad != 0) {
      //   encryptedString = encryptedString.padRight(encryptedString.length + toPad, "=");
      // }

      // get first 16 bytes which is the initialization vector
      final iv = encrypt.IV(Uint8List.fromList(base64Decode(encryptedString).getRange(0, 16).toList()));

      // get cipher bytes (without initialization vector)
      final encrypt.Encrypted encrypted = encrypt.Encrypted(Uint8List.fromList(
          base64Decode(encryptedString).getRange(16, base64Decode(encryptedString).length).toList()));

      // decrypt the string using the key and the initialization vector
      final key = encrypt.Key.fromUtf8(PSPConfig.INITIAL_LOGIN_ENCRYPTION_KEY);
      final encrypter = encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.cbc, padding: "PKCS7"));
      return encrypter.decrypt(encrypted, iv: iv);
    } catch (e) {
      print("Error while decoding QR code : $e");
      return null;
    }
  }
  Uint8List genRandomWithNonZero(int seedLength) {
    final random = Random.secure();
    const int randomMax = 245;
    final Uint8List uint8list = Uint8List(seedLength);
    for (int i=0; i < seedLength; i++) {
      uint8list[i] = random.nextInt(randomMax)+1;
    }
    return uint8list;
  }
  static final _encrypter = encrypt.Encrypter(
    encrypt.AES(encrypt.Key.fromUtf8(PSPConfig.INITIAL_LOGIN_ENCRYPTION_KEY),
        mode: encrypt.AESMode.ctr),
  );
  static getIV(){
    return encrypt.IV.fromLength(16).base16;
  }
  static String encryptAndEncodeByAes(String data) {
    final encrypted = _encrypter.encryptBytes(utf8.encode(data), iv: encrypt.IV.fromLength(16));
    return encrypted.base64;
  }

  static String decodeAndDecryptByAes(String data) {
    final encryptedText = encrypt.Encrypted.fromBase64(data);
    return _encrypter.decrypt(encryptedText, iv: encrypt.IV.fromLength(16));
  }
}
