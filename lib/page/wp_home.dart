import 'package:api_hand_made_no_frommap/model/wallpaper_model.dart';
import 'package:api_hand_made_no_frommap/service/wp_serv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

class WallpaperPage extends StatefulWidget {
  const WallpaperPage({super.key});

  @override
  State<WallpaperPage> createState() => _WallpaperPageState();
}

class _WallpaperPageState extends State<WallpaperPage> {
  List<Tab> categories = [
    Tab(
      text: "SUN RISE",
    ),Tab(
      text: "BIKES",
    ),Tab(
      text: "MOUNTAINS",
    ),Tab(
      text: "ISLAND",
    ),Tab(
      text: "SNOW",
    ),Tab(
      text: "LIONS",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: categories.length,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text(
            "Wallpics",
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Colors.black,
          bottom: TabBar(
            tabs: categories,
            indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.yellow
            ),
            unselectedLabelColor: Colors.white,
            isScrollable: true,
            indicatorWeight: 0,
            dividerColor: Colors.white,
            indicatorSize: TabBarIndicatorSize.tab,
            labelColor: Colors.black,
          ),
        ),
        body: TabBarView(
            children: categories.map((tab) => customGridView(tab)).toList()
        ),
      ),
    );
  }

  FutureBuilder<List<WallpaperModel>> customGridView(Tab tab) {
    return FutureBuilder<List<WallpaperModel>>(
      future: WallpaperService().fetchWallpaperData(tab.text!.toLowerCase()),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (!snapshot.hasData || snapshot.data == null) {
          return Center(child: Text("No data found"));
        } else {
          return MasonryGridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final photo = snapshot.data![index];
              return GestureDetector(
                onTap: () {
                  // Get.to(() => ImageDetailPage(imageUrl: photo.imgURL,alt: photo.alt,));
                  Get.toNamed( "/details", arguments: photo);
                },
                child: Hero(
                  tag: photo.imgURL,
                  child: Container(
                    height: (index % 3 + 2) * 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Color(
                        int.parse(photo.avaColor.replaceAll("#", "0xff")),
                      ),
                      image: DecorationImage(
                        image: NetworkImage(photo.imgURL),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}

