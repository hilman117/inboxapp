class LfModel {
  LfModel({
    this.image,
    this.imageProof,
    this.statusReleased,
    this.receiveBy,
    this.receiver,
    this.description,
    this.nameItem,
    this.location,
    this.id,
    // this.time,
    this.reportreceiveDate,
    this.reportClaimedDate,
    this.reportReleasedDate,
    this.status,
    this.emailSender,
    this.founder,
  });

  String? image;
  String? imageProof;
  String? statusReleased;
  String? receiveBy;
  String? receiver;
  String? description;
  String? nameItem;
  String? founder;
  String? emailSender;
  String? location;
  String? id;
  // DateTime? time;
  String? reportreceiveDate;
  String? reportClaimedDate;
  String? reportReleasedDate;
  String? status;

  factory LfModel.fromJson(Map<String, dynamic> json) => LfModel(
      image: json["image"],
      imageProof: json["imageProof"],
      statusReleased: json["statusReleased"],
      receiveBy: json["receiveBy"],
      receiver: json["receiver"],
      description: json["description"],
      emailSender: json["emailSender"],
      location: json["location"],
      id: json["id"],
      // time: DateTime.parse(json["time"]),
      reportreceiveDate: json["reportreceiveDate"],
      reportClaimedDate: json["reportClaimedDate"],
      reportReleasedDate: json["reportReleasedDate"],
      status: json["status"],
      founder: json['founder'],
      nameItem: json['nameItem']);

  Map<String, dynamic> toJson() => {
        "image": image,
        "imageProof": imageProof,
        "statusReleased": statusReleased,
        "receiveBy": receiveBy,
        "receiver": receiver,
        "emailSender": emailSender,
        "description": description,
        "location": location,
        "id": id,
        // "time": time!.toIso8601String(),
        "reportreceiveDate": reportreceiveDate,
        "reportClaimedDate": reportClaimedDate,
        "reportReleasedDate": reportReleasedDate,
        "status": status,
        "founder": founder,
        "nameItem": nameItem,
      };
}
