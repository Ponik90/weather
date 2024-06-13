import 'package:flutter/material.dart';
import 'package:weather_app/screen/home/model/home_model.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    HomeModel model = ModalRoute.of(context)!.settings.arguments as HomeModel;
    return Scaffold(
      body: Container(
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xff30BBBB),
              Color(0xff6CD6D6),
              Color(0xff95FFFF),
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
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50, left: 10, right: 10),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                        ),
                        const Text(
                          "Weather Forecast",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 30,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      padding: const EdgeInsets.all(20),
                      width: MediaQuery.sizeOf(context).width * 0.90,
                      decoration: BoxDecoration(
                        color: const Color(0xff63C9C9),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xff1B6464).withOpacity(0.5),
                            offset: const Offset(5, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          forecast(
                            txt: "Country Name",
                            data: "${model.sys!.country}",
                            icon: Icons.flag,
                          ),
                          forecast(
                            txt: "City Name",
                            data: "${model.name}",
                            icon: Icons.location_city,
                          ),
                          forecast(
                            txt: "Lat",
                            data: "${model.coord!.lat}",
                            icon: Icons.map,
                          ),
                          forecast(
                            txt: "Lon",
                            data: "${model.coord!.lon}",
                            icon: Icons.map,
                          ),
                          forecast(
                            txt: "Time Zone",
                            data: "${model.timezone}",
                            icon: Icons.watch_later,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.all(20),
                      width: MediaQuery.sizeOf(context).width * 0.90,
                      decoration: BoxDecoration(
                        color: const Color(0xff63C9C9),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xff1B6464).withOpacity(0.5),
                            offset: const Offset(5, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          forecast(
                            txt: "Humidity",
                            data: "${model.main!.humidity}",
                            icon: Icons.water_drop,
                          ),
                          forecast(
                            txt: "Pressure",
                            data: "${model.main!.pressure}",
                            icon: Icons.air,
                          ),
                          forecast(
                            txt: "Wind Speed",
                            data: "${model.wind!.speed}",
                            icon: Icons.speed,
                          ),
                          forecast(
                            txt: "Fells like",
                            data: "${model.main!.feels_like}",
                            icon: Icons.thermostat,
                          ),
                          forecast(
                            txt: "Visibility",
                            data: "${model.visibility}",
                            icon: Icons.remove_red_eye,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.all(20),
                      width: MediaQuery.sizeOf(context).width * 0.90,
                      decoration: BoxDecoration(
                        color: const Color(0xff63C9C9),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xff1B6464).withOpacity(0.5),
                            offset: const Offset(5, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          const Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Next week Forecast",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              )),
                          nextWeekForecast(
                            txt: "23/8",
                            data: "23°C",
                            icon: "assets/icon/sun.png",
                          ),
                          nextWeekForecast(
                            txt: "24/8",
                            data: "25°C",
                            icon: "assets/icon/cloud.png",
                          ),
                          nextWeekForecast(
                            txt: "25/8",
                            data: "30°C",
                            icon: "assets/icon/sun_rain.png",
                          ),
                          nextWeekForecast(
                            txt: "26/8",
                            data: "25°C",
                            icon: "assets/icon/moon_fast_wind.png",
                          ),
                          nextWeekForecast(
                            txt: "27/8",
                            data: "33°C",
                            icon: "assets/icon/sun.png",
                          ),
                          nextWeekForecast(
                            txt: "28/8",
                            data: "25°C",
                            icon: "assets/icon/cloud.png",
                          ),
                          nextWeekForecast(
                            txt: "29/8",
                            data: "23°C",
                            icon: "assets/icon/sun_rain.png",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget forecast({required txt, required data, required icon}) {
    return Row(
      children: [
        Text(
          txt,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        const Spacer(),
        Text(
          data,
          style: const TextStyle(color: Colors.white),
        ),
        const Spacer(),
        Icon(
          icon,
        )
      ],
    );
  }

  Widget nextWeekForecast({required txt, required data, required icon}) {
    return Row(
      children: [
        Text(
          txt,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        const Spacer(),
        Text(
          data,
          style: const TextStyle(color: Colors.white),
        ),
        const Spacer(),
        Image.asset(
          icon,
          height: 35,
          width: 35,
        )
      ],
    );
  }
}
