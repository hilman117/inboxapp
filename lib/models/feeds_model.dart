class FeedsModel {
  FeedsModel(
      {this.name,
      this.position,
      this.imagePostSender,
      this.emailPostSender,
      this.postStuff,
      this.thisPostCeatedAt,
      this.comment,
      this.images,
      this.like});

  String? imagePostSender;
  String? emailPostSender;
  String? name;
  String? position;
  String? postStuff;
  DateTime? thisPostCeatedAt;
  List<dynamic>? comment;
  List<dynamic>? images;
  List<dynamic>? like;

  factory FeedsModel.fromJson(Map<String, dynamic> json) => FeedsModel(
        name: json['name'],
        position: json['position'],
        postStuff: json['postStuff'],
        emailPostSender: json['emailPostSender'],
        imagePostSender: json['imagePostSender'],
        thisPostCeatedAt: DateTime.parse(json["thisPostCeatedAt"]),
        comment: List<dynamic>.from(json["comment"].map((x) => x)),
        images: List<dynamic>.from(json["images"].map((x) => x)),
        like: List<dynamic>.from(json["like"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "position": position,
        "postStuff": postStuff,
        "emailPostSender": emailPostSender,
        "thisPostCeatedAt": thisPostCeatedAt!.toIso8601String(),
        "comment":
            comment == null ? null : List<dynamic>.from(comment!.map((x) => x)),
        "images":
            images == null ? null : List<dynamic>.from(images!.map((x) => x)),
        "like": like == null ? null : List<dynamic>.from(like!.map((x) => x)),
      };
}
