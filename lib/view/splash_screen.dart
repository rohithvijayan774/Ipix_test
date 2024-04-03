import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ipix_test/const.dart';
import 'package:ipix_test/controller/controller.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final splashController = Provider.of<Controller>(context);
    return Scaffold(
      body: FutureBuilder(
          future: splashController.checkLoginStatus(context),
          builder: (context, snapshot) {
            return Center(
              child: SizedBox(
                width: size.width,
                height: size.height * 0.07,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/cart_splash.png',
                      scale: 10,
                    ),
                    const VerticalDivider(
                      color: defaultColor,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'The',
                          style: GoogleFonts.poppins(color: defaultColor),
                        ),
                        Row(
                          children: [
                            Text('Grand ',
                                style: GoogleFonts.poppins(
                                    color: defaultColor, fontSize: 20)),
                            Text('Marche',
                                style: GoogleFonts.poppins(
                                    color: const Color.fromARGB(255, 5, 49, 85),
                                    fontSize: 20)),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
