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
                      const SizedBox(
                        width: 30,
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
                ],
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
        const SizedBox(
          width: 20,
        ),
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
}
