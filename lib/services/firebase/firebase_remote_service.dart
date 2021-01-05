/*
*  firebase_remote_service.dart
*
*  Created by Yakub Pasha.
*  Copyright © 2020 Tara.id. All rights reserved.
*/
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class FirebaseRemoteService{

  DatabaseReference database;
  FirebaseRemoteService(this.database);
  Future<void> setData(
      {@required String path,
        @required Map<String, dynamic> data}) async {
    await database.child(path).push().set(data);
  }
  Future<void> updateData(
      {@required String path,
        @required Map<String, dynamic> data}) async {
    await database.child(path).set(data);
  }

  Future<T> getData<T>(
      {@required String path,
        @required T builder(Map<String, dynamic> data)}) async {
    return database.child(path).once()
        .then((value) => builder(value.value));
  }
  Query getDataStream({@required String path}){
    return database.child(path);
  }

}