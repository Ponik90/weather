import 'package:flutter/material.dart';
import 'package:weather_app/screen/detail/view/detail_screen.dart';
import 'package:weather_app/screen/home/view/home_screen.dart';
import 'package:weather_app/screen/liked/view/liked_screen.dart';
import 'package:weather_app/screen/splash/view/splash_screen.dart';

Map<String, WidgetBuilder> screen = {
  '/': (context) => const SplashScreen(),
  'home': (context) => const HomeScreen(),
  'detail': (context) => const DetailScreen(),
  'liked': (context) => const LikedScreen(),
};
