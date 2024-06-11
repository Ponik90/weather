import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/screen/home/model/home_model.dart';
import 'package:weather_app/screen/home/provider/home_provider.dart';
import 'package:weather_app/screen/no_internet/view/no_internet_screen.dart';
import 'package:weather_app/utils/shared_preference.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController txtSearch = TextEditingController();
  HomeProvider? providerR;
  HomeProvider? providerW;

  @override
  void initState() {
    super.initState();
    context.read<HomeProvider>().checkInternet();
    if (context.read<HomeProvider>().isInternet == true) {
      context.read<HomeProvider>().getWeatherData();
    } else {
      const NoInternetScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    providerR = context.read<HomeProvider>();
    providerW = context.watch<HomeProvider>();
    return providerW!.isInternet == true
        ? Scaffold(
            appBar: AppBar(
              title: const Text("Weather App"),
              actions: [
                // IconButton(
                //   onPressed: () {
                //     SharedHelper shr = SharedHelper();
                //     shr.setTheme(providerW!.isTheme);
                //     print(providerW!.isTheme);
                //     providerR!.changeTheme();
                //   },
                //   icon: const Icon(Icons.wb_sunny_outlined),
                // ),
                Switch(
                  value: providerW!.isTheme,
                  onChanged: (value) {
                    SharedHelper helper = SharedHelper();
                    helper.setTheme(value);
                    providerR!.changeTheme();
                  },
                ),
                IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return BottomSheet(
                          onClosing: () {},
                          builder: (context) {
                            return SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Column(
                                children: [
                                  ListView.builder(
                                    itemCount: providerW!.bookMark.length,
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        title: Text(providerW!.bookMark[index]),
                                      );
                                    },
                                  )
                                ],
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                  icon: const Icon(Icons.bookmark_border_rounded),
                ),
              ],
            ),
            body: Stack(
              children: [
                Image.asset(
                  "assets/image/bg.jpg",
                  height: MediaQuery.sizeOf(context).height,
                  width: MediaQuery.sizeOf(context).width,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      SearchBar(
                        controller: txtSearch,
                        leading: IconButton(
                          onPressed: () {
                            if (txtSearch.text.isNotEmpty) {
                              providerR!.searchData(txtSearch.text);
                            }
                          },
                          icon: const Icon(Icons.search),
                        ),
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
                                    Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Navigator.pushNamed(
                                                context, 'detail',
                                                arguments: model);
                                          },
                                          child: Text(
                                            "${model!.name}",
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 35,
                                            ),
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            providerR!.getBookmark([model.name,model.main!.temp]);
                                          },
                                          icon: const Icon(
                                            Icons.bookmark_add_outlined,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "${model.clouds!.all} °C",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "${model.weather![0]!.main}",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "${model.weather![0]!.description}",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                      ),
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
                                            detail: "${model.main!.temp}"),
                                        weatherDetail(
                                            icon: Icons.air_outlined,
                                            detail: "${model.main!.pressure}"),
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
                                            icon: Icons.water_drop_outlined,
                                            detail: "${model.main!.humidity}"),
                                        weatherDetail(
                                            icon: Icons.speed_outlined,
                                            detail: "${model.wind!.speed}"),
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
                                          icon: Icons.wb_sunny_rounded,
                                          detail: "${model.sys!.sunrise}",
                                        ),
                                        weatherDetail(
                                          icon: Icons.sunny_snowing,
                                          detail: "${model.sys!.sunset}",
                                        ),
                                      ],
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
                )
              ],
            ),
          )
        : const NoInternetScreen();
  }

  Widget weatherDetail({required icon, required detail}) {
    return Column(
      children: [
        Icon(
          icon,
          color: Colors.white,
        ),
        Text(
          detail,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
