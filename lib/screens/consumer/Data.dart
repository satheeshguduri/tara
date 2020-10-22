
import 'dart:math';

import 'package:tara_app/common/constants/assets.dart';

class BackendService {
  static Future<List> getSuggestions(String query) async {
    await Future.delayed(Duration(seconds: 1));

    return List.generate(3, (index) {
      return {'name': query + index.toString(), 'price': Random().nextInt(100)};
    });
  }
}

class CitiesService {

  static final List<String> cities = [
    'Beirut',
    'Damascus',
    'San Fransisco',
    'Rome',
    'Los Angeles',
    'Madrid',
    'Bali',
    'Barcelona',
    'Paris',
    'Bucharest',
    'New York City',
    'Philadelphia',
    'Sydney',
  ];

  static List<String> getSuggestions(String query) {
    List<String> matches = List();
    matches.addAll(cities);

    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }
}

class BankList {
  static List<String> bankList = ["Bank BCA", "BANK BRI", "BANK Mandiri", "Maybank"];
  static List<String> imgList = [
    Assets.ic_bank1,
    Assets.ic_bank2,
    Assets.ic_bank3,
    Assets.ic_bank4
  ];
  static final List<BankModel> arrBanks = List<BankModel>();

  static init(){
    for (var i = 0; i < bankList.length; i++) {
      var paymentSource = BankModel();
      paymentSource.bankName = bankList[i];
      paymentSource.image = imgList[i];
      arrBanks.add(paymentSource);
    }
  }

  static List<BankModel> getSuggestions(String query) {
    List<BankModel> matches = List();
    matches.addAll(arrBanks);
    matches.retainWhere((s) => s.bankName.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }
}

class BankModel {
  String image;
  String bankName;
}


class CountryCodeModel {
  String image;
  String countryName;
  String countryCode;
}

class ContactInfo {
  String name;
  bool isTaraContact;
  String phoneNumber;
}

class ChatInboxInfo {
  String chatTitle;
  String chatSubTitle;
  String chatCardTitle;
  String chatAmount;
}

class NotificationSettingsInfo {
  String settingTitle;
  String settingSubTitle;
  bool isSwitched;
}