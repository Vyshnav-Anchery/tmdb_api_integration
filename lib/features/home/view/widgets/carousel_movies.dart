import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mock_machine_test/core/api_consts/api_links.dart';
import 'package:mock_machine_test/features/home/controller/home_screen_controller.dart';
import 'package:mock_machine_test/features/movie_details/view/show_details_screen.dart';
import 'package:provider/provider.dart';

class MovieCarousel extends StatelessWidget {
  const MovieCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: MediaQuery.sizeOf(context).height / 2,
      width: double.infinity,
      child: Consumer<TrendingShowsController>(
          builder: (context, provider, child) {
        return FutureBuilder(
            future: provider.requestAllTrending(),
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
                      height: MediaQuery.sizeOf(context).height / 3.5,
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
                                builder: (context) => ShowDetailsScreen(
                                    data: snapshot.data!.results![index]),
                              ));
                        },
                        child: Container(
                          width: MediaQuery.sizeOf(context).height / 2,
                          height: MediaQuery.sizeOf(context).height,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image: NetworkImage(
                                      "$imageLink${snapshot.data!.results![index].posterPath}"),
                                  fit: BoxFit.fill)),
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
