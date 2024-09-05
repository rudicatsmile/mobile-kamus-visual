import 'dart:convert';

DataTim dataTimFromJson(String str) => DataTim.fromJson(json.decode(str));

String dataTimToJson(DataTim data) => json.encode(data.toJson());

class DataTim {
  DataTim(
      {this.idt,
      this.register,
      this.nama,
      this.noUrut,
      this.kelompok,
      this.fileName,
      this.jabatan
      });

  String? idt;
  String? register;
  String? nama;
  String? noUrut;
  String? kelompok;
  String? fileName;
  String? jabatan;

  factory DataTim.fromJson(Map<String, dynamic> json) => DataTim(
        idt: json["IDT"],
        register: json["Register"],
        nama: json["Nama"],
        noUrut: json["No_Urut"],
        kelompok: json["Kelompok"],
        fileName: json["file_name"],
        jabatan: json["Jabatan"],
      );

  Map<String, dynamic> toJson() => {
        "idt": idt,
        "Register": register,
        "Nama": nama,
        "No_Urut": noUrut,
        "Kelompok": kelompok,
        "file_name": fileName,
        "Jabatan": jabatan,
      };
}
