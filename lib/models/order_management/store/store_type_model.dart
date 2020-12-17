import 'package:json_annotation/json_annotation.dart';
/*
*  store_type_model.dart
*
*  Created by Yakub Pasha.
*  Copyright © 2020 Tara.id. All rights reserved.
*/

import 'package:tara_app/models/order_management/store/store_type.dart';
import 'package:tara_app/models/order_management/store/store_type_association.dart';

part 'store_type_model.g.dart';

@JsonSerializable()
class StoreTypeModel {
  double id;
//  StoreTypes type;
  String type;
  List<StoreTypeAssociation> storeTypeAssociations;

  StoreTypeModel({this.id, this.type, this.storeTypeAssociations});

  factory StoreTypeModel.fromJson(Map<String, dynamic> json) => _$StoreTypeModelFromJson(json);
  Map<String, dynamic> toJson( instance) => _$StoreTypeModelToJson(this);


}

class StoreTypeResponse{
  List<StoreTypeModel> storeTypesList;
}