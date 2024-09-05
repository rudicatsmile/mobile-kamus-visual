import 'dart:convert';

DataDashboard dataDashboardFromJson(String str) => DataDashboard.fromJson(json.decode(str));

String dataDashboardToJson(DataDashboard data) => json.encode(data.toJson());


class DataDashboard {
  DataDashboard(
      {this.idt,
      this.namaAplikasi,
      this.judulUtama,
      this.judulProfil,
      this.motoProfil,
      this.namaCaleg,
      this.namaPartai,
      this.targetSuara,
      this.rating,
      this.image,
      this.app,
      });

  String? idt;
  String? namaAplikasi;
  String? judulUtama;
  String? judulProfil;
  String? motoProfil;
  String? namaCaleg;
  String? namaPartai;
  String? targetSuara;
  String? rating;
  String? image;
  String? app;

  factory DataDashboard.fromJson(Map<String, dynamic> json) => DataDashboard(
        idt: json["IDT"],
        namaAplikasi: json["Nama_Aplikasi"],
        judulUtama: json["Judul_Utama"],
        judulProfil: json["Judul_Profil"],
        motoProfil: json["Moto_Profil"],
        namaCaleg: json["Nama_daerah"],
        namaPartai: json["Nama_pengelola"],
        targetSuara: json["Target"],
        rating: json["Rating"],
        image: json["Image"],
        app: json["App"],
      );

  Map<String, dynamic> toJson() => {
        "idt": idt,
        "Nama_Aplikasi": namaAplikasi,
        "Judul_Utama": judulUtama,
        "Judul_Profil": judulProfil,
        "Moto_Profil": motoProfil,
        "Nama_daerah": namaCaleg,
        "Nama_pengelola": namaPartai,
        "Target": targetSuara,
        "Rating": rating,
        "Image": image,
        "App": app,
      };
}
