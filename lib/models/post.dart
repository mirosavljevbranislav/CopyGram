class Post {
  String? profilePictureID;
  String? username;
  String? userID;
  String? postID;
  String? picture;
  String? location;
  String? description;
  String? pictureTakenAt;
  List? likes;
  List? comments;

  Post({
    this.profilePictureID,
    this.username,
    this.userID,
    this.postID,
    this.picture,
    this.location,
    this.description,
    this.pictureTakenAt,
    this.likes,
    this.comments,
  });

  Map<String, dynamic> toJson() => _postToJson(this);

  Map<String, dynamic> _postToJson(Post instance) => <String, dynamic>{
        'profilePictureID': instance.profilePictureID,
        'username': instance.username,
        'userID': instance.userID,
        'postID': instance.postID,
        'picture': instance.picture,
        'location': instance.location,
        'description': instance.description,
        'likes': instance.likes,
        'comments': instance.comments,
        'pictureTakenAt': instance.pictureTakenAt,
      };
}
