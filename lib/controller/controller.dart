import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ipix_test/const.dart';
import 'package:ipix_test/model/restaurant_model.dart';
import 'package:ipix_test/view/home_screen.dart';
import 'package:ipix_test/view/splash_screen.dart';
import 'package:ipix_test/view/user_login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class Controller extends ChangeNotifier {
  final loginKey = GlobalKey<FormState>();
  TextEditingController userNameController = TextEditingController();
  TextEditingController userPasswordController = TextEditingController();

////////////////////////////////// FETCH RESTAURANTS //////////////////////////

  List<Restaurants> restaurantsList = [];

  Future<void> fetchRestaurants() async {
    try {
      var response = await http.get(Uri.parse(ipixAPI));
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        if (jsonData['restaurants'] != null) {
          List<Restaurants> restaurants = [];
          for (var items in jsonData['restaurants']) {
            restaurants.add(Restaurants.fromJson(items));
          }
          restaurantsList = restaurants;
        }
      }
    } catch (e) {
      print('Something went wrong/////////// $e');
    }
  }

  bool readmore = false;
  void changeReadMore() {
    if (readmore == true) {
      readmore = false;
    } else {
      readmore = true;
    }
    notifyListeners();
  }

  bool obscureText = true;

  void changeObscure() {
    if (obscureText == true) {
      obscureText = false;
    } else {
      obscureText = true;
    }

    notifyListeners();
  }

  bool rememberme = false;

  void rememberUser() {
    if (rememberme == true) {
      rememberme = false;
    } else {
      rememberme = true;
    }

    notifyListeners();
  }

  //////////////////////////// SHARED PREFERENCE /////////////////////////////

  void saveLoginCredentials(String username, String password, context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('username', username);
    prefs.setString('password', password);

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );

    userNameController.clear();
    userPasswordController.clear();
  }

  Future<void> checkLoginStatus(context) async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? username = prefs.getString('username');
      String? password = prefs.getString('password');

      if (username != null && password != null) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const UserLogin()),
        );
      }
    } catch (e) {
      print("//////////////////// $e");
    }
  }

  void removeLoginCredentials(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('username');
    prefs.remove('password');

    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        ),
        (route) => false);
  }

  //////////////////// Google Map ///////////////////////////////////////

  void openGoogleMaps(double latitude, double longitude) async {
    String googleMapsUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';

    if (await canLaunchUrl(Uri.parse(googleMapsUrl))) {
      await launchUrl(
        Uri.parse(googleMapsUrl),
      );
    } else {
      throw 'Could not launch Google Maps';
    }
  }

  Future<void> launchGoogleMap(double latitude, double longitude) async {
    String googleMapsUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (!await launchUrl(Uri.parse(googleMapsUrl))) {
      throw Exception('Could not launch ${Uri.parse(googleMapsUrl)}');
    }
  }
}
