class ListKata {
  ListKata({
    this.id,
    this.kata,
    this.keterangan,
    this.keterangan2,
    this.gambar,
    this.gambar2,
    this.gambar3,
    this.video,
    this.status,
    this.pencatat,
    this.recorded,
  });

  int? id;
  String? kata;
  String? keterangan;
  String? keterangan2;
  String? gambar;
  String? gambar2;
  String? gambar3;
  String? video;
  String? status;
  String? pencatat;
  String? recorded;

  factory ListKata.fromJson(Map<String, dynamic> json) => ListKata(
        id: json["id"] != null ? int.parse(json["id"].toString()) : null,
        kata: json["kata"],
        keterangan: json["keterangan"],
        keterangan2: json["keterangan2"],
        gambar: json["gambar"],
        gambar2: json["gambar2"],
        gambar3: json["gambar3"],
        video: json["video"],
        status: json["status"],
        pencatat: json["pencatat"],
        recorded: json["recorded"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "kata": kata,
        "keterangan": keterangan,
        "keterangan2": keterangan2,
        "gambar": gambar,
        "gambar2": gambar2,
        "gambar3": gambar3,
        "video": video,
        "status": status,
        "pencatat": pencatat,
        "recorded": recorded,
      };
}
