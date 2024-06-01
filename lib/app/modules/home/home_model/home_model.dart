class HomeModel {
  String? text;
  String? userId;
  String? imageUrl;


  HomeModel({this.text, this.userId,this.imageUrl});

  Map<String, dynamic> toMap() {
    return {
      'text': text ?? '',
      'userId': userId,
      'imageUrl': imageUrl ?? '',
    };
  }

  factory HomeModel.fromMap(Map<String, dynamic> map) {
    return HomeModel(
      text: map['text'],
      userId: map['userId'],
      imageUrl: map['imageUrl'],
    );
  }
}