import 'dart:convert';

class ApplicationStatus {
  String? message;
  Data? data;

  ApplicationStatus({
    this.message,
    this.data
});

  Map<String, dynamic> toMap(){
    return {
      "message": message,
      "data": data!.toMap(),
    };
  }
  factory ApplicationStatus.fromMap(Map<String, dynamic> map){
    return ApplicationStatus(
      message: map['message'],
      data: Data.fromMap(map['data']),
    );
  }


}

class Data {
  int? id;
  String? approved;

  Data({
    this.id,
    this.approved
});
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "approved": approved
    };
  }

  factory Data.fromMap(Map<String, dynamic> map){
    return Data(
      id: map['id'],
      approved: map['approved'] ?? ""
    );
  }
}