/*
*  chat_repository_impl.dart
*
*  Created by Yakub Pasha.
*  Copyright © 2020 Tara.id. All rights reserved.
*/
import 'package:dartz/dartz.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:tara_app/models/chat/text_message.dart';
import 'package:tara_app/repositories/chat_repository.dart';
import 'package:tara_app/services/config/firebase_path.dart';
import 'package:tara_app/services/firebase/firebase_remote_service.dart';
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
  void updateOrder(order.OrderModel order) {
    firebaseRemoteService.setData(path: FirebasePath.getPath(order.order_extra.data.customer_commid, order.order_extra.data.merchant_commid), data: order.toJson());
  }
}



