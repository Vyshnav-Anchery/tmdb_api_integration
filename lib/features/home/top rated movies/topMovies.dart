import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mock_machine_test/features/home/controller/home_screen_controller.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

import '../../../core/api_consts/api_links.dart';
import '../../movie_details/view/movie_details_screen.dart';

class TopMoviesScreen extends StatelessWidget {
  const TopMoviesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeScreenController>(builder: (context, provider, child) {
      return FutureBuilder(
          future: provider.requestTopMovies(),
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
                  child: Text("Error getting data.."),
                ),
              );
            } else {
              return Scaffold(
                appBar: AppBar(
                  title: const Text("Top Rated Movies"),
                ),
                body: ListView.builder(
                  itemCount: snapshot.data!.results!.length,
                  itemBuilder: (BuildContext context, int index) {
                    String rating =
                        snapshot.data!.results![index].voteAverage.toString();
                    DateTime releaseDate =
                        snapshot.data!.results![index].releaseDate!;
                    return SizedBox(
                      child: Card(
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
                          child: Row(
                            children: [
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
                              const SizedBox(width: 20),
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: MediaQuery.sizeOf(context).width / 3,
                                    height: 40,
                                    child: Text(
                                      snapshot.data!.results![index].title!,
                                      softWrap: true,
                                      maxLines: 2,
                                      style: GoogleFonts.poppins(),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    children: [
                                      const Text("Rating : "),
                                      const SizedBox(width: 20),
                                      CircleAvatar(
                                        backgroundColor: Colors.black,
                                        child: CircularPercentIndicator(
                                          radius: 20.0,
                                          lineWidth: 5.0,
                                          percent: snapshot
                                                  .data!
                                                  .results![index]
                                                  .voteAverage! /
                                              10,
                                          center: Text(
                                              rating.substring(
                                                  0, rating.length - 2),
                                              style: const TextStyle(
                                                  color: Colors.white)),
                                          progressColor: Colors.green,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    children: [
                                      const Text("Release Year : "),
                                      const SizedBox(width: 10),
                                      Text(
                                          "${releaseDate.day}-${releaseDate.month}-${releaseDate.year}")
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
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
