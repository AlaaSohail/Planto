import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:plant_care/controllers/cubit/ai_cubit/ai_cubit.dart';
import 'package:plant_care/presentations/widgets/AuthTextField.dart';

import '../../../l10n/app_localizations.dart';
import '../../themes/app_colors.dart';
import '../../themes/app_theme.dart';
import '../../widgets/ContainerIcons.dart';

class AiChatScreen extends StatefulWidget {
  const AiChatScreen({super.key});

  @override
  State<AiChatScreen> createState() => _AiChatScreenState();
}

class _AiChatScreenState extends State<AiChatScreen> {
  final TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      extendBodyBehindAppBar: true,

      appBar: AppBar(
        title: Text(
          l10n.aiChatOnlineExpert,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: AppColors.secondary,
            fontWeight: FontWeight.w700,
          ),
        ),

        leading: AppTheme.backButton(context),

        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.transparent,
      ),

      body: SafeArea(
        child: BlocConsumer<AiCubit, AiState>(
          listener: (context, state) {},

          builder: (context, state) {
            if (state is AiLoading) {
              return Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              );
            }

            final cubit = context.read<AiCubit>();

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.all(16.r),

                    itemCount: cubit.messages.length,

                    itemBuilder: (context, index) {
                      final message = cubit.messages[index];

                      return Align(
                        alignment: message.isUser
                            ? AlignmentDirectional.centerEnd
                            : AlignmentDirectional.centerStart,

                        child: Container(
                          margin: EdgeInsets.only(bottom: 10.h),

                          padding: EdgeInsets.symmetric(
                            horizontal: 14.w,
                            vertical: 10.h,
                          ),

                          decoration: BoxDecoration(
                            color: message.isUser
                                ? AppColors.primary
                                : AppColors.secondary.withOpacity(0.5),

                            borderRadius: BorderRadius.circular(16.r),
                          ),

                          child: message.isLoading
                              ? SizedBox(
                                  width: 32.w,
                                  height: 32.h,

                                  child: SpinKitThreeBounce(
                                    color: AppColors.primary,
                                    size: 16.sp,
                                    duration: const Duration(
                                      milliseconds: 1200,
                                    ),
                                  ),
                                )
                              : Text(
                                  message.message,

                                  style: TextStyle(
                                    color: message.isUser
                                        ? Colors.white
                                        : AppColors.textPrimary,
                                  ),
                                ),
                        ),
                      );
                    },
                  ),
                ),

                Container(
                  decoration: BoxDecoration(
                    color: AppColors.secondary.withOpacity(0.15),

                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24.r),
                      topRight: Radius.circular(24.r),
                    ),
                  ),

                  padding: EdgeInsets.symmetric(
                    horizontal: 8.r,
                    vertical: 12.r,
                  ),

                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,

                    children: [
                      IconButton.filledTonal(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            Colors.white,
                          ),
                        ),

                        onPressed: () {},

                        icon: Image.asset(
                          "assets/images/image.png",
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
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            Colors.white,
                          ),
                        ),

                        onPressed: () {
                          final message = messageController.text.trim();

                          if (message.isEmpty) return;

                          context.read<AiCubit>().chatAiBot(message);

                          messageController.clear();
                        },

                        icon: Image.asset(
                          "assets/images/send.png",
                          height: 20.h,
                          width: 20.w,
                        ),
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
    super.dispose();
  }
}
