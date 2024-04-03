import 'package:flutter/material.dart';
import 'package:ipix_test/const.dart';
import 'package:ipix_test/controller/controller.dart';
import 'package:ipix_test/view/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Controller>(
          create: (context) => Controller(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: defaultColor),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
