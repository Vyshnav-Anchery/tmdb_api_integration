import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mock_machine_test/core/api_consts/api_links.dart';
import 'package:mock_machine_test/features/movie_details/view/movie_details_screen.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

import '../../controller/home_screen_controller.dart';

class TopMoviesListview extends StatelessWidget {
  const TopMoviesListview({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeScreenController>(builder: (context, provider, child) {
      return FutureBuilder(
          future: provider.requestTopMovies(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (!snapshot.hasData || snapshot.data == null) {
              return const Text("Error getting data");
            } else {
              return SizedBox(
                width: MediaQuery.sizeOf(context).width,
                height: MediaQuery.sizeOf(context).height / 2.6,
                child: ListView.separated(
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 10),
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    String rating =
                        snapshot.data!.results![index].voteAverage.toString();
                    return Card(
                      elevation: 3,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MovieDetailsScreen(
                                    id: snapshot.data!.results![index].id!),
                              ));
                        },
                        child: Stack(
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // Container(
                            //   height: MediaQuery.sizeOf(context).height / 4,
                            //   decoration: BoxDecoration(
                            //       borderRadius: const BorderRadius.only(
                            //           topLeft: Radius.circular(10),
                            //           topRight: Radius.circular(10)),
                            //       image: DecorationImage(
                            //           image: NetworkImage(
                            //               "$imageLink${snapshot.data!.results![index].posterPath!}"),
                            //           fit: BoxFit.cover)),
                            //   // height: MediaQuery.sizeOf(context).height / 2,
                            //   width: MediaQuery.sizeOf(context).height / 5.5,
                            // ),
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10.0),
                                topRight: Radius.circular(10.0),
                              ),
                              child: Image.network(
                                "$imageLink${snapshot.data!.results![index].posterPath!}",
                                height: 250,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Positioned(
                              left: 20,
                              bottom: 60,
                              child: CircleAvatar(
                                backgroundColor: Colors.black,
                                child: CircularPercentIndicator(
                                  radius: 20.0,
                                  lineWidth: 5.0,
                                  percent: snapshot
                                          .data!.results![index].voteAverage! /
                                      10,
                                  center: Text(
                                      rating.substring(0, rating.length - 2),
                                      style:
                                          const TextStyle(color: Colors.white)),
                                  progressColor: Colors.green,
                                ),
                              ),
                            ),
                            Positioned(
                              left: 10,
                              bottom: 15,
                              child: SizedBox(
                                width: MediaQuery.sizeOf(context).width / 3,
                                height: 40,
                                child: Text(
                                  snapshot.data!.results![index].title!,
                                  softWrap: true,
                                  maxLines: 2,
                                  style: GoogleFonts.poppins(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          });
    });
  }
}
