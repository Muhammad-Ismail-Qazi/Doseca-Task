class HomeModel {
  String? text;
  String? userId;
  String? imageUrl;
  String? pdfUrl;


  HomeModel({this.text, this.userId,this.imageUrl,this.pdfUrl});

  Map<String, dynamic> toMap() {
    return {
      'text': text ?? '',
      'userId': userId,
      'imageUrl': imageUrl ?? '',
      'pdfUrl': pdfUrl ?? '',
    };
  }

  factory HomeModel.fromMap(Map<String, dynamic> map) {
    return HomeModel(
      text: map['text'],
      userId: map['userId'],
      pdfUrl: map['pdfUrl'],
    );
  }
}