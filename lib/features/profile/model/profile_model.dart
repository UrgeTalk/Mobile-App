import 'dart:convert';

class ProfileModel {
  int? id;
  String? firstName;
  String? lastName;
  String? emailAddress;
  bool? isMember;
  bool? isSpeaker;
  String? profilePicture;

  ProfileModel({
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
      "profile_picture": profilePicture,
    };
  }

  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
        id: map['id'],
        firstName: map['first_name'],
        lastName: map['last_name'],
        emailAddress: map['email'],
        isMember: map['is_member'],
        isSpeaker: map['is_speaker'],
        profilePicture: map['profile_picture']);
  }
  String get fullName => "$firstName $lastName";

  String toJson() => json.encode(toMap());
  factory ProfileModel.fromJson(String source) =>
      ProfileModel.fromMap(json.decode(source));

        @override
  String toString() {
    return 'ProfileModel(id: $id,first_name: $firstName, last_name: $lastName, email: $emailAddress)';
  }

}
