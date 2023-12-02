import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mock_machine_test/core/api_consts/api_links.dart';
import 'package:mock_machine_test/screens/movie_details/controller/movie_detail_controller.dart';
import 'package:provider/provider.dart';

import '../../../core/common widgets/movie_clipper.dart';

class MovieDetailsScreen extends StatelessWidget {
  final int id;
  const MovieDetailsScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Consumer<MovieDetailController>(builder: (context, provider, child) {
      return FutureBuilder(
          future: provider.getMoviesDetails(id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            if (!snapshot.hasData || snapshot.data == null) {
              return const Scaffold(
                body: Center(
                  child: Text("Error getting data"),
                ),
              );
            } else {
              return Scaffold(
                body: CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      floating: true,
                      pinned: true,
                      iconTheme: const IconThemeData(color: Colors.grey),
                      expandedHeight: screenHeight / 1.4,
                      backgroundColor: Colors.transparent,
                      centerTitle: true,
                      title: Image.asset(
                        "assets/logo/netflix_logo.png",
                        width: MediaQuery.sizeOf(context).height / 10,
                      ),
                      flexibleSpace: FlexibleSpaceBar(
                        collapseMode: CollapseMode.none,
                        background: Stack(
                          children: [
                            // Image.network(
                            //     "$imageLink${snapshot.data!.posterPath}",
                            //     fit: BoxFit.cover),
                            Column(
                              children: [
                                ClipPath(
                                  clipper: MovieImageBannerClipper(),
                                  child: Container(
                                    height: screenHeight / 1.5,
                                    width: screenWidth,
                                    decoration: const BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black45,
                                          blurRadius: 10.0,
                                        ),
                                      ],
                                    ),
                                    child: Image(
                                      image: NetworkImage(
                                          "$imageLink${snapshot.data!.posterPath}"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Positioned(
                              left: screenWidth / 2 - 40,
                              top: screenHeight / 1.63,
                              child: GestureDetector(
                                onTap: () {},
                                child: Container(
                                  width: 80.0,
                                  height: 80.0,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(40.0),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.black45,
                                          blurRadius: 4.0,
                                        )
                                      ]),
                                  child: const Icon(
                                    Icons.play_arrow,
                                    color: Colors.red,
                                    size: 50.0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      actions: [
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.favorite_border))
                      ],
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        margin: const EdgeInsets.all(30),
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                snapshot.data!.title!,
                                style: GoogleFonts.poppins(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 20),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: snapshot.data!.genres!
                                      .map((e) => Text("${e.name!} "))
                                      .toList()),
                              const SizedBox(height: 20),
                              RatingBarIndicator(
                                rating: snapshot.data!.voteAverage! /
                                    2.roundToDouble(),
                                itemBuilder: (context, index) => const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                itemCount: 5,
                                itemSize: 30.0,
                                direction: Axis.horizontal,
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    children: [
                                      const Text("Year"),
                                      Text(
                                        snapshot.data!.releaseDate!.year
                                            .toString(),
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      const Text("Country"),
                                      Text(
                                        snapshot.data!.productionCountries!
                                            .first.iso31661!,
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      const Text("Length"),
                                      Text(
                                        "${snapshot.data!.runtime} min",
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Text(
                                snapshot.data!.overview!,
                                style: GoogleFonts.poppins(),
                                // textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            }
          });
    });
  }
}
