

import 'SharedPreferencesProvider.dart';

class AppSharedPreferences {
  
  //todo move these to constants
  static const KEY_ACCESS_TOKEN = "PREF_KEY_ACCESS_TOKEN";
  static const KEY_REFRESH_TOKEN = "PREF_KEY_REFRESH_TOKEN";
  static const KEY_ACCESS_EXPIRE_TOKEN = "PREF_KEY_ACCESS_EXPIRE_TOKEN";
  static const KEY_ACCESS_TOKEN_Firebase = "PREF_KEY_ACCESS_TOKEN_Firebase";
  static const KEY_LANG = "PREF_KEY_LANG";
  static const KEY_FIRST_TIME = "PREF_KEY_FIRST_TIME";
  static const KEY_PERMISSIONS = "PREF_KEY_PERMISSIONS";
  static const KEY_LOCALIZATION = "PREF_KEY_LOCALIZATION";
  static const KEY_VERIFICATION = "PREF_KEY_VERIFICATION";
  static const KEY_PHONE = "PREF_KEY_PHONE";
  static const KEY_USER = "PREF_KEY_USER";
  static const KEY_EMAIL = "PREF_KEY_EMAIL";
  static const KEY_NAME = "PREF_KEY_NAME";
  static const KEY_VendorID = "PREF_KEY_VENDOR";
  static const KEY_PASSWORD = "PREF_KEY_PASSWORD";
  static const KEY_permits = "PREF_KEY_permits";


  static bool initialized;
  static SharedPreferencesProvider _pref;
  static init() async {
    _pref = await SharedPreferencesProvider.getInstance();
  }
  static clear() {
    _pref.clear();
  }
  static clearForLogOut() {

    removeAccessToken();
    removeAccessTokenFirebase();
    removeAccessPhone();
    removeAccessVerification();
    removeAccessPsasword();
    removeAccessPermits();
  }

  //accessToken
  static String get accessToken => _pref.read(KEY_ACCESS_TOKEN);
  static set accessToken(String accessToken) => _pref.save(KEY_ACCESS_TOKEN, accessToken);
  static bool get hasAccessToken => _pref.contains(KEY_ACCESS_TOKEN);
  static removeAccessToken() => _pref.remove(KEY_ACCESS_TOKEN);

  //refresh token
  static String get refreshToken => _pref.read(KEY_REFRESH_TOKEN);
  static set refreshToken(String refreshToken) => _pref.save(KEY_REFRESH_TOKEN, refreshToken);
  static bool get hasAccessRefreshToken => _pref.contains(KEY_REFRESH_TOKEN);
  static removeAccessRefreshToken() => _pref.remove(KEY_REFRESH_TOKEN);

  //expire token
  static String get accessExpire => _pref.read(KEY_ACCESS_EXPIRE_TOKEN);
  static set accessExpire(String accessExpire) => _pref.save(KEY_ACCESS_EXPIRE_TOKEN, accessExpire);


  //accessTokenFirebase
  static String get accessTokenFirebase => _pref.read(KEY_ACCESS_TOKEN_Firebase);
  static set accessTokenFirebase(String accessTokenFirebase) => _pref.save(KEY_ACCESS_TOKEN_Firebase, accessTokenFirebase);
  static bool get hasAccessTokenFirebase => _pref.contains(KEY_ACCESS_TOKEN_Firebase);
  static removeAccessTokenFirebase() => _pref.remove(KEY_ACCESS_TOKEN_Firebase);


  //language
  static String get lang => _pref.read(KEY_LANG);
  static set lang(String lang) => _pref.save(KEY_LANG, lang);

  //FIRST_TIME
  static bool get firstTime {
    if(_pref.readBoolean(KEY_FIRST_TIME) == null)
      firstTime = true;

    return _pref.readBoolean(KEY_FIRST_TIME);
  }
  static set firstTime(bool first) => _pref.saveBoolean(KEY_FIRST_TIME, first);


  //Verification
  static String get accessVerification => _pref.read(KEY_VERIFICATION);
  static set accessVerification(String verification) => _pref.save(KEY_VERIFICATION, verification);
  static bool get hasAccessVerification => _pref.contains(KEY_VERIFICATION);
  static removeAccessVerification() => _pref.remove(KEY_VERIFICATION);


  //phone
  static String get accessPhone => _pref.read(KEY_PHONE);
  static set accessPhone(String phone) => _pref.save(KEY_PHONE, phone);
  static bool get hasAccessPhone => _pref.contains(KEY_PHONE);
  static removeAccessPhone() => _pref.remove(KEY_PHONE);

  //user type
  static String get accessUser => _pref.read(KEY_USER);
  static set accessUser(String role) => _pref.save(KEY_USER, role);

   //email
  static String get accessEmail => _pref.read(KEY_EMAIL);
  static set accessEmail(String email) => _pref.save(KEY_EMAIL, email);
  static bool get hasAccessEmail => _pref.contains(KEY_EMAIL);
  static removeAccessEmail() => _pref.remove(KEY_EMAIL);

  //vendorID


  //name
  static String get accessName => _pref.read(KEY_NAME);
  static set accessName(String name) => _pref.save(KEY_NAME, name);
  static bool get hasAccessName => _pref.contains(KEY_NAME);
  static removeAccessName() => _pref.remove(KEY_NAME);


  //password
  static String get accessPassword => _pref.read(KEY_PASSWORD);
  static set accessPassword(String password) => _pref.save(KEY_PASSWORD, password);
  static bool get hasAccessPassword => _pref.contains(KEY_PASSWORD);
  static removeAccessPsasword() => _pref.remove(KEY_PASSWORD);

  //Permits
  static bool get accessPermits => _pref.read(KEY_permits);
  static set accessPermits(bool permits) => _pref.save(KEY_permits, permits);
  static bool get hasAccessPermits => _pref.contains(KEY_permits);
  static removeAccessPermits() => _pref.remove(KEY_permits);


}
