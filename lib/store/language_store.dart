
import '../models/language/language.dart';
import 'package:mobx/mobx.dart';

part 'language_store.g.dart';

class LanguageStore = _LanguageStore with _$LanguageStore;

abstract class _LanguageStore with Store {
  static const String TAG = "LanguageStore";


  // supported languages
  List<Language> supportedLanguages = [
    Language(code: 'US', locale: 'en', language: 'English'),
    Language(code: 'ID', locale: 'in', language: '--'),
  ];

  // constructor:---------------------------------------------------------------
  _LanguageStore() {
    init();
  }

  // store variables:-----------------------------------------------------------
  @observable
  String _locale = "en";

  @computed
  String get locale => _locale;

  // actions:-------------------------------------------------------------------
  @action
  void changeLanguage(String value) {
    _locale = value;
//    _repository.changeLanguage(value).then((_) {
//      // write additional logic here
//    });
  }

  @action
  String getCode() {
    var code;

    if (_locale == 'en') {
      code = "US";
    } else if (_locale == 'in') {
      code = "ID";
    }

    return code;
  }

  @action
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
