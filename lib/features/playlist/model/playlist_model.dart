
class PlaylistModel {
  int? id;
  int? episodeCount;
  String? title;
  String? description;
  String? cover;
  String? speaker;
  String? video;

  PlaylistModel({
    this.id,
    this.episodeCount,
    this.title,
    this.description,
    this.cover,
    this.speaker,
    this.video,
});

  Map<String, dynamic> toMap(){
    return {
      "id": id,
      "episode_count": episodeCount,
      "title": title,
      "description": description,
      "cover": cover,
      "speaker": speaker,
      "video": video,
    };
  }

  factory PlaylistModel.fromMap(Map<String, dynamic> map){
    return PlaylistModel(
      id: map['id'],
      episodeCount: map['episode_count'],
      title: map['title'],
      description: map['description'],
      cover: map['cover'],
      speaker: map['speaker'],
      video: map['video']
    );
  }
}