class PostModel {
  final int id;
  final int userId;
  final String content;
  final String? imageUrl;
  final String? imagePublicId;
  final DateTime createdAt;

  final String userName;
  final String? userImage;

  final String likesCount;
  final String commentsCount;
  final bool likedByMe;

  PostModel({
    required this.id,
    required this.userId,
    required this.content,
    this.imageUrl,
    this.imagePublicId,
    required this.createdAt,
    required this.userName,
    this.userImage,
    required this.likesCount,
    required this.commentsCount,
    required this.likedByMe,
  });

  factory PostModel.fromJson(Map<String, dynamic> jsonData) {
    return PostModel(
      id: jsonData['id'],
      userId: jsonData['user_id'],
      content: jsonData['content'],
      imageUrl: jsonData['image_url'],
      imagePublicId: jsonData['image_public_id'],
      createdAt: DateTime.parse(jsonData['created_at']),
      userName: jsonData['user_name'] ?? '',
      userImage: jsonData['user_image'],
      likesCount: jsonData['likes_count'],
      commentsCount: jsonData['comments_count'],
      likedByMe: jsonData['liked_by_me'],
    );
  }
}
