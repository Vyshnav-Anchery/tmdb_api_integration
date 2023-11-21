import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mock_machine_test/core/api_consts/api_links.dart';
import 'package:mock_machine_test/features/movie_details/controller/movie_detail_controller.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

class MovieDetailsScreen extends StatelessWidget {
  final int id;
  const MovieDetailsScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
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
              Duration duration = Duration(minutes: snapshot.data!.runtime!);
              String rating = snapshot.data!.voteAverage.toString();
              return Scaffold(
                appBar: AppBar(
                    title: Text(
                  "${snapshot.data!.originalTitle}",
                  style: GoogleFonts.poppins(),
                )),
                body: SingleChildScrollView(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Opacity(
                              opacity: 0.5,
                              child: Container(
                                height: MediaQuery.sizeOf(context).width,
                                width: MediaQuery.sizeOf(context).width,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            "$imageLink${snapshot.data!.posterPath}"),
                                        fit: BoxFit.cover)),
                              ),
                            ),
                            Card(
                                child: Image.network(
                              "$imageLink${snapshot.data!.posterPath}",
                              fit: BoxFit.contain,
                              height: MediaQuery.sizeOf(context).height / 3,
                            )),
                          ],
                        ),
                        Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ListTile(
                                title: Text(
                                  snapshot.data!.originalTitle!,
                                  style: GoogleFonts.poppins(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                  "${snapshot.data!.releaseDate!.year}-${snapshot.data!.releaseDate!.month}-${snapshot.data!.releaseDate!.day}",
                                  style: GoogleFonts.poppins(fontSize: 15),
                                ),
                              ),
                              ListTile(
                                leading: CircularPercentIndicator(
                                  radius: 20.0,
                                  lineWidth: 5.0,
                                  percent: snapshot.data!.voteAverage! / 10,
                                  center: Text(
                                      rating.substring(0, rating.length - 2),
                                      style:
                                          const TextStyle(color: Colors.black)),
                                  progressColor: Colors.green,
                                ),
                                title: const Text("User Ratings"),
                              ),
                              ListTile(
                                title: const Text("Runtime"),
                                subtitle: Text("${duration.inHours} hrs"),
                              ),
                              ListTile(
                                title: const Text("Overview :"),
                                subtitle: Text(snapshot.data!.overview!),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }
          });
    });
  }
}
