import 'package:flutter/material.dart';
import 'package:mock_machine_test/core/api_consts/api_links.dart';
import 'package:provider/provider.dart';
import '../../../movie_details/view/show_details_screen.dart';
import '../../controller/home_screen_controller.dart';

class TopSeriesListview extends StatelessWidget {
  const TopSeriesListview({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TrendingShowsController>(
        builder: (context, provider, child) {
      return FutureBuilder(
          future: provider.requestTopSeries(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (!snapshot.hasData || snapshot.data == null) {
              return const Text("Error getting data");
            } else {
              return SizedBox(
                width: MediaQuery.sizeOf(context).width,
                height: MediaQuery.sizeOf(context).height / 4,
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
                                builder: (context) => ShowDetailsScreen(
                                    data: snapshot.data!.results![index]),
                              ));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image: NetworkImage(
                                      "$imageLink${snapshot.data!.results![index].posterPath!}"),
                                  fit: BoxFit.cover)),
                          // height: MediaQuery.sizeOf(context).height / 2,
                          width: MediaQuery.sizeOf(context).height / 5.5,
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
