import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper{

  static SharedPreferences? shared ;

  static init() async{
    shared = await SharedPreferences.getInstance();
  }

  static Future<bool?> setCacheBool({required String key,required bool value}) async{
    return await shared?.setBool(key, value);
  }

  static bool? getCacheBool({required String key}){
    return shared?.getBool(key);
  }

}