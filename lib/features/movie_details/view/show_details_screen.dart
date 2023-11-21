import 'package:flutter/material.dart';
import 'package:mock_machine_test/core/api_consts/api_links.dart';
import 'package:mock_machine_test/core/constants/theme_constants.dart';

class ShowDetailsScreen extends StatelessWidget {
  var data;
  ShowDetailsScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: MediaQuery.sizeOf(context).height / 3,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network("$imageLink${data.posterPath}",
                  fit: BoxFit.fill),
            ),
            bottom: const PreferredSize(
                preferredSize: Size.fromHeight(30),
                child: CircleAvatar(
                    radius: 35,
                    child: Icon(
                      Icons.play_arrow,
                      size: 50,
                    ))),
          ),
          SliverToBoxAdapter(
              child: Column(
            children: [
              const SizedBox(height: 30),
              Text(data.title!, style: ThemeConstants.homeSubCategories),
              const SizedBox(height: 30),
              Text(data.overview)
            ],
          )),
        ],
      ),
    );
  }
}
