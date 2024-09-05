import 'dart:convert';

Caleg calegFromJson(String str) => Caleg.fromJson(json.decode(str));

String calegToJson(Caleg data) => json.encode(data.toJson());

class Caleg {
  Caleg(
      {this.idt,
      this.kode,
      this.nama,
      this.noUrut,
      this.kodeTps,
      this.suaraSah,
      this.suaraBatal,
      this.photo,
      });

  String? idt;
  String? kode;
  String? nama;
  String? noUrut;
  String? kodeTps;
  String? suaraSah;
  String? suaraBatal;
  String? photo;

  factory Caleg.fromJson(Map<String, dynamic> json) => Caleg(
        idt: json["IDT"],
        kode: json["Kode"],
        nama: json["Nama"],
        noUrut: json["No_Urut"],
        kodeTps: json["Kode_Tps"],
        suaraSah: json["Suara_Sah"],
        suaraBatal: json["Suara_Batal"],
        photo: json["Image"],
      );

  Map<String, dynamic> toJson() => {
        "idt": idt,
        "Kode": kode,
        "Nama": nama,
        "No_Urut": noUrut,
        "Kode_Tps": kodeTps,
        "Suara_Sah": suaraSah,
        "Suara_Batal": suaraBatal,
        "Image": photo,
      };
}
