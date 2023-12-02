import 'package:flutter/material.dart';
import 'package:mock_machine_test/core/common%20widgets/movie_detail_card.dart';
import 'package:mock_machine_test/features/home/controller/home_screen_controller.dart';
import 'package:provider/provider.dart';

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
                body: SizedBox(
                  height: MediaQuery.sizeOf(context).height,
                  child: ListView.builder(
                    itemCount: snapshot.data!.results!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return MovieDetailCard(
                          topMovie: snapshot.data!.results![index]);
                    },
                  ),
                ),
                persistentFooterAlignment: AlignmentDirectional.bottomCenter,
                persistentFooterButtons: [
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                            // color: Colors.white,
                            onPressed: () {
                              provider.prevPage();
                            },
                            icon: const Icon(Icons.skip_previous)),
                        SizedBox(
                          height: 50,
                          width: MediaQuery.sizeOf(context).width / 2,
                          child: ListView.builder(
                            controller: provider.scrollToCurrentPage(
                                snapshot.data!.page!, 50),
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data!.totalPages,
                            itemBuilder: (BuildContext context, int index) {
                              // Add 1 to index because page numbers usually start from 1
                              int pageNumber = index + 1;
                              return SizedBox(
                                width: 50,
                                child: InkWell(
                                  onTap: () {
                                    provider.changePage(pageNumber);
                                  },
                                  child: Card(
                                    color: snapshot.data!.page == pageNumber
                                        ? Colors.green
                                        : null,
                                    child: Center(
                                        child: Text(pageNumber.toString())),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        IconButton(
                            // color: Colors.white,
                            onPressed: () {
                              provider.nextPage(snapshot.data!.totalPages);
                            },
                            icon: const Icon(Icons.skip_next)),
                      ],
                    ),
                  ),
                ],
              );
            }
          });
    });
  }
}
