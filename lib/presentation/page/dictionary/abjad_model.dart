class AbjadModel {
  final String letter;
  final String word;
  final String image;

  AbjadModel({required this.letter, required this.word, required this.image});

  factory AbjadModel.fromJson(Map<String, dynamic> json) {
    return AbjadModel(
      letter: json['letter'],
      word: json['word'],
      image: json['image'],
    );
  }
}
