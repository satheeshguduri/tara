import 'package:json_annotation/json_annotation.dart';
part 'register_store.g.dart';
@JsonSerializable()
class RegisterStore{



   String storeId;
   String picUrl;
   String registrationDocUrl;


   RegisterStore(this.storeId, this.picUrl, this.registrationDocUrl);

  factory RegisterStore.fromJson(Map<String, dynamic> json) => _$RegisterStoreFromJson(json);

Map<String, dynamic> toJson() => _$RegisterStoreToJson(this);

}