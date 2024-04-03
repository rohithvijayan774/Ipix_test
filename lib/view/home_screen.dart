import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ipix_test/const.dart';
import 'package:ipix_test/controller/controller.dart';
import 'package:ipix_test/view/restaurant_details.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final homeController = Provider.of<Controller>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'RESTAURANTS',
          style: GoogleFonts.poppins(
              color: Colors.white, fontWeight: FontWeight.w500),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: defaultColor,
        actions: [
          TextButton.icon(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text(
                        'Logout Confirmation',
                        style: GoogleFonts.poppins(),
                      ),
                      content: Text('Are you sure you want to logout?',
                          style: GoogleFonts.poppins()),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(); // Close the dialog
                          },
                          child: Text('Cancel', style: GoogleFonts.poppins()),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            homeController.removeLoginCredentials(context);
                          },
                          child: Text('Logout', style: GoogleFonts.poppins()),
                        ),
                      ],
                    );
                  },
                );
              },
              icon: const Icon(
                Iconsax.logout,
                color: Colors.white,
              ),
              label: Text(
                'Log out',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                ),
              ))
        ],
      ),
      body: Consumer<Controller>(builder: (context, homeScreenController, _) {
        return FutureBuilder(
            future: homeScreenController.fetchRestaurants(),
            builder: (context, snapshot) {
              return snapshot.connectionState == ConnectionState.waiting
                  ? Center(
                      child: LoadingAnimationWidget.twistingDots(
                        leftDotColor: Colors.black,
                        rightDotColor: defaultColor,
                        size: 50,
                      ),
                    )
                  : ListView.separated(
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 20,
                      ),
                      itemCount: homeScreenController.restaurantsList.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        FadeTransition(
                                  opacity: animation,
                                  child: RestaurantDetails(
                                    name: homeScreenController
                                        .restaurantsList[index].name!,
                                    neighborhood: homeScreenController
                                        .restaurantsList[index].neighborhood!,
                                    photograph: homeScreenController
                                        .restaurantsList[index].photograph!,
                                    address: homeScreenController
                                        .restaurantsList[index].address!,
                                    latlng: homeScreenController
                                        .restaurantsList[index].latlng!,
                                    cuisineType: homeScreenController
                                        .restaurantsList[index].cuisineType!,
                                    operatingHours: homeScreenController
                                        .restaurantsList[index].operatingHours!,
                                    reviews: homeScreenController
                                        .restaurantsList[index].reviews!,
                                  ),
                                ),
                                transitionDuration:
                                    const Duration(milliseconds: 200),
                                reverseTransitionDuration:
                                    const Duration(milliseconds: 200),
                              ),
                            );

                            // Navigator.of(context).push(MaterialPageRoute(
                            //   builder: (context) => const RestaurantDetails(),
                            // ));
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Card(
                              child: Container(
                                padding: const EdgeInsets.only(bottom: 10),
                                width: size.width,
                                // height: size.height / 2.8,
                                child: Column(
                                  children: [
                                    Hero(
                                      transitionOnUserGestures: true,
                                      tag: 'tag_1',
                                      child: Container(
                                        height: 180,
                                        decoration: const BoxDecoration(
                                            color: Colors.grey,
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    'assets/restaurant-interior.jpg'),
                                                fit: BoxFit.cover)),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                homeScreenController
                                                    .restaurantsList[index]
                                                    .name!,
                                                style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 20),
                                              ),
                                              Card(
                                                color: Colors.green,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(2.0),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        '3.7',
                                                        style:
                                                            GoogleFonts.poppins(
                                                                color: Colors
                                                                    .white),
                                                      ),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      const Icon(
                                                        Icons.star,
                                                        size: 15,
                                                        color: Colors.white,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(2),
                                                decoration: const BoxDecoration(
                                                    color: Colors.grey,
                                                    shape: BoxShape.circle),
                                                child: const ImageIcon(
                                                  AssetImage(
                                                      'assets/knife_logo.png'),
                                                  size: 12,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                homeScreenController
                                                    .restaurantsList[index]
                                                    .cuisineType!,
                                                style: GoogleFonts.poppins(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              )
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                  padding:
                                                      const EdgeInsets.all(2),
                                                  decoration:
                                                      const BoxDecoration(
                                                          color: Colors.grey,
                                                          shape:
                                                              BoxShape.circle),
                                                  child: const Icon(
                                                    Icons.location_on_sharp,
                                                    size: 12,
                                                    color: Colors.white,
                                                  )),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                homeScreenController
                                                    .restaurantsList[index]
                                                    .address!,
                                                style: GoogleFonts.poppins(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
            });
      }),
    );
  }
}
