import 'dart:convert';

class MasterClassModel {
  int? id;
  List<Tag>? tags;
  Speaker? speaker;
  int? likesCount;
  bool? liked;
  bool? saved;
  String? title;
  String? description;
  String? type;
  String? video;
  int? viewsCount;
  String? coverImage;
  String? date;

  MasterClassModel({
    this.id,
    this.tags,
    this.speaker,
    this.likesCount,
    this.liked,
    this.saved,
    this.title,
    this.description,
    this.type,
    this.video,
    this.viewsCount,
    this.coverImage,
    this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "tags": tags!.map((tag) => tag.toMap()).toList(),
      "speaker": speaker!.toMap(),
      "likes_count": likesCount,
      "liked": liked,
      "saved": saved,
      "title": title,
      "description": description,
      "type": type,
      "video": video,
      "viewsCount": viewsCount,
      "coverImage": coverImage,
      "date": date,
    };
  }

  factory MasterClassModel.fromMap(Map<String, dynamic> map) {
    return MasterClassModel(
        id: map['id'],
        tags: List<Tag>.from(map['tags']?.map((x) => Tag.fromMap(x))),
        speaker: Speaker.fromMap(map['speaker']),
        likesCount: map['likes_count'],
        liked: map['liked'],
        saved: map['saved'],
        title: map['title'],
        description: map['description'],
        type: map['type'],
        video: map['video'],
        viewsCount: map['viewsCount'],
        coverImage: map['coverImage'],
        date: map['date']);
  }

  String toJson() => json.encode(toMap());
  factory MasterClassModel.fromJson(String source) =>
      MasterClassModel.fromJson(json.decode(source));
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
  //   String toJson() => json.encode(toMap());
  // factory Tag.fromJson(String source) =>
  //     Tag.fromJson(json.decode(source));

}

class Speaker {
  int? id;
  String? firstName;
  String? lastName;
  String? emailAddress;
  bool? isMember;
  bool? isSpeaker;
  String? profilePicture;

  Speaker({
    this.id,
    this.firstName,
    this.lastName,
    this.emailAddress,
    this.isMember,
    this.isSpeaker,
    this.profilePicture,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "first_name": firstName,
      "last_name": lastName,
      "email": emailAddress,
      "is_member": isMember,
      "is_speaker": isSpeaker,
      "profile_picture": profilePicture
    };
  }

  factory Speaker.fromMap(Map<String, dynamic> map) {
    return Speaker(
        id: map['id'],
        firstName: map['first_name'],
        lastName: map['last_name'],
        emailAddress: map['email'],
        isMember: map['is_member'],
        isSpeaker: map['is_speaker'],
        profilePicture: map['profile_picture']);
  }
    String get fullName => "$firstName $lastName";

  //   String toJson() => json.encode(toMap());
  // factory Speaker.fromJson(String source) =>
  //     Speaker.fromJson(json.decode(source));

}
