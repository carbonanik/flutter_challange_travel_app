import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_challange_travel_app/model/place.dart';
import 'package:flutter_challange_travel_app/screen/place_image_page_view.dart';
import 'package:flutter_challange_travel_app/widget/gradient_status_tag.dart';

class AnimatedDetailHeader extends StatelessWidget {
  const AnimatedDetailHeader({Key? key, required this.place, required this.topPercent, required this.bottomPercent}) : super(key: key);

  final TravelPlace place;
  final double topPercent;
  final double bottomPercent;

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    var imagesUrl = place.imagesUrl;
    return Stack(
      fit: StackFit.expand,
      children: [
        Hero(
          tag: place.id,
          child: Material(
            child: ClipRect(
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: (20 + topPadding) * (1 - bottomPercent),
                      bottom: 160 * (1 - bottomPercent),
                    ),
                    child: Transform.scale(
                      scale: lerpDouble(1, 1.3, bottomPercent),
                      child: PlaceImagePageView(imagesUrl: imagesUrl),
                    ),
                  ),
                  Positioned(
                      top: topPadding,
                      left: -60 * (1-bottomPercent),
                      child: BackButton(
                    color: Colors.white,
                  )),
                  Positioned(
                      top: topPadding,
                      right: -60 * (1-bottomPercent),
                      child: IconButton(
                    onPressed: (){},
                        icon: Icon(Icons.more_horiz),
                        color: Colors.white,
                  )),
                  Positioned(
                      top: lerpDouble(-30, 140, topPercent)?.clamp(topPadding + 10, 140),
                      left: lerpDouble(60, 20, topPercent)?.clamp(20, 50),
                      child: AnimatedOpacity(
                        duration: kThemeAnimationDuration,
                        opacity: bottomPercent < 1 ? 0: 1 ,
                        child: Opacity(
                          opacity: topPercent,
                          child: Text(place.name, style: TextStyle(
                    color: Colors.white,
                    fontSize: lerpDouble(20, 40, topPercent),
                    fontWeight: FontWeight.bold
                  ),),
                        ),
                      )),
                  Positioned(
                      left: 20,
                      top: 200,
                      child: AnimatedOpacity(
                          opacity: bottomPercent < 1 ? 0: 1 ,
                          duration: kThemeAnimationDuration,
                          child: Opacity(
                              opacity: topPercent,
                              child: GradientStatusTag(statusTag: place.statusTag))))

                ],
              ),
            ),
          ),
        ),
        Positioned.fill(
          top: null,
          bottom: -140 * (1- topPercent),
          child: TranslateAnimation(
            child: _LikesAndSharesContainer(
              place: place,
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            color: Colors.white,
            height: 10,
          ),
        ),
        Positioned.fill(
            top: null,
            // bottom: -140 * (1- topPercent),
            child: TranslateAnimation(child: _UserInfoContainer(place: place))),
      ],
    );
  }
}

class TranslateAnimation extends StatelessWidget {
  const TranslateAnimation({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
        tween: Tween(begin: 1, end: 0),
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOutBack,
        builder: (context, value, child){
          return Transform.translate(
            offset: Offset(0, 100 * value),
            child: child,
          );
        },
      child: child,
        );
  }
}


class _LikesAndSharesContainer extends StatelessWidget {
  const _LikesAndSharesContainer({Key? key, required this.place}) : super(key: key);
  final TravelPlace place;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      height: 140,
      decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: const BorderRadius.vertical(top: Radius.circular(30))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(CupertinoIcons.heart),
            style: TextButton.styleFrom(primary: Colors.black, shape: const StadiumBorder()),
            label: Text(place.likes.toString()),
          ),
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(CupertinoIcons.reply),
            style: TextButton.styleFrom(primary: Colors.black, shape: const StadiumBorder()),
            label: Text(place.shared.toString()),
          ),
          Spacer(),
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(
              Icons.check_circle_outline,
              size: 26,
            ),
            style: TextButton.styleFrom(
              backgroundColor: Colors.blue.shade100,
              primary: Colors.blue.shade600,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            ),
            label: Text('Checkin'),
          ),
        ],
      ),
    );
  }
}

class _UserInfoContainer extends StatelessWidget {
  const _UserInfoContainer({Key? key, required this.place}) : super(key: key);

  final TravelPlace place;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
              top: Radius.circular(30)
          )
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(place.user.urlPhoto),
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                place.user.name,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'yesterday at 9:10 am',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          const Spacer(),
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              backgroundColor: Colors.blue.shade100,
              primary: Colors.blue.shade600,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            ),
            child: Text('+ Follow'),
          ),
        ],
      ),
    );
  }
}

