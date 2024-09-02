import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../home/provider/home_provider.dart';

class LikedScreen extends StatefulWidget {
  const LikedScreen({super.key});

  @override
  State<LikedScreen> createState() => _LikedScreenState();
}

class _LikedScreenState extends State<LikedScreen> {
  HomeProvider? providerR;
  HomeProvider? providerW;

  @override
  void initState() {
    super.initState();
    context.read<HomeProvider>().getBookmark();
  }

  @override
  Widget build(BuildContext context) {
    providerW = context.watch<HomeProvider>();
    providerR = context.read<HomeProvider>();
    return Scaffold(
      body: Container(
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
                        "City Weather",
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
                  Expanded(
                    child: ListView.builder(
                      itemCount: providerR!.bookMark.length,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.all(10),
                          width: MediaQuery.sizeOf(context).width * 0.90,
                          decoration: BoxDecoration(
                            color: providerW!.isTheme == false
                                ? const Color(0xff448787)
                                : const Color(0xff63C9C9),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xff1B6464).withOpacity(0.5),
                                offset: const Offset(5, 5),
                              ),
                            ],
                          ),
                          child: ListTile(
                            leading: Text(
                              providerR!.bookMark[index],
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                            title: Image.asset(
                              "assets/icon/sun_rain.png",
                              height: 50,
                              width: 50,
                            ),
                            trailing: IconButton(
                              onPressed: () {
                                providerW!.deleteBookmark(index);
                              },
                              icon: const Icon(
                                Icons.close,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
