class ProfileModel {
  final String uid;
  final String name;
  final String email;
  final String image;

  ProfileModel({required this.uid, required this.name, required this.email, required this.image});

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      uid: json['uid'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      image: json['image'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'image': image,
    };
  }
}
