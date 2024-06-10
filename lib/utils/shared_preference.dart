import 'package:shared_preferences/shared_preferences.dart';

class SharedHelper {
  Future<void> setTheme(bool themeData) async {
    SharedPreferences shr = await SharedPreferences.getInstance();
    await shr.setBool('true', themeData);
  }

  Future<bool> getTheme() async {
    bool? data;
    SharedPreferences shr = await SharedPreferences.getInstance();
    data = shr.getBool('true')!;
    return data;
  }
}
