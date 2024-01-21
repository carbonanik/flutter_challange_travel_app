import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_challange_travel_app/model/place.dart';
import 'package:flutter_challange_travel_app/widget/gradient_status_tag.dart';

class PlaceCard extends StatelessWidget {

  final TravelPlace place;
  final VoidCallback onPressed;

  const PlaceCard({Key? key, required this.place, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            image: DecorationImage(
              image: AssetImage(place.imagesUrl.first),
              fit: BoxFit.fill,
              colorFilter: const ColorFilter.mode(Colors.black26, BlendMode.darken),
            )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(place.user.urlPhoto),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      place.user.name,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      'yesterday at 9:10 am',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.more_horiz,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Text(
              place.name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 32, color: Colors.white),
            ),
            const SizedBox(
              height: 10,
            ),

            /////////////////////////////////////////////
            GradientStatusTag(statusTag:place.statusTag,),
            const Spacer(),
            Row(
              children: [
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(CupertinoIcons.heart),
                  style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      shape: const StadiumBorder()
                  ),
                  label: Text(place.likes.toString()),
                ),
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(CupertinoIcons.reply),
                  style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      shape: const StadiumBorder()
                  ),
                  label: Text(place.shared.toString()),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
