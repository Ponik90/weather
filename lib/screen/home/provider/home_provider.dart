import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:weather_app/screen/home/model/home_model.dart';
import 'package:weather_app/utils/api_helper.dart';
import 'package:weather_app/utils/shared_preference.dart';

class HomeProvider with ChangeNotifier {
  Future<HomeModel?>? model;
  Connectivity connectivity = Connectivity();
  bool isInternet = true;
  String search = 'surat';
  bool isTheme = true;
  List<String> bookMark = [];
  SharedHelper helper = SharedHelper();

  Future<void> setBookmark(String name) async {
    List<String>? data = await helper.getBookmark();
    if (data != null) {
      data.add(name);
      helper.setBookmark(data);
    } else {
      helper.setBookmark([name]);
    }

    getBookmark();
    notifyListeners();
  }

  Future<void> getBookmark() async {
    var list = await helper.getBookmark();
    if (list != null) {
      bookMark = list;
      notifyListeners();
    }
  }

  void deleteBookmark(index) {
    bookMark.removeAt(index);
    helper.getBookmark();
    notifyListeners();
  }

  Future<void> changeTheme() async {
    SharedHelper helper = SharedHelper();
    isTheme = await helper.getTheme();
    notifyListeners();
  }

  void searchData(String data) {
    search = data;
    getWeatherData();
  }

  void checkInternet() {
    connectivity.onConnectivityChanged.listen((event) {
      if (event.contains(ConnectivityResult.none)) {
        isInternet = false;
      } else {
        isInternet = true;
      }
      notifyListeners();
    });
  }

  void getWeatherData() {
    ApiHelper helper = ApiHelper();
    model = helper.getWeatherApi(search: search);
    model!.then((value) {
      if (value != null) {
        notifyListeners();
      }
    });
  }
}
