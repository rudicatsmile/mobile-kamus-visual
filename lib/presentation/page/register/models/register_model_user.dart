
class RegisterModelUser {
  String userId;
  String password;
  String nama;
  String admType;
  String idApotek;
  String telpon;
  String whatsapp;
  String kdPro;
  String kdKab;
  String kdKec;
  String active;
  DateTime recorder;
  String pencatat;

  RegisterModelUser({
    required this.userId,
    required this.password,
    required this.nama,
    required this.admType,
    required this.idApotek,
    required this.telpon,
    required this.whatsapp,
    required this.kdPro,
    required this.kdKab,
    required this.kdKec,
    required this.active,
    required this.recorder,
    required this.pencatat,
  });

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'password': password,
        'nama': nama,
        'admType': admType,
        'idApotek': idApotek,
        'telpon': telpon,
        'whatsapp': whatsapp,
        'kdPro': kdPro,
        'kdKab': kdKab,
        'kdKec': kdKec,
        'active': active,
        'recorder': recorder.toIso8601String(),
        'pencatat': pencatat,
      };

  factory RegisterModelUser.fromJson(Map<String, dynamic> json) => RegisterModelUser(
        userId: json['userId'],
        password: json['password'],
        nama: json['nama'],
        admType: json['admType'],
        idApotek: json['idApotek'],
        telpon: json['telpon'],
        whatsapp: json['whatsapp'],
        kdPro: json['kdPro'],
        kdKab: json['kdKab'],
        kdKec: json['kdKec'],
        active: json['active'],
        recorder: DateTime.parse(json['recorder']),
        pencatat: json['pencatat'],
      );
}

