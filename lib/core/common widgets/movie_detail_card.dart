import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mock_machine_test/features/home/model/top_movies_model.dart';

import '../../features/movie_details/view/movie_details_screen.dart';
import '../api_consts/api_links.dart';

class MovieDetailCard extends StatelessWidget {
  final TopMovieResult topMovie;
  const MovieDetailCard({super.key, required this.topMovie});

  @override
  Widget build(BuildContext context) {
    String rating = topMovie.voteAverage.toString();
    DateTime releaseDate = topMovie.releaseDate!;
    return Card(
      elevation: 3,
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    MovieDetailsScreen(id: topMovie.id!),
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
                "$imageLink${topMovie.posterPath!}",
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
                    topMovie.title!,
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
                    Text(topMovie.originalLanguage!)
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
