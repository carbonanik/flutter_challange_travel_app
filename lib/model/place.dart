import 'dart:core';

class TravelPlace {
  final int id;
  final int likes;
  final int shared;
  final String name;
  final String description;
  final List<String> imagesUrl;
  final StatusTag statusTag;
  final TravelUser user;
  final String locationDesc;

  TravelPlace({
    required this.id,
    required this.likes,
    required this.shared,
    required this.name,
    required this.description,
    required this.imagesUrl,
    required this.statusTag,
    required this.user,
    required this.locationDesc,
  });
}

enum StatusTag {
  popular,
  event
}

extension ParseToString on StatusTag {
  String toShortString() {
    return (this == StatusTag.popular) ? 'Popular Place' : 'Event' ;
  }
}


class TravelUser {
  final String name;
  final String urlPhoto;

  TravelUser({
    required this.name,
    required this.urlPhoto,
  });
}
