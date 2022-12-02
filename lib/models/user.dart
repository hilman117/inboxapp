class UserDetails {
  String? email;
  String? name;
  String? position;
  String? hotel;
  String? location;
  String? profileImage;
  String? department;
  String? uid;
  int? acceptRequest;
  int? closeRequest;
  int? createRequest;
  bool? notifyWhenAccepted;
  bool? receiveNotifWhenClose;
  String? hotelid;
  bool? isOnDuty;

  UserDetails(
      {this.email,
      this.uid,
      this.acceptRequest,
      this.closeRequest,
      this.createRequest,
      this.hotelid,
      this.name,
      this.position,
      this.hotel,
      this.location,
      this.profileImage,
      this.department,
      this.notifyWhenAccepted,
      this.receiveNotifWhenClose, this.isOnDuty});

  factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
        email: json['email'],
        name: json['name'],
        hotelid: json['hotelid'],
        uid: json['uid'],
        acceptRequest: json['acceptRequest'],
        closeRequest: json['closeRequest'],
        createRequest: json['createRequest'],
        position: json['position'],
        hotel: json['hotel'],
        location: json['location'],
        profileImage: json['profileImage'],
        department: json['department'],
        notifyWhenAccepted: json['ReceiveNotifWhenAccepted'],
        receiveNotifWhenClose: json['ReceiveNotifWhenClose'],
        isOnDuty: json['isOnDuty'],
      );

  Map<String, dynamic> toJson() => {
        'email': email,
        'name': name,
        'hotelid': hotelid,
        'uid': uid,
        'acceptRequest': acceptRequest,
        'closeRequest': closeRequest,
        'createRequest': createRequest,
        'position': position,
        'hotel': hotel,
        'location': location,
        'profileImage': profileImage,
        'department': department,
        'ReceiveNotifWhenAccepted': notifyWhenAccepted,
        'ReceiveNotifWhenClose': receiveNotifWhenClose,
        'isOnDuty': isOnDuty,
      };
}
