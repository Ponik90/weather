import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/screen/home/model/home_model.dart';
import 'package:weather_app/screen/home/provider/home_provider.dart';
import 'package:weather_app/screen/no_internet/view/no_internet_screen.dart';
import 'package:lottie/lottie.dart';

import '../../../utils/shared_preference.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController txtSearch = TextEditingController();
  HomeProvider? providerR;
  HomeProvider? providerW;
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    context.read<HomeProvider>().checkInternet();
    if (context.read<HomeProvider>().isInternet == true) {
      context.read<HomeProvider>().getWeatherData();
    } else {
      const NoInternetScreen();
    }
    context.read<HomeProvider>().getBookmark();
  }

  @override
  Widget build(BuildContext context) {
    providerR = context.read<HomeProvider>();
    providerW = context.watch<HomeProvider>();
    if (providerW!.isInternet == true) {
      return Scaffold(
        key: scaffoldKey,
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            height: MediaQuery.sizeOf(context).height,
            width: MediaQuery.sizeOf(context).width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: providerW!.isTheme == false
                    ? [
                        const Color(0xff257c7c),
                        const Color(0xff267e7e),
                        const Color(0xff183e3e),
                      ]
                    : [
                        const Color(0xff30BBBB),
                        const Color(0xff6CD6D6),
                        const Color(0xff95FFFF),
                      ],
              ),
            ),
            child: Stack(
              children: [
                Image.asset(
                  "assets/image/bg.png",
                  height: MediaQuery.sizeOf(context).height,
                  width: MediaQuery.sizeOf(context).width,
                  opacity: const AlwaysStoppedAnimation(0.7),
                  fit: BoxFit.fill,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                scaffoldKey.currentState!.openDrawer();
                              },
                              icon: Icon(
                                Icons.menu,
                                size: 30,
                                color: providerW!.isTheme == false
                                    ? Colors.black45
                                    : Colors.white,
                              ),
                            ),
                            Expanded(
                              child: TextField(
                                controller: txtSearch,
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  hintText: "Enter location",
                                  hintStyle: const TextStyle(
                                    color: Color(0xff88BBBB),
                                    fontSize: 18,
                                  ),
                                  contentPadding: const EdgeInsets.all(5),
                                  prefixIcon: IconButton(
                                    onPressed: () {
                                      if (txtSearch.text.isNotEmpty) {
                                        providerR!.searchData(txtSearch.text);
                                      }
                                    },
                                    icon: const Icon(Icons.search),
                                    color: const Color(0xff1B6464),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      FutureBuilder(
                        future: providerW!.model,
                        builder: (context, snapshot) {
                          HomeModel? model = snapshot.data;
                          if (snapshot.hasError) {
                            return const Text("Check Network");
                          } else if (snapshot.hasData) {
                            return SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(20),
                                      width: MediaQuery.sizeOf(context).width *
                                          0.90,
                                      decoration: BoxDecoration(
                                        color: providerW!.isTheme == false
                                            ? const Color(0xff448787)
                                            : const Color(0xff63C9C9)
                                                .withOpacity(0.7),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Column(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Navigator.pushNamed(
                                                context,
                                                'detail',
                                                arguments: model,
                                              );
                                            },
                                            child: Align(
                                              alignment: Alignment.topRight,
                                              child: Text(
                                                "Show Forecast >>",
                                                style: TextStyle(
                                                  color: Colors.white
                                                      .withOpacity(0.7),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "${model!.name}",
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 30,
                                                    ),
                                                  ),
                                                  const Text(
                                                    "Mon 3/5/22",
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.white,
                                                    ),
                                                  )
                                                ],
                                              ),
                                              const Spacer(),
                                              IconButton(
                                                onPressed: () {
                                                  providerR!
                                                      .setBookmark(model.name!);
                                                },
                                                icon: const Icon(
                                                  Icons.favorite,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "${model.main!.temp} °C",
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 40,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text(
                                                    "${model.weather![0]!.main}",
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 25,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text(
                                                    "${model.weather![0]!.description}",
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 25,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const Spacer(),
                                              Image.asset(
                                                "assets/image/weather.png",
                                                height: 86,
                                                width: 79,
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              weatherDetail(
                                                  icon: Icons.thermostat,
                                                  detail:
                                                      "${model.main!.temp}"),
                                              weatherDetail(
                                                  icon: Icons.air_outlined,
                                                  detail:
                                                      "${model.main!.pressure}"),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(20),
                                      width: MediaQuery.sizeOf(context).width *
                                          0.90,
                                      decoration: BoxDecoration(
                                        color: providerW!.isTheme == false
                                            ? const Color(0xff448787)
                                            : const Color(0xff63C9C9)
                                                .withOpacity(0.7),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Today ${model.main!.temp}°C",
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                            ),
                                          ),
                                          SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              children: [
                                                weatherTime(
                                                  time: "5:00",
                                                  icon:
                                                      "assets/icon/sunrise.png",
                                                  temp: "sunrise",
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                weatherTime(
                                                  time: "6:00",
                                                  icon: "assets/icon/sun.png",
                                                  temp: "29°C",
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                weatherTime(
                                                  time: "8:00",
                                                  icon:
                                                      "assets/icon/sun_rain.png",
                                                  temp: "28°C",
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                weatherTime(
                                                  time: "10:00",
                                                  icon: "assets/icon/cloud.png",
                                                  temp: "32°C",
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                weatherTime(
                                                  time: "12:00",
                                                  icon: "assets/icon/cloud.png",
                                                  temp: "32°C",
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                weatherTime(
                                                  time: "14:00",
                                                  icon: "assets/icon/cloud.png",
                                                  temp: "34°C",
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                weatherTime(
                                                  time: "16:00",
                                                  icon:
                                                      "assets/icon/sun_rain.png",
                                                  temp: "34°C",
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                weatherTime(
                                                  time: "18:00",
                                                  icon:
                                                      "assets/icon/sunset.png",
                                                  temp: "33°C",
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                weatherTime(
                                                  time: "20:00",
                                                  icon:
                                                      "assets/icon/moon_fast_wind.png",
                                                  temp: "31°C",
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                weatherTime(
                                                  time: "22:00",
                                                  icon:
                                                      "assets/icon/moon_fast_wind.png",
                                                  temp: "31°C",
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                weatherTime(
                                                  time: "24:00",
                                                  icon:
                                                      "assets/icon/moon_rain.png",
                                                  temp: "31°C",
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Lottie.asset(
                                      "assets/lottie/animation.json",
                                      width: MediaQuery.sizeOf(context).width,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                          return const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        drawer: Drawer(
          child: Container(
            height: MediaQuery.sizeOf(context).height,
            width: MediaQuery.sizeOf(context).width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: providerW!.isTheme == false
                    ? [
                        const Color(0xff257c7c),
                        const Color(0xff267e7e),
                        const Color(0xff183e3e),
                      ]
                    : [
                        const Color(0xff30BBBB),
                        const Color(0xff6CD6D6),
                        const Color(0xff95FFFF),
                      ],
              ),
            ),
            child: Stack(
              children: [
                Image.asset(
                  "assets/image/bg.png",
                  height: MediaQuery.sizeOf(context).height,
                  width: MediaQuery.sizeOf(context).width,
                  opacity: const AlwaysStoppedAnimation(0.7),
                  fit: BoxFit.fill,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 50,
                    left: 10,
                    right: 10,
                  ),
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/image/logo.png",
                        height: 200,
                        width: 200,
                      ),
                      const Divider(),
                      Row(
                        children: [
                          const Text(
                            "Theme",
                            style: TextStyle(fontSize: 18),
                          ),
                          const Spacer(),
                          Switch(
                            activeColor: const Color(0xff3c7878),
                            inactiveThumbColor: const Color(0xff63C9C9),
                            value: providerW!.isTheme,
                            onChanged: (value) {
                              SharedHelper helper = SharedHelper();
                              helper.setTheme(value);
                              providerR!.changeTheme();
                            },
                          ),
                        ],
                      ),
                      ListTile(
                        contentPadding: const EdgeInsets.only(right: 10),
                        onTap: () {
                          Navigator.pushNamed(context, 'liked');
                        },
                        title: const Text("Liked City"),
                        trailing: Icon(
                          Icons.favorite,
                          color: providerW!.isTheme == false
                              ? const Color(0xff63C9C9)
                              : const Color(0xff3c7878),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return const NoInternetScreen();
    }
  }

  Widget weatherDetail({required icon, required detail}) {
    return Container(
      width: 120,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xff16C9C9).withOpacity(0.6),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Icon(
            icon,
          ),
          Text(
            detail,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget weatherTime({required time, required icon, required temp}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          time,
          style: const TextStyle(color: Colors.white),
        ),
        Image.asset(
          icon,
          height: 30,
          width: 30,
        ),
        Text(
          temp,
          style: const TextStyle(color: Colors.white),
        )
      ],
    );
  }
}
