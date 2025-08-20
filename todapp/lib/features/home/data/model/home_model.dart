class HomeModel {
  final String welcomeMessage;
  final String userId;

  HomeModel({required this.welcomeMessage, required this.userId});

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return HomeModel(
      welcomeMessage: json['welcomeMessage'] ?? '',
      userId: json['userId'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'welcomeMessage': welcomeMessage,
      'userId': userId,
    };
  }
}
