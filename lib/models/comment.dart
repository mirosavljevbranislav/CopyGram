class CommentModel {
  String? username;
  String? commentID;
  String? postID;
  List? likes;
  String? pictureID;
  String? commentedAt;
  String? commentContent;

  CommentModel({
    required this.username,
    required this.commentID,
    required this.postID,
    required this.likes,
    required this.pictureID,
    required this.commentedAt,
    required this.commentContent,
  });

  Map<String, dynamic> toJson() => _commentToJson(this);

  Map<String, dynamic> _commentToJson(CommentModel instance) =>
      <String, dynamic>{
        'username': instance.username,
        'commentID': instance.commentID,
        'postID': instance.postID,
        'likes': instance.likes,
        'pictureID': instance.pictureID,
        'commentedAt': instance.commentedAt,
        'commentContet': instance.commentContent,
      };
}
