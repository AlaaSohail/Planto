import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:plant_care/controllers/models/post_model.dart';
import 'package:plant_care/controllers/paths/ApiEndpoints.dart';
import 'package:plant_care/presentations/widgets/AuthTextField.dart';

import '../../../controllers/cubit/community_cubit/community_cubit.dart';
import '../../themes/app_theme.dart';
import '../../widgets/ContainerIcons.dart';

class PostDetailsScreen extends StatefulWidget {
  PostDetailsScreen({super.key, required this.post});

  PostModel post;

  @override
  State<PostDetailsScreen> createState() => _PostDetailsScreenState();
}

class _PostDetailsScreenState extends State<PostDetailsScreen> {
  final TextEditingController commentController = TextEditingController();
  String hintText = "Add a comment";
  TextInputType keyboardType = TextInputType.text;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CommunityCubit>();

    return Scaffold(
      backgroundColor: Color(0xfff7fbf5),

      extendBodyBehindAppBar: (widget.post.imageUrl != null) ? true : false,

      appBar: AppBar(
        leading: AppTheme.backButton(context),
        backgroundColor: Colors.transparent,

        elevation: 0,
        actions: [
          ContainerIcons(icon: 'assets/images/share.png'),
          SizedBox(width: 4.w),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            if (widget.post.imageUrl != null)
              CachedNetworkImage(
                imageUrl: widget.post.imageUrl!,
                height: 200.h,
                width: double.infinity,
                fit: BoxFit.fitWidth,
              )
            else
              SizedBox(height: 8.h),

            SizedBox(height: 8.h),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0.r),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.post.content,
                    style: Theme
                        .of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  BlocBuilder<CommunityCubit, CommunityState>(
                    buildWhen: (previous, current) =>
                    current is CommunityLikeUpdated ||
                        current is CommunityCommentsSuccess,
                    builder: (context, state) {
                      final cubit = context.read<CommunityCubit>();

                      final likes = cubit.likeCounts[widget.post.id] ?? 0;
                      final liked = cubit.likedPosts[widget.post.id] ?? false;

                      return Row(
                        children: [
                          InkWell(
                            onTap: () {
                              cubit.addLike(widget.post.id);
                            },
                            child: Icon(
                              liked
                                  ? Icons.favorite_rounded
                                  : Icons.favorite_border_rounded,
                              color: Colors.red,
                              size: 24.sp,
                            ),
                          ),

                          SizedBox(width: 6.w),

                          Text(
                            likes.toString(),
                            style: Theme
                                .of(context)
                                .textTheme
                                .bodyMedium,
                          ),

                          SizedBox(width: 20.w),

                          Image.asset(
                            "assets/images/comment.png",
                            width: 20.w,
                            height: 20.h,
                          ),

                          SizedBox(width: 6.w),

                          Text(
                            cubit.comments.length.toString(),
                            style: Theme
                                .of(context)
                                .textTheme
                                .bodyMedium,
                          ),
                        ],
                      );
                    },
                  ),
                  BlocBuilder<CommunityCubit, CommunityState>(
                    buildWhen: (previous, current) =>
                    current is CommunityCommentsLoading ||
                        current is CommunityCommentsSuccess ||
                        current is CommunityCommentsError,
                    builder: (context, state) {
                      final cubit = context.read<CommunityCubit>();

                      if (state is CommunityCommentsLoading) {
                        return SizedBox(
                          width: double.infinity,
                          height: 300.h,
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }

                      if (state is CommunityCommentsError) {
                        return SizedBox(
                          width: double.infinity,
                          height: 300.h,
                          child: Center(child: Text(state.message)),
                        );
                      }

                      return SizedBox(
                        width: double.infinity,
                        height: 300.h,
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: cubit.comments.length,
                          itemBuilder: (context, index) {
                            final comment = cubit.comments[index];

                            return ListTile(
                              contentPadding: EdgeInsets.zero,

                              hoverColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              splashColor: Colors.transparent,

                              leading: CircleAvatar(
                                radius: 20.r,
                                backgroundImage: CachedNetworkImageProvider(
                                  comment[CommunityApiKeys.userImage]
                                      .toString(),
                                ),
                              ),

                              title: Text(
                                comment[CommunityApiKeys.userName].toString(),
                              ),

                              subtitle: Text(
                                comment[CommunityApiKeys.content].toString(),
                              ),

                              trailing: Text(
                                comment[CommunityApiKeys.createdAt]
                                    .toString()
                                    .substring(0, 10),
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .bodyMedium,
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 12.h),

                  Row(
                    children: [
                      Expanded(
                        child: AuthTextField(
                          controller: commentController,
                          hintText: hintText,
                          keyboardType: keyboardType,
                          prefix: ContainerIcons(
                            icon: 'assets/images/comment.png',
                          ),
                        ),
                      ),

                      SizedBox(width: 4.w),

                      BlocBuilder<CommunityCubit, CommunityState>(
                        buildWhen: (previous, current) =>
                        current is CommunityCommentAdding ||
                            current is CommunityCommentsSuccess ||
                            current is CommunityCommentsError,
                        builder: (context, state) {
                          final isAdding = state is CommunityCommentAdding;

                          return InkWell(
                            onTap: isAdding
                                ? null
                                : () async {
                              final content = commentController.text
                                  .trim();

                              if (content.isEmpty) {
                                return;
                              }

                              await cubit.addComment(
                                widget.post.id.toString(),
                                content,
                              );

                              if (mounted) {
                                commentController.clear();
                              }
                            },
                            child: isAdding
                                ? SizedBox(
                              width: 45.w,
                              height: 45.h,
                              child: Center(
                                child: SizedBox(
                                  width: 22,
                                  height: 22,
                                  child: SpinKitSpinningLines(
                                    color: Theme
                                        .of(context)
                                        .primaryColor,
                                  ),
                                ),
                              ),
                            )
                                : ContainerIcons(
                              icon: 'assets/images/send.png',
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CommunityCubit>().getComment(widget.post.id.toString());
    });
  }

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }
}
