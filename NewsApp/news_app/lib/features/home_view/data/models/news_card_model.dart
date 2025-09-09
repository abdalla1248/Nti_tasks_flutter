class NewsCardModel {
  String? imagePath;
  String? title;
  String? subTitle;

  NewsCardModel({
    required this.imagePath,
    required this.title,
    required this.subTitle,
  });

  NewsCardModel.fromJson(Map<String, dynamic> json) {
    imagePath = json["imagePath"];
    title = json["title"];
    subTitle = json["subTitle"];
  }

  Map<String, dynamic> toJson() {
    return {"imagePath": imagePath, "title": title, "subTitle": subTitle};
  }
}
