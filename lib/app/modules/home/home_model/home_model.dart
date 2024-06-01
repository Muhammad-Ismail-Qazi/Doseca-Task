class HomeModel {
  String? text;
  String? userId;

  HomeModel({this.text, this.userId});

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'userId': userId,
    };
  }

  factory HomeModel.fromMap(Map<String, dynamic> map) {
    return HomeModel(
      text: map['text'],
      userId: map['userId'],
    );
  }
}