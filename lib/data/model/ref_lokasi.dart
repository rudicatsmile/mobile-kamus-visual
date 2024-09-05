// To parse this JSON data, do
//
//     final unit = unitFromJson(jsonString);

import 'dart:convert';

RefLokasi refLokasiFromJson(String str) => RefLokasi.fromJson(json.decode(str));

String refLokasiToJson(RefLokasi data) => json.encode(data.toJson());

class RefLokasi {
  RefLokasi({
    this.kodeUnit,
    this.namaUnit,
  });

  String? kodeUnit;
  String? namaUnit;

  factory RefLokasi.fromJson(Map<String, dynamic> json) => RefLokasi(
        kodeUnit: json["kode_unit"],
        namaUnit: json["nama_unit"],
      );

  Map<String, dynamic> toJson() => {
        "kode_unit": kodeUnit,
        "nama_unit": namaUnit,
      };

  @override
  String toString() => namaUnit.toString();
}
