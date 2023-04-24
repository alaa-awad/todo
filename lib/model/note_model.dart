class NoteModel {
  late int id;
  late String title;
  late String content;

  NoteModel({
    required this.id,
    required this.title,
    required this.content,
  });

  NoteModel.fromJson(dynamic json) {
    id = json["id"];
    title = json["title"];
    content = json["content"];
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "content": content,
    };
  }
}
