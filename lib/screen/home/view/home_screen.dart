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
                IconButton(
                  onPressed: () {
                    SharedHelper shr = SharedHelper();
                    shr.setTheme(providerW!.isTheme);
                    providerR!.changeTheme();
                  },
                  icon: const Icon(Icons.wb_sunny_outlined),
                ),
                IconButton(
                  onPressed: () {},
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
                            providerR!.searchData(txtSearch.text);
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
                            return Text("${model!.name}");
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
}
