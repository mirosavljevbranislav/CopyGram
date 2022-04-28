import './comment.dart';

class Post {
  String? userID;
  String? picture;
  String? location;
  String? description;
  int? likes;
  List<CommentModel>? comments;

  Post(
      {this.userID,
      this.picture,
      this.location,
      this.description,
      this.likes,
      this.comments});

  Map<String, dynamic> toJson() => _postToJson(this);

  Map<String, dynamic> _postToJson(Post instance) => <String, dynamic>{
        'userID': instance.userID,
        'picture': instance.picture,
        'location': instance.location,
        'description': instance.description,
        'likes': instance.likes,
        'comments': instance.comments,
      };
}
