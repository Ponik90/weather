import 'package:shared_preferences/shared_preferences.dart';

class SharedHelper {
  Future<void> setTheme(bool themeData) async {
    SharedPreferences shr = await SharedPreferences.getInstance();
    await shr.setBool('true', themeData);
  }

  Future<bool?> getTheme() async {
    bool? data;
    SharedPreferences shr = await SharedPreferences.getInstance();
    data = shr.getBool('true');
    return data;
  }

  Future<void> setBookmark(List<String> l1) async {
    SharedPreferences shr = await SharedPreferences.getInstance();
    await shr.setStringList('bookmark', l1);
  }

  Future<List<String>?> getBookmark() async {
    List<String>? data = [];
    SharedPreferences shr = await SharedPreferences.getInstance();
    data = shr.getStringList(
      'bookmark',
    );
    return data;
  }
}
