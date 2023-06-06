class Exercise {
  String id;
  String title;
  String description;
  String? answer;
  String location;
  String? photo;
  String activationRange;
  String exerciseType;
  String teacherId;

  Exercise({
    required this.id,
    required this.title,
    required this.description,
    this.answer,
    required this.location,
    this.photo,
    required this.activationRange,
    required this.exerciseType,
    required this.teacherId,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      id: json['_id'],
      title: json['title'],
      description: json['description'],
      answer: json['answer'],
      location: json['location'],
      photo: json['photo'],
      activationRange: json['activationRange'],
      exerciseType: json['exerciseType'],
      teacherId: json['teacherId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'answer': answer,
      'location': location,
      'photo': photo,
      'activationRange': activationRange,
      'exerciseType': exerciseType,
      'teacherId': teacherId,
    };
  }
}