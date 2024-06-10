import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/screen/home/provider/home_provider.dart';
import 'package:weather_app/utils/app_routes.dart';
import 'package:weather_app/utils/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
    ],
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: HomeProvider(),
        ),
      ],
      child: Consumer<HomeProvider>(
        builder: (context, value, child) {
          value.changeTheme();
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            routes: screen,
            theme: lightTheme,
            darkTheme: darkTheme,
          );
        },
      ),
    ),
  );
}
