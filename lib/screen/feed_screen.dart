import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_challange_travel_app/data/place.dart';
import 'package:flutter_challange_travel_app/screen/place_detail_screen.dart';
import 'package:flutter_challange_travel_app/widget/bottom_navigation_bar.dart';
import 'package:flutter_challange_travel_app/widget/place_card.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('Feed', style: TextStyle(color: Colors.black),),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(CupertinoIcons.search, color: Colors.black,),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(CupertinoIcons.star, color: Colors.black,),
          )
        ],
      ),
      body: ListView.builder(
          itemCount: places.length,
          itemExtent: 350,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(0, 0, 0, kToolbarHeight + 20),
          itemBuilder: (context, index) {
            final place = places[index];
            return Hero(
              tag: place.id,
              child: Material(
                child: PlaceCard(
                  place: place,
                  onPressed: () async {
                    Navigator.push(context, PageRouteBuilder(pageBuilder: (_, animation, __) {
                      return FadeTransition(
                        opacity: animation,
                        child: PlaceDetailScreen(
                          place: place,
                          screenHeight: MediaQuery.of(context).size.height,
                        ),
                      );
                    }));
                  },
                ),
              ),
            );
          }),
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.location_on),
      ),
      bottomNavigationBar: TravelNavigationBar(
        onTap: (index) {},
        items: const [
          TravelNavigationBarItem(icon: CupertinoIcons.chat_bubble, selectedIcon: CupertinoIcons.chat_bubble_fill),
          TravelNavigationBarItem(icon: CupertinoIcons.square_split_2x2, selectedIcon: CupertinoIcons.square_split_2x2_fill),
        ],
        currentIndex: 1,
      ),
    );
  }
}
