class MoodModel {
  final String mood;
  final String comments;
  final String creatorUid;
  final String date;

  MoodModel({
    required this.mood,
    required this.comments,
    required this.creatorUid,
    required this.date,
  });

  MoodModel.fromJson(Map<String, dynamic> json)
      : mood = json['mood'],
        comments = json['comments'],
        creatorUid = json['creatorUid'],
        date = json['date'];

  MoodModel.empty()
      : mood = "",
        comments = "",
        creatorUid = "",
        date = "";

  Map<String, dynamic> toJson() {
    return {
      "mood": mood,
      "comments": comments,
      "creatorUid": creatorUid,
      "date": date,
    };
  }
}
