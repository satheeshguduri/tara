import 'package:json_annotation/json_annotation.dart';

part 'banner_data.g.dart';

@JsonSerializable()
class BannerData {
  String title;
  String url;

  BannerData({this.title, this.url});

  factory BannerData.fromJson(Map<String, dynamic> json) => _$BannerDataFromJson(json);

  Map<String, dynamic> toJson() => _$BannerDataToJson(this);
}

