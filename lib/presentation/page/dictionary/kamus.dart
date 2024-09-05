class KamusModel {
  final String id;
  final String kata;
  final String gambar;
  final String? gambar2;
  final String? keterangan;
  final String video;

  KamusModel({required this.id,required this.kata,this.keterangan, required this.gambar, this.gambar2, required this.video});

  factory KamusModel.fromJson(Map<String, dynamic> json) {
    return KamusModel(
      id: json['id'],
      kata: json['kata'],
      keterangan: json['keterangan'],
      gambar: json['gambar'],
      gambar2: json['gambar2'],
      video: json['video'],
    );
  }
}
