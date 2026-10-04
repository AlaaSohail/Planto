import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plant_care/controllers/cubit/ai_cubit/ai_cubit.dart';
import 'package:plant_care/presentations/widgets/AuthTextField.dart';

import '../../../l10n/app_localizations.dart';
import '../../themes/app_colors.dart';
import '../../themes/app_theme.dart';

class AiChatScreen extends StatefulWidget {
  const AiChatScreen({super.key});

  @override
  State<AiChatScreen> createState() => _AiChatScreenState();
}

class _AiChatScreenState extends State<AiChatScreen> {
  final TextEditingController messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final ImagePicker _picker = ImagePicker();
  XFile? _selectedImage;
  bool _isPickingImage = false;
  bool _isSending = false;

  @override
  void initState() {
    super.initState();
    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || !_scrollController.hasClients) return;
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );
    });
  }

  Future<void> _pickImage() async {
    if (_isPickingImage || _isSending || context.read<AiCubit>().isChatSending)
      return;

    setState(() => _isPickingImage = true);
    try {
      final image = await _picker.pickImage(source: ImageSource.gallery);
      if (!mounted || image == null) return;
      setState(() => _selectedImage = image);
      _scrollToBottom();
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.aiChatImagePickError),
        ),
      );
    } finally {
      if (mounted) setState(() => _isPickingImage = false);
    }
  }

  Future<void> _sendMessage() async {
    final cubit = context.read<AiCubit>();
    if (_isSending || _isPickingImage || cubit.isChatSending) return;

    final draftText = messageController.text;
    final text = draftText.trim();
    final image = _selectedImage;
    if (text.isEmpty && image == null) return;

    final l10n = AppLocalizations.of(context)!;
    setState(() {
      _isSending = true;
      _selectedImage = null;
      messageController.clear();
    });

    try {
      final reply = await cubit.chatAiBot(
        text,
        image: image,
        imageOnlyPrompt: l10n.aiChatImagePrompt,
        failureMessage: l10n.aiChatSendError,
      );
      if (!mounted) return;

      // Preserve a newer draft if the user typed while waiting.
      if (reply == null &&
          messageController.text.isEmpty &&
          _selectedImage == null) {
        setState(() {
          messageController.text = draftText;
          _selectedImage = image;
        });
      }
    } finally {
      if (mounted) {
        setState(() => _isSending = false);
        _scrollToBottom();
      }
    }
  }

  Widget _photo(String path, {required double width, required double height}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.r),
      child: Image.file(
        File(path),
        width: width,
        height: height,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => SizedBox(
          width: width,
          height: height,
          child: Center(
            child: Text(
              AppLocalizations.of(context)!.aiChatImageUnavailable,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          l10n.aiChatOnlineExpert,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: AppColors.secondary,
            fontWeight: FontWeight.w700,
          ),
        ),
        leading: AppTheme.backButton(context),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: BlocConsumer<AiCubit, AiState>(
          listenWhen: (_, state) =>
              state is AiChatLoading ||
              state is AiChatSuccess ||
              state is AiChatError,
          listener: (_, state) => _scrollToBottom(),
          builder: (context, state) {
            final cubit = context.read<AiCubit>();
            final busy = _isSending || cubit.isChatSending;
            final attachment = _selectedImage;

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    padding: EdgeInsets.all(16.r),
                    itemCount: cubit.messages.length,
                    itemBuilder: (context, index) {
                      final message = cubit.messages[index];
                      final imagePath = message.imagePath;
                      return Align(
                        alignment: message.isUser
                            ? AlignmentDirectional.centerEnd
                            : AlignmentDirectional.centerStart,
                        child: Container(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.8,
                          ),
                          margin: EdgeInsets.only(bottom: 10.h),
                          padding: EdgeInsets.symmetric(
                            horizontal: 14.w,
                            vertical: 10.h,
                          ),
                          decoration: BoxDecoration(
                            color: message.isUser
                                ? AppColors.primary
                                : AppColors.secondary.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          child: message.isLoading
                              ? SizedBox(
                                  width: 36.w,
                                  height: 28.h,
                                  child: SpinKitThreeBounce(
                                    color: AppColors.primary,
                                    size: 16.sp,
                                    duration: const Duration(
                                      milliseconds: 1200,
                                    ),
                                  ),
                                )
                              : Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (imagePath != null)
                                      _photo(
                                        imagePath,
                                        width: 220.w,
                                        height: 180.h,
                                      ),
                                    if (imagePath != null &&
                                        message.message.isNotEmpty)
                                      SizedBox(height: 8.h),
                                    if (message.message.isNotEmpty)
                                      Text(
                                        message.message,
                                        style: TextStyle(
                                          color: message.isUser
                                              ? Colors.white
                                              : theme.colorScheme.onSurface,
                                        ),
                                      ),
                                  ],
                                ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.secondary.withOpacity(0.15),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(24.r),
                    ),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.r,
                    vertical: 12.r,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (attachment != null)
                        Padding(
                          padding: EdgeInsets.only(bottom: 10.h),
                          child: Stack(
                            children: [
                              _photo(
                                attachment.path,
                                width: 100.w,
                                height: 90.h,
                              ),
                              PositionedDirectional(
                                top: 0,
                                end: 0,
                                child: IconButton.filled(
                                  tooltip: MaterialLocalizations.of(
                                    context,
                                  ).deleteButtonTooltip,
                                  onPressed: busy || _isPickingImage
                                      ? null
                                      : () => setState(() {
                                          _selectedImage = null;
                                        }),
                                  icon: const Icon(Icons.close, size: 18),
                                ),
                              ),
                            ],
                          ),
                        ),
                      Row(
                        children: [
                          IconButton.filledTonal(
                            tooltip: l10n.aiChatAttachImage,
                            style: IconButton.styleFrom(
                              backgroundColor: Colors.white,
                            ),
                            onPressed: busy || _isPickingImage
                                ? null
                                : _pickImage,
                            icon: Image.asset(
                              'assets/images/image.png',
                              height: 20.h,
                              width: 20.w,
                            ),
                          ),
                          SizedBox(width: 6.w),
                          Expanded(
                            child: AuthTextField(
                              controller: messageController,
                              hintText: l10n.aiChatHint,
                              keyboardType: TextInputType.multiline,
                              obscureText: false,
                            ),
                          ),
                          SizedBox(width: 6.w),
                          IconButton.filled(
                            style: IconButton.styleFrom(
                              backgroundColor: Colors.white,
                            ),
                            onPressed: busy || _isPickingImage
                                ? null
                                : _sendMessage,
                            icon: Image.asset(
                              'assets/images/send.png',
                              height: 20.h,
                              width: 20.w,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}
