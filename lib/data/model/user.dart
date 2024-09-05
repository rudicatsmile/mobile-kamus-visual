class User {

  User({
    this.idt,
    this.userId,
    this.password,
    this.nama,
    this.admType,
    this.idApotek,
    this.telpon,
    this.whatsapp,
    this.kdPro,
    this.kdKab,
    this.kdKec,
    this.active,
    this.recorded,
    this.pencatat,    
  });

  
  int? idt;
  String? userId;
  String? password;
  String? nama;
  String? admType;
  String? idApotek;
  String? telpon;
  String? whatsapp;
  String? kdPro;
  String? kdKab;
  String? kdKec;
  String? active;
  String? recorded;
  String? pencatat;
 
  factory User.fromJson(Map<String, dynamic> json) => User(
        idt: json["IDT"] != null
            ? int.parse(json["IDT"].toString())
            : null,
        userId: json["UserId"],
        password: json["Password"],
        nama: json["Nama"],
        admType: json["AdmType"],
        idApotek: json["IdApotek"],
        telpon: json["Telpon"],
        whatsapp: json["Whatsapp"],
        kdPro: json["KdPro"],
        kdKab: json["KdKab"],
        kdKec: json["KdKec"],
        active: json["Active"],
        recorded: json["Recorded"],
        pencatat: json["Pencatat"],
       
      );

  Map<String, dynamic> toJson() => {
        "IDT": idt,
        "UserId": userId,
        "Password": password,
        "Nama": nama,
        "AdmType": admType,
        "IdApotek": idApotek,
        "Telpon": telpon,
        "Whatsapp": whatsapp,
        "KdPro": kdPro,
        "KdKab": kdKab,
        "KdKec": kdKec,
        "Active": active,
        "Recorded": recorded,
        "Pencatat": pencatat,
      };
}
