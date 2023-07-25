import 'dart:convert';

class SavedItemsModel {
   final List<SavedEvents> events;
  final List<SavedVideos> videos;

  SavedItemsModel({required this.events, required this.videos});

  factory SavedItemsModel.fromMap(Map<String, dynamic> map) {
    return SavedItemsModel(
      events: List<SavedEvents>.from(map['events'].map((x) => SavedEvents.fromMap(x))).toList(),
      videos: List<SavedVideos>.from(map['videos'].map((x) => SavedVideos.fromMap(x))).toList(),
    );
  }

}

class Tag {
  String? name;

  Tag({this.name});

  Map<String, dynamic> toMap() {
    return {"name": name};
  }

  factory Tag.fromMap(Map<String, dynamic> map) {
    return Tag(name: map['name']);
  }
}

class SavedEvents {
  int? id;
  String? name;
  String? date;
  String? time;
  String? location;
  String? type;
  String? description;
  String? coverImage;
  int? amount;
  List<Tag>? tags;

  SavedEvents(
      {this.id,
      this.name,
      this.date,
      this.time,
      this.location,
      this.type,
      this.description,
      this.coverImage,
      this.amount,
      this.tags});

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "date": date,
      "time": time,
      "location": location,
      "type": type,
      "description": description,
      "cover": coverImage,
      "tags": tags!.map((tag) => tag.toMap()).toList(),
    };
  }

  factory SavedEvents.fromMap(Map<String, dynamic> map) {
    return SavedEvents(
      id: map['id'],
      tags: List<Tag>.from(map['tags']?.map((x) => Tag.fromMap(x))),
      name: map['name'],
      date: map['date'],
      time: map['time'],
      location: map['location'],
      type: map['type'],
      description: map['description'],
      coverImage: map['cover'],
    );
  }
}

class SavedVideos {
  int? id;
  String? name;
  String? date;
  String? time;
  String? location;
  String? type;
  String? description;
  String? coverImage;
  int? amount;
  List<Tag>? tags;

  SavedVideos(
      {this.id,
      this.name,
      this.date,
      this.time,
      this.location,
      this.type,
      this.description,
      this.coverImage,
      this.amount,
      this.tags});

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "date": date,
      "time": time,
      "location": location,
      "type": type,
      "description": description,
      "cover": coverImage,
      "tags": tags!.map((tag) => tag.toMap()).toList(),
    };
  }

  factory SavedVideos.fromMap(Map<String, dynamic> map) {
    return SavedVideos(
      id: map['id'],
      tags: List<Tag>.from(map['tags']?.map((x) => Tag.fromMap(x))),
      name: map['name'],
      date: map['date'],
      time: map['time'],
      location: map['location'],
      type: map['type'],
      description: map['description'],
      coverImage: map['cover'],
    );
  }
}
