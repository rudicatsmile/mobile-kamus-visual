class KataModel {
  final int? id; // Nullable karena ID bisa null saat membuat data baru
  final String kata;
  final String gambar;
  final String video;

  KataModel({this.id, required this.kata, required this.gambar, required this.video});

  factory KataModel.fromJson(Map<String, dynamic> json) {
    return KataModel(
      id: json['id'],
      kata: json['kata'],
      gambar: json['gambar'],
      video: json['video'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'kata': kata,
      'gambar': gambar,
      'video': video,
    };
  }
}
