class UserModel {
  String? id;
  String? email;
  String? name;
  String? phone;
  String? imagePath;

  UserModel({this.id, this.email, this.name, this.phone, this.imagePath});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id']?.toString(),
      email: json['email'],
      name: json['name'],
      phone: json['phone'],
      imagePath: json['image_path'] ?? json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'phone': phone,
      'image_path': imagePath,
    };
  }
}
