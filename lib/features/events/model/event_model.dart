import 'dart:convert';

class Event {
  int? id;
  // Tag? tags;
  String? name;
  String? date;
  String? time;
  String? location;
  String? type;
  int? amount;
  String? description;
  String? cover;
  List<Tag>? tags;

  Event({
    this.id,
    this.name,
    this.date,
    this.time,
    this.location,
    this.type,
    this.amount,
    this.description,
    this.cover,
    this.tags,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "description": description,
      "date": date,
      "time": time,
      "location": location,
      "amount": amount,
      "type": type,
      "cover": cover,
      //"tags": tags!.map((tag) => tag.toMap()).toList(),
      "tags": List<dynamic>.from(tags!.map((x) => x.toMap())),
    };
  }

  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      id: map['id'],
      name: map['name'],
      date: map['date'],
      time: map['time'],
      location: map['location'],
      amount: map['amount'],
      type: map['type'],
      description: map['description'],
      cover: map['cover'],
      //tags: List<Tag>.from(map['tags']?.map((tag) => Tag.fromMap(tag))),
      tags: List<Tag>.from(map['tags'].map((x) => Tag.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Event.fromJson(String source) => Event.fromMap(json.decode(source));
}

class Tag {
  final String name;

  Tag({
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return {"name": name};
  }

  factory Tag.fromMap(Map<String, dynamic> map) {
    return Tag(
      name: map['name'],
    );
  }
}
