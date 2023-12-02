import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mock_machine_test/core/common%20widgets/series_detail_card.dart';
import 'package:provider/provider.dart';

import '../controller/home_screen_controller.dart';
import '../model/top_series_model.dart';

class TopRatedSeriesScreen extends StatelessWidget {
  const TopRatedSeriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeScreenController>(builder: (context, provider, child) {
      return FutureBuilder<TopRatedSeriesModel?>(
          future: provider.requestTopSeries(),
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
                  title: const Text("Top Rated Series"),
                ),
                body: SizedBox(
                  height: MediaQuery.sizeOf(context).height,
                  child: ListView.builder(
                    itemCount: snapshot.data!.results!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return SeriesDetailCard(
                          topSeries: snapshot.data!.results![index]);
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
                              provider.prevSeriesPage();
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
                              int pageNumber = index + 1;
                              log(snapshot.data!.totalPages.toString());
                              return SizedBox(
                                width: 50,
                                child: InkWell(
                                  onTap: () {
                                    provider.changeSeriesPage(pageNumber);
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
                              provider
                                  .nextSeriesPage(snapshot.data!.totalPages);
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
