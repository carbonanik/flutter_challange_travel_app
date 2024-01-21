import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_challange_travel_app/data/place.dart';
import 'package:flutter_challange_travel_app/model/place.dart';

import 'animated_detail_header.dart';

class PlaceDetailScreen extends StatefulWidget {
  const PlaceDetailScreen({Key? key, required this.place, required this.screenHeight}) : super(key: key);

  final TravelPlace place;
  final double screenHeight;

  @override
  State<PlaceDetailScreen> createState() => _PlaceDetailScreenState();
}

class _PlaceDetailScreenState extends State<PlaceDetailScreen> {
  late ScrollController _controller;
  late ValueNotifier<double> bottomPercentNotifier;
  bool isAnimationScroll = false;

  void _scrollListener() {
    var percent = _controller.position.pixels / MediaQuery.of(context).size.height;
    bottomPercentNotifier.value = (percent / .3).clamp(0.0, 1.0);
  }

  void _isScrollingListener() {
    var percent = _controller.position.pixels / widget.screenHeight;

    if (_controller.position.userScrollDirection == ScrollDirection.forward) {
      print('forword');
      if (percent < .6 && percent > .3) {
        _controller.animateTo(
          widget.screenHeight * .3,
          duration: kThemeAnimationDuration,
          curve: Curves.decelerate,
        );
      }

      if (percent < .3 && percent > 0) {
        _controller.animateTo(
          0,
          duration: kThemeAnimationDuration,
          curve: Curves.decelerate,
        );
      }
    }

    if (_controller.position.userScrollDirection == ScrollDirection.reverse) {
      if (percent < .3 && percent > 0) {
        _controller.animateTo(
          widget.screenHeight * .3,
          duration: kThemeAnimationDuration,
          curve: Curves.decelerate,
        );
      }

      if (percent < .6 && percent > .3) {
        _controller.animateTo(
          widget.screenHeight * .7,
          duration: kThemeAnimationDuration,
          curve: Curves.decelerate,
        );
      }
    }
  }

  @override
  void initState() {
    _controller = ScrollController(initialScrollOffset: widget.screenHeight * .3);
    bottomPercentNotifier = ValueNotifier(1.0);
    _controller.addListener(_scrollListener);
    WidgetsBinding.instance.addPostFrameCallback((timestamp) {
      _controller.position.addListener(_isScrollingListener);
      // _controller.position.isScrollingNotifier.addListener(_isScrollingListener);
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.removeListener(_scrollListener);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            controller: _controller,
            slivers: [
              SliverPersistentHeader(
                pinned: true,
                delegate: BuilderPersistentDelegate(
                    maxExtent: MediaQuery.of(context).size.height,
                    minExtent: 240,
                    builder: (percent) {
                      final bottomPercent = (percent / .3).clamp(0.0, 1.0);
                      return AnimatedDetailHeader(
                        topPercent: ((1 - percent) / .7).clamp(0.0, 1.0),
                        bottomPercent: bottomPercent,
                        place: widget.place,
                      );
                    }),
              ),
              SliverToBoxAdapter(
                child: TranslateAnimation(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              color: Colors.black26,
                            ),
                            Flexible(
                              child: Text(
                                widget.place.locationDesc,
                                style: const TextStyle(color: Colors.blue),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(widget.place.description),
                        const SizedBox(height: 10),
                        const Text(
                          'PLACE IN THIS COLLECTIONS',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 180,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemExtent: 150,
                    itemCount: places.length,
                    itemBuilder: (context, index) {
                      final place = places[index];
                      return Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              place.imagesUrl.first,
                              fit: BoxFit.cover,
                            )),
                      );
                    },
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 150,
                ),
              )
            ],
          ),
          ValueListenableBuilder<double>(
            valueListenable: bottomPercentNotifier,
            builder: (context, value, child) {
              return Positioned.fill(top: null, bottom: -130 * (1 - value), child: child!);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              height: 130,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white.withOpacity(0),
                    Colors.white70,
                  ],
                ),
              ),
              child: Row(
                children: [
                  Container(
                    height: 60,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(color: Colors.indigo.shade700, borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      children: [
                        for (var i = 0; i < 3; i++)
                          Align(
                            widthFactor: .7,
                            child: CircleAvatar(
                              radius: 15,
                              backgroundColor: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: CircleAvatar(
                                  backgroundImage: AssetImage(users[i].urlPhoto),
                                ),
                              ),
                            ),
                          ),
                        const SizedBox(width: 10),
                        const Text(
                          'Comments',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        const Text(
                          '120',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 10),
                        const Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                  const Spacer(),
                  Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(color: Colors.blueGrey.shade50, borderRadius: BorderRadius.circular(20)),
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                      child: const Icon(
                        Icons.location_on,
                        color: Colors.blue,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BuilderPersistentDelegate extends SliverPersistentHeaderDelegate {
  final double _maxExtent;
  final double _minExtent;
  final Widget Function(double percent) builder;

  BuilderPersistentDelegate({
    required double maxExtent,
    required double minExtent,
    required this.builder,
  })  : _maxExtent = maxExtent,
        _minExtent = minExtent;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return builder(shrinkOffset / _maxExtent);
  }

  @override
  double get maxExtent => _maxExtent;

  @override
  double get minExtent => _minExtent;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
