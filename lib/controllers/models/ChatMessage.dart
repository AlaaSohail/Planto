class ChatMessage {
  final String message;
  final bool isUser;
  final bool isLoading;

  ChatMessage({
    required this.message,
    required this.isUser,
    this.isLoading = false,
  });
}