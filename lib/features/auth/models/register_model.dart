class RegistrationModel {
  String? firstName;
  String? lastName;
  String? password;
  String? emailAddress;

  RegistrationModel(
      {this.firstName, this.lastName, this.password, this.emailAddress});

  RegistrationModel.fromJson(Map<String, dynamic> json) {
    emailAddress = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['email'] = emailAddress;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['password'] = password;

    return data;
  }
}
