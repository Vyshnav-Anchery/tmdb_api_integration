import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mock_machine_test/screens/series_details/view/show_details_screen.dart';

import '../../screens/home/model/top_series_model.dart';
import '../api_consts/api_links.dart';

class SeriesDetailCard extends StatelessWidget {
  final topSeries;
  const SeriesDetailCard({super.key, required this.topSeries});

  @override
  Widget build(BuildContext context) {
    String rating = topSeries.voteAverage.toString();
    DateTime releaseDate = topSeries.firstAirDate ?? topSeries.firstAirDate;
    late String originalLang;
    if (topSeries.originalLanguage == "en") {
      originalLang = "English";
    } else if (topSeries.originalLanguage == "es") {
      originalLang = "Spanish";
    } else if (topSeries.originalLanguage == "ja") {
      originalLang = "Japanese";
    } else {
      originalLang = "Korean";
    }
    return Card(
      elevation: 3,
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SeriesDetailsScreen(id: topSeries.id!),
              ));
        },
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10.0),
                bottomLeft: Radius.circular(10.0),
              ),
              child: CachedNetworkImage(
                imageUrl: "$imageLinkOriginal${topSeries.posterPath!}",
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
                    topSeries.name!,
                    softWrap: true,
                    maxLines: 2,
                    style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Text("Language : "),
                    // const SizedBox(width: 20),
                    Text(originalLang)
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Text("Rating : "),
                    // const SizedBox(width: 20),
                    Text(rating.substring(0, rating.length - 2).toString())
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Text("Release Year : "),
                    const SizedBox(width: 10),
                    Text(releaseDate.year.toString())
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
