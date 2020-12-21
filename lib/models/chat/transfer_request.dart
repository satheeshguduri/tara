import 'package:firebase_database/firebase_database.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tara_app/models/chat/message_type.dart';
/*

part 'transfer_request.g.dart';
*  transfer_request.dart
*
*  Created by Yakub Pasha.
*  Copyright © 2020 Tara.id. All rights reserved.
*/

part 'transfer_request.g.dart';

@JsonSerializable()
class TransferRequest {
     MessageType messageType;
     String payeeId;
     String payerId;
     num amount;
     DateTime timestamp;
     String status;

     TransferRequest({this.payeeId, this.payerId, this.amount, this.timestamp, this.status,this.messageType});

     factory TransferRequest.fromJson(Map<String, dynamic> json) => _$TransferRequestFromJson(json);

     factory TransferRequest.fromSnapShot(DataSnapshot snapshot) => _$TransferRequestFromJson(snapshot.value);

     Map<String, dynamic> toJson() => _$TransferRequestToJson(this);


}
