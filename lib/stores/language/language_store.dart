import 'package:boilerplate/data/repository.dart';
import 'package:boilerplate/models/language/Language.dart';
import 'package:boilerplate/stores/error/error_store.dart';
import 'package:mobx/mobx.dart';

part 'language_store.g.dart';

class LanguageStore = _LanguageStore with _$LanguageStore;

abstract class _LanguageStore with Store {
  static const String TAG = "LanguageStore";

  // repository instance
  final Repository _repository;

  // store for handling errors
  final ErrorStore errorStore = ErrorStore();

  // supported languages
  List<Language> supportedLanguages = [
    Language(code: 'US', locale: 'en', language: 'English'),
    Language(code: 'DK', locale: 'da', language: 'Danish'),
    Language(code: 'ES', locale: 'es', language: 'España'),
  ];

  // constructor:---------------------------------------------------------------
  _LanguageStore(Repository repository)
      : this._repository = repository {
    init();
  }

  // store variables:-----------------------------------------------------------
  @observable
  String locale = "en";

//  @computed
//  String get locale => _locale;

  // actions:-------------------------------------------------------------------
  @action
  void changeLanguage(String value) {
    locale = value;
    _repository.changeLanguage(value).then((_) {
      // write additional logic here
    });
  }

  @action
  String getCode() {
    var code;

    if (locale == 'en') {
      code = "US";
    } else if (locale == 'da') {
      code = "DK";
    } else if (locale == 'es') {
      code = "ES";
    }

    return code;
  }

  @action
  String getLanguage() {
    return supportedLanguages[supportedLanguages
            .indexWhere((language) => language.locale == locale)]
        .language;
  }

  // general:-------------------------------------------------------------------
  void init() async {
    // getting current language from shared preference
    _repository?.currentLanguage?.then((locale) {
      if (locale != null) {
        this.locale = locale;
      }
    });
  }

  // dispose:-------------------------------------------------------------------
  @override
  dispose() {}
}
