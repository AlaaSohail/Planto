import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plant_care/controllers/cubit/ai_cubit/ai_cubit.dart';
import 'package:plant_care/presentations/widgets/AuthTextField.dart';

import '../../../controllers/cubit/user_cubit/user_cubit.dart';
import '../../themes/app_colors.dart';
import '../../themes/app_theme.dart';
import '../../widgets/ContainerIcons.dart';

class AiChatScreen extends StatefulWidget {
  const AiChatScreen({super.key});

  @override
  State<AiChatScreen> createState() => _AiChatScreenState();
}

class _AiChatScreenState extends State<AiChatScreen> {
  TextEditingController messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<AiCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Color(0xfff7fbf5),
      appBar: AppBar(
        titleSpacing: 10.w,
        title: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "Planto \n",
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: "Online · Expert botanist AI",
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.green,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ),

        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: ContainerIcons(icon: 'assets/images/star.png'),
          ),
        ],
        leadingWidth: 56.w,
        leading: AppTheme.backButton(context),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: BlocConsumer<AiCubit, AiState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.all(16.r),
                    children: [
                      // Chat messages هنا
                    ],
                  ),
                ),

                Container(
                  decoration: BoxDecoration(
                    color: Colors.greenAccent,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12.r),
                      topRight: Radius.circular(12.r),
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
                          hintText: 'Ask me anything...',

                          keyboardType: TextInputType.multiline,
                        ),
                      ),

                      SizedBox(width: 6.w),

                      IconButton.filled(
                        onPressed: () {
                          if (messageController.text.trim().isNotEmpty &&
                              messageController.text != "") {
                            context.read<AiCubit>().chatAiBot(
                              messageController.text,
                            );
                            messageController.clear();
                          }
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
