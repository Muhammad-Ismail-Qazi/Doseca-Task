class HomeModel {
  String? text;
  String? userId;
  String? imageUrl;
  String? pdfUrl;

  HomeModel({this.text, this.userId, this.imageUrl, this.pdfUrl});

  Map<String, dynamic> toMap() {
    return {
      'text': text ?? '',
      'userId': userId,
      'imageUrl': imageUrl ?? '',
      'pdfUrl': pdfUrl ?? '',
    };
  }

  factory HomeModel.fromMap(Map<String, dynamic> map) {
    print('Parsing HomeModel from map: $map');
    return HomeModel(
      text: map['text'] ?? '',
      userId: map['userId'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      pdfUrl: map['pdfUrl'] ?? '',
    );
  }

  @override
  String toString() {
    return 'HomeModel(text: $text, userId: $userId, imageUrl: $imageUrl, pdfUrl: $pdfUrl)';
  }
}