
import 'package:get/get.dart';

import '../models/language/language.dart';

abstract class LanguageController extends GetxController {
  static const String TAG = "LanguageStore";


  // supported languages
  List<Language> supportedLanguages = [
    Language(code: '', locale: 'en', language: ''),
    Language(code: '', locale: 'id', language: ''),
  ];

  // constructor:---------------------------------------------------------------
  _LanguageStore() {
    init();
  }

  // store variables:-----------------------------------------------------------
  var _locale = "en".obs;

  String get locale => _locale.value;

  // actions:-------------------------------------------------------------------
  // @action
  void changeLanguage(String value) {
    _locale.value = value;
//    _repository.changeLanguage(value).then((_) {
//      // write additional logic here
//    });
  }

  // @action
  String getCode() {
    var code;

    if (_locale == 'en') {
      code = "US";
    } else if (_locale == 'in') {
      code = "ID";
    }

    return code;
  }

  // @action
  String getLanguage() {
    return supportedLanguages[supportedLanguages
            .indexWhere((language) => language.locale == _locale)]
        .language;
  }

  // general:-------------------------------------------------------------------
  void init() async {
    // getting current language from shared preference
    /*_repository?.currentLanguage?.then((locale) {
      if (locale != null) {
        _locale = locale;
      }
    });*/
  }

  // dispose:-------------------------------------------------------------------
  @override
  dispose() {}
}
