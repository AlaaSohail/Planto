import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plant_care/controllers/cubit/community_cubit/community_cubit.dart';
import 'package:plant_care/presentations/widgets/AuthTextField.dart';
import 'package:plant_care/presentations/widgets/ModalBottomSheet.dart';

import '../../../controllers/cubit/plant_cubit/plant_cubit.dart';
import '../../themes/app_colors.dart';
import '../../themes/app_theme.dart';
import '../../widgets/ContainerIcons.dart';
import '../../widgets/PostCard.dart';
import '../plants_screens/AddPlantManualScreen.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen(this.onBackToHome, {super.key});

  final VoidCallback onBackToHome;

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  TextEditingController postController = TextEditingController();

  String hintText = "What's on your mind?";
  TextInputType keyboardType = TextInputType.text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff7fbf5),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leadingWidth: 55.w,
        leading: AppTheme.backButton(context, onPressed: widget.onBackToHome),
        titleSpacing: 10.w,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: InkWell(
              focusColor: Colors.transparent,
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              hoverColor: Colors.transparent,

              child: ContainerIcons(icon: 'assets/images/plus.png'),
              onTap: () {
                postController.clear();
                context.read<CommunityCubit>().postImage = null;
                showModalBottomSheet(
                  context: context,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.r),
                      topRight: Radius.circular(20.r),
                    ),
                  ),
                  backgroundColor: Colors.white,

                  builder: (context) {
                    return ModalBottomSheet(
                      hintText: hintText,
                      controller: postController,
                      actionText: "Deploy",
                      onPress: () async {
                        final content = postController.text.trim();

                        if (content.isEmpty) {
                          return;
                        }

                        Navigator.pop(context);

                        await context.read<CommunityCubit>().addPost(
                          content,
                          context.read<CommunityCubit>().postImage,
                        );

                        postController.clear();
                        context.read<CommunityCubit>().postImage = null;
                      },
                      title: "Add a new post",
                    );
                  },
                );
              },
            ),
          ),
        ],
        title: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "Community",
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),

      body: BlocConsumer<CommunityCubit, CommunityState>(
        listener: (context, state) {
          if (state is CommunityError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          final cubit = context.read<CommunityCubit>();
          final posts = cubit.posts;

          if (state is CommunityLoading && posts.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (posts.isEmpty) {
            return const Center(child: Text("No Posts Found"));
          }

          //final randomPosts = List.of(posts)..shuffle();
          final allPost = cubit.posts;
          return SingleChildScrollView(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: allPost.length,
                    itemBuilder: (context, index) {
                      final post = allPost[index];

                      return PostCard(
                        imageUrl: post.imageUrl,
                        content: post.content,
                        userName: post.userName,
                        userImage: post.userImage,
                        postId: post.id,
                        userId: post.userId,
                        likesCount: post.likesCount.toString(),
                        commentsCount: post.commentsCount,
                        isLiked: post.likedByMe,
                        post: post,
                        onTap: () async {
                          await cubit.addLike(post.id);
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    context.read<CommunityCubit>().getPosts();
  }

  @override
  void dispose() {
    postController.dispose();
    super.dispose();
  }
}
