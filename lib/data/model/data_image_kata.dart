class DataImageKata {
  DataImageKata({
    this.idt,
    this.tahun,
    this.bulan,
    this.nik,
    this.fileContent,
    this.fileName,
    this.fileType,
    this.fileSize,
    this.title,
    this.lat,
    this.lng,
    this.mode,
    this.pencatat,
    this.recorded,
  });

  int? idt;
  String? tahun;
  String? bulan;
  String? nik;
  String? fileContent;
  String? fileName;
  String? fileType;
  String? fileSize;
  String? title;
  String? lat;
  String? lng;
  String? mode;
  String? pencatat;
  String? recorded;

  factory DataImageKata.fromJson(Map<String, dynamic> json) => DataImageKata(
        idt: json["IDT"] != null ? int.parse(json["IDT"].toString()) : null,
        tahun: json["tahun"],
        bulan: json["bulan"],
        nik: json["nik"],
        fileContent: json["file_content"],
        fileName: json["file_name"],
        fileType: json["file_type"],
        fileSize: json["file_size"],
        title: json["title"],
        lat: json["lat"],
        lng: json["lng"],
        mode: json["mode"],
        pencatat: json["pencatat"],
        recorded: json["recorded"],
      );

  Map<String, dynamic> toJson() => {
        "idt": idt,
        "tahun": tahun,
        "bulan": bulan,
        "nik": nik,
        "file_content": fileContent,
        "file_name": fileName,
        "file_type": fileType,
        "file_size": fileSize,
        "title": title,
        "lat": lat,
        "lng": lng,
        "mode": mode,
        "pencatat": pencatat,
        "recorded": recorded,
      };
}
