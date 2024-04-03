import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ipix_test/const.dart';
import 'package:ipix_test/controller/controller.dart';
import 'package:ipix_test/model/restaurant_model.dart';
import 'package:provider/provider.dart';

class RestaurantDetails extends StatelessWidget {
  final String name;
  final String neighborhood;
  final String photograph;
  final String address;
  final Latlng latlng;
  final String cuisineType;
  final OperatingHours operatingHours;
  final List<Reviews> reviews;

  const RestaurantDetails(
      {required this.name,
      required this.neighborhood,
      required this.photograph,
      required this.address,
      required this.latlng,
      required this.cuisineType,
      required this.operatingHours,
      required this.reviews,
      super.key});

  @override
  Widget build(BuildContext context) {
    final mapController = Provider.of<Controller>(context, listen: false);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(name),
            backgroundColor: defaultColor,
            pinned: true,
            expandedHeight: 250,
            stretch: true,
            flexibleSpace: const FlexibleSpaceBar(
              stretchModes: [StretchMode.blurBackground],
              background: Hero(
                tag: 'tag_1',
                child: Image(
                  image: AssetImage('assets/restaurant-interior.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            name,
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500, fontSize: 22),
                          ),
                          Card(
                            color: Colors.green,
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Row(
                                children: [
                                  Text(
                                    '3.7',
                                    style: GoogleFonts.poppins(
                                        color: Colors.white),
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
                        height: 10,
                      ),
                      Text(
                        neighborhood,
                        style: GoogleFonts.poppins(fontSize: 15),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(2),
                            decoration: const BoxDecoration(
                                color: Colors.grey, shape: BoxShape.circle),
                            child: const ImageIcon(
                              AssetImage('assets/knife_logo.png'),
                              size: 12,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            cuisineType,
                            style: GoogleFonts.poppins(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Container(
                              padding: const EdgeInsets.all(2),
                              decoration: const BoxDecoration(
                                  color: Colors.grey, shape: BoxShape.circle),
                              child: const Icon(
                                Icons.location_on_sharp,
                                size: 12,
                                color: Colors.white,
                              )),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            address,
                            style: GoogleFonts.poppins(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Container(
                              padding: const EdgeInsets.all(2),
                              decoration: const BoxDecoration(
                                  color: Colors.grey, shape: BoxShape.circle),
                              child: const Icon(
                                Icons.access_time_filled_rounded,
                                size: 12,
                                color: Colors.white,
                              )),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Wednesday: ${operatingHours.wednesday!}",
                            style: GoogleFonts.poppins(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Rating & Reviews',
                        style: GoogleFonts.poppins(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: reviews.length,
              (context, index) {
                return Consumer<Controller>(
                    builder: (context, ratingController, _) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Card(
                              color: Colors.green,
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Row(
                                  children: [
                                    Text(
                                      reviews[index].rating!.toString(),
                                      style: GoogleFonts.poppins(
                                          color: Colors.white),
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
                            ),
                            Text(
                              reviews[index].name!,
                              style: GoogleFonts.poppins(
                                  fontSize: 17, fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        Text(
                          reviews[index].comments!,
                          maxLines: ratingController.readmore == false ? 3 : 50,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                              fontSize: 15, fontWeight: FontWeight.w400),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: TextButton(
                              onPressed: () {
                                ratingController.changeReadMore();
                              },
                              child: Text(
                                ratingController.readmore == false
                                    ? 'Read more...'
                                    : 'Read less...',
                                style: GoogleFonts.poppins(color: Colors.grey),
                              )),
                        ),
                        Text(
                          reviews[index].date!,
                          style:
                              GoogleFonts.poppins(fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Divider()
                      ],
                    ),
                  );
                });
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          mapController.launchGoogleMap(latlng.lat!, latlng.lng!);
        },
        backgroundColor: defaultColor,
        shape: const CircleBorder(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.turn_right,
              color: Colors.white,
            ),
            Text(
              'GO',
              style: GoogleFonts.poppins(
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
