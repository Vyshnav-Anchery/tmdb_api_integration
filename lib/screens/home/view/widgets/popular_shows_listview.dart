import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mock_machine_test/core/api_consts/api_links.dart';
import 'package:mock_machine_test/screens/series_details/view/show_details_screen.dart';
import 'package:provider/provider.dart';

import '../../controller/home_screen_controller.dart';

class PopularShowsListview extends StatelessWidget {
  const PopularShowsListview({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeScreenController>(builder: (context, provider, child) {
      return FutureBuilder(
          future: provider.requestPopularShows(),
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
                    return Card(
                      elevation: 3,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SeriesDetailsScreen(
                                    id: snapshot.data!.results![index].id!),
                              ));
                        },
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            topRight: Radius.circular(10.0),
                          ),
                          child: CachedNetworkImage(
                            imageUrl:
                                "$imageLink${snapshot.data!.results![index].posterPath!}",
                            fit: BoxFit.fill,
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) => Center(
                              child: CircularProgressIndicator(
                                  value: downloadProgress.progress),
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
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
