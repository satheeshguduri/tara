/*
*  chat_repository_impl.dart
*
*  Created by Yakub Pasha.
*  Copyright © 2020 Tara.id. All rights reserved.
*/
import 'package:dartz/dartz.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:tara_app/models/auth/auth_request.dart';
import 'package:tara_app/models/auth/customer_profile.dart';
import 'package:tara_app/models/auth/auth_response.dart';
import 'package:tara_app/models/chat/text_message.dart';
import 'package:tara_app/models/core/base_response.dart';
import 'package:tara_app/models/order_management/orders/order.dart';
import 'package:tara_app/repositories/chat_repository.dart';
import 'package:tara_app/services/config/firebase_path.dart';
import 'package:tara_app/services/error/failure.dart';
import 'package:tara_app/services/firebase_remote_service.dart';
import 'package:tara_app/services/util/network_info.dart';
import 'package:tara_app/models/order_management/orders/order.dart' as order;

class ChatRepositoryImpl implements ChatRepository {
  FirebaseRemoteService firebaseRemoteService;
  NetworkInfo networkInfo;

  ChatRepositoryImpl(this.firebaseRemoteService,this.networkInfo);

  @override
  Query openChatRoom(String senderId, String receiverId) {
    return firebaseRemoteService.getDataStream(path: FirebasePath.getPath(senderId, receiverId));
  }

  @override
  sendMessage(TextMessage textMessage) {
    firebaseRemoteService.setData(path: FirebasePath.getPath(textMessage.senderId, textMessage.receiverId), data: textMessage.toJson());
  }

  @override
  void updateOrder(order.Order order) {
    firebaseRemoteService.setData(path: FirebasePath.getPath(order.order_extra.customer_commid, order.order_extra.merchant_commid), data: order.toJson());
  }
}



