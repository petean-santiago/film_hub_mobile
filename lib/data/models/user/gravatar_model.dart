class GravatarModel {
  final String hash;

  GravatarModel({required this.hash});

  factory GravatarModel.fromJson(Map<String, dynamic> json) {
    return GravatarModel(hash: json["hash"] ?? "");
  }

  String get gravatarUrl => "https://www.gravatar.com/avatar/$hash";
}
