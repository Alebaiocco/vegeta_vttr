import 'dart:convert';

class ProductComment {
  final String User;
  final String comment;
  final int assessment;

  ProductComment({
    required this.User,
    required this.comment,
    required this.assessment,
  });

  ProductComment copyWith({
    String? User,
    String? comment,
    String? assessment,
  }) {
    return ProductComment(
      User: User ?? this.User,
      comment: comment ?? this.comment,
      assessment: this.assessment,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'User': User,
      'comment': comment,
      'assessment': assessment,
    };
  }

  factory ProductComment.fromMap(Map<String, dynamic> map) {
    return ProductComment(
      User: map['User'] as String,
      comment: map['comment'] as String,
      assessment: map['assessment'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductComment.fromJson(String source) =>
      ProductComment.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ProductComment(User: $User, comment: $comment, assessment: $assessment)';

  @override
  bool operator ==(covariant ProductComment other) {
    if (identical(this, other)) return true;

    return other.User == User &&
        other.comment == comment &&
        other.assessment == assessment;
  }

  @override
  int get hashCode => User.hashCode ^ comment.hashCode ^ assessment.hashCode;
}
