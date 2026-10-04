class ChatMessage {
  final String message;
  final bool isUser;
  final bool isLoading;
  final String? imagePath;

  ChatMessage({
    required this.message,
    required this.isUser,
    this.isLoading = false,
    this.imagePath,
  });
}
