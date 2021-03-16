/*
*  chat_repository.dart
*
*  Created by Yakub Pasha.
*  Copyright © 2020 Tara.id. All rights reserved.
*/
import 'package:dartz/dartz.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:tara_app/models/auth/auth_request.dart';
import 'package:tara_app/models/auth/customer_profile.dart';
import 'package:tara_app/models/auth/auth_response.dart';
import 'package:tara_app/models/chat/text_message.dart';
import 'package:tara_app/models/core/base_response.dart';
import 'package:tara_app/services/error/failure.dart';
import 'package:tara_app/models/order_management/orders/order.dart' as order;

abstract class ChatRepository {
  void sendMessage(TextMessage textMessage);
  void updateOrder(order.OrderModel order);
  Query openChatRoom(String senderId, String receiverId);
}



