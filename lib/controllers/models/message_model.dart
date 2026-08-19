import 'package:image_picker/image_picker.dart';

class ChatMessage {
  final String message;
  final bool isUser;
  final XFile? image;

  ChatMessage({required this.message, required this.isUser, this.image});
}
