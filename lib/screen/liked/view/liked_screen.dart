import 'package:flutter/material.dart';

class LikedScreen extends StatefulWidget {
  const LikedScreen({super.key});

  @override
  State<LikedScreen> createState() => _LikedScreenState();
}

class _LikedScreenState extends State<LikedScreen> {
  @override
  Widget build(BuildContext context) {
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
                      const SizedBox(
                        width: 50,
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
                    child: const Row(
                      children: [
                        Text("Surat"),
                      ],
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
