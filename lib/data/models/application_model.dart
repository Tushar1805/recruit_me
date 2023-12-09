

class Application {
  final String name;
  final String email;
  final int status;
  final String cv;
  final String interviewer;
  final int action;

  Application({
    required this.name,
    required this.email,
    required this.status,
    required this.cv,
    required this.interviewer,
    required this.action,
  });

  factory Application.fromJson(Map<String, dynamic> json) => Application(
        name: json["name"],
        email: json["email"],
        status: json["status"],
        cv: json["cv"],
        interviewer: json["interviewer"],
        action: json["action"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "status": status,
        "cv": cv,
        "interviewer": interviewer,
        "action": action,
      };
}
