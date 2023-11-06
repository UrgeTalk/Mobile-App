
class EpisodeModel {
  int? id;
  String? title;
  String? description;
  String? cover;
  String? video;

  EpisodeModel({
    this.id,
    this.title,
    this.description,
    this.cover,
    this.video
});

  Map<String, dynamic> toMap(){
    return {
      "id": id,
      "video": video,
      "title": title,
      "description": description,
      "cover": cover,
    };
  }

  factory EpisodeModel.fromMap(Map<String, dynamic> map){
    return EpisodeModel(
        id: map['id'],
        video: map['video'],
        title: map['title'],
        description: map['description'],
        cover: map['cover'],
    );
  }


}