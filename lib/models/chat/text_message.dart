import 'package:firebase_database/firebase_database.dart';
import 'package:json_annotation/json_annotation.dart';
/*

part 'text_message.g.dart';
*  text_message.dart
*
*  Created by Yakub Pasha.
*  Copyright © 2020 Tara.id. All rights reserved.
*/
part 'text_message.g.dart';

@JsonSerializable()
class TextMessage {

	factory TextMessage.fromJson(Map<String, dynamic> json) => _$TextMessageFromJson(json);

	factory TextMessage.fromSnapshot(DataSnapshot snapshot) => _$TextMessageFromJson(snapshot.value);

	Map<String, dynamic> toJson() => _$TextMessageToJson(this);
     String type;
     String text;
     String senderId;
     String receiverId;
     DateTime timestamp;

     TextMessage({
      this.type, this.text, this.senderId, this.receiverId, this.timestamp});
}
