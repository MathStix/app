class Answer {
  List<String> texts;
  String exerciseId;
  String teamId;
  List<String> photos;
  String? canvas;

  Answer({
    required this.texts,
    required this.exerciseId,
    required this.teamId,
    required this.photos,
    required this.canvas,
  });

  Map<String, dynamic> toJson() {
    return {
      'texts': texts,
      'exerciseId': exerciseId,
      'teamId': teamId,
      'photos': photos,
      'canvas': canvas,
    };
  }
}
