import 'package:shared_preferences/shared_preferences.dart';

//sharedPreference to save data ((key),(value))
class CacheHelper {
  static late final SharedPreferences sharedPreferences;

  //to defined SP
  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  //to put data in SP as DB
  static Future<bool> putBool(
      {required String key, required bool value}) async {
    return await sharedPreferences.setBool(key, value);
  }

  //to get data from SP
  static bool getBool({required String key}) {
    return sharedPreferences.getBool(key)!;
  }
}
