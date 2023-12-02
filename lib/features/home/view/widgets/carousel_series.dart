import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mock_machine_test/core/api_consts/api_links.dart';
import 'package:mock_machine_test/features/home/controller/home_screen_controller.dart';
import 'package:provider/provider.dart';

import '../../../series_details/view/show_details_screen.dart';

class SeriesCarousel extends StatelessWidget {
  const SeriesCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: MediaQuery.sizeOf(context).height / 2,
      width: double.infinity,
      child:
          Consumer<HomeScreenController>(builder: (context, provider, child) {
        return FutureBuilder(
            future: provider.requestTrendingSeries(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (!snapshot.hasData || snapshot.data == null) {
                return const Text("Error geting data..!");
              } else {
                return CarouselSlider.builder(
                  itemCount: 10,
                  options: CarouselOptions(
                      autoPlayCurve: Curves.fastOutSlowIn,
                      autoPlayAnimationDuration: const Duration(seconds: 2),
                      autoPlay: true,
                      aspectRatio: 16 / 9,
                      enlargeCenterPage: true),
                  itemBuilder: (context, index, realIndex) {
                    return Card(
                      elevation: 5,
                      shadowColor: Colors.black,
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
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            imageUrl:
                                "$imageLinkOriginal${snapshot.data!.results![index].backdropPath}",
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
                    // return SizedBox(
                    //   child: Image.network(
                    //       width: MediaQuery.sizeOf(context).width,
                    //       fit: BoxFit.fill,
                    //       "$imageLink${snapshot.data!.results![index].posterPath}"),
                    // );
                  },
                );
              }
            });
      }),
    );
  }
}
