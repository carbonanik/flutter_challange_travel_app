import 'dart:math';

import 'package:mock_data/mock_data.dart';

import '../lorem_ipsum/lorem_ipsum.dart';
import '../model/place.dart';

List<String> images = List.generate(25, (index) {
  String imgNum = (index + 1).toString();
  if (index < 10 - 1) {
    imgNum = '0${index + 1}';
  }
  return 'assets/images/image_$imgNum.jpg';
});

List<TravelUser> users = List.generate(
    5,
    (index) => TravelUser(
          name: mockName(),
          urlPhoto: images[index+1],
        ));

final _random = Random();
final places = List<TravelPlace>.generate(
    20,
    (index) => TravelPlace(
          id: index + 1,
          likes: _random.nextInt(1000),
          shared: _random.nextInt(100),
          name: '${mockName()} ${mockName()}',
          description: loremIpsum(words: 1000, paragraphs: 10),
          imagesUrl: List.generate(3, (index2) => images[index]),
          statusTag: index.isEven ? StatusTag.event : StatusTag.popular,
          user: users[_random.nextInt(users.length)],
          locationDesc: loremIpsum(words: 3),
        ));
