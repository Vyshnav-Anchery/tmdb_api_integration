import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mock_machine_test/core/api_consts/api_links.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

import '../controller/series_detail_controller.dart';

class SeriesDetailsScreen extends StatelessWidget {
  final int id;
  const SeriesDetailsScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Consumer<SeriesDetailsController>(
        builder: (context, provider, child) {
      return FutureBuilder(
          future: provider.getSeriesDetails(id),
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
              String rating = snapshot.data!.voteAverage.toString();
              return Scaffold(
                appBar: AppBar(
                    title: Text(
                  "${snapshot.data!.name}",
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
                                  snapshot.data!.name!,
                                  style: GoogleFonts.poppins(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                  "${snapshot.data!.firstAirDate!.year}-${snapshot.data!.firstAirDate!.month}-${snapshot.data!.firstAirDate!.day}",
                                  style: GoogleFonts.poppins(fontSize: 15),
                                ),
                              ),
                              ListTile(
                                title: const Text("Last air date"),
                                subtitle: Text(
                                  "${snapshot.data!.lastAirDate!.year}-${snapshot.data!.lastAirDate!.month}-${snapshot.data!.lastAirDate!.day}",
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
                                      style: const TextStyle(color: Colors.black)),
                                  progressColor: Colors.green,
                                ),
                                title: const Text("User Ratings"),
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
