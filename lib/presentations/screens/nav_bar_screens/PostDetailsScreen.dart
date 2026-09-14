import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:plant_care/controllers/models/post_model.dart';
import 'package:plant_care/controllers/paths/ApiEndpoints.dart';
import 'package:plant_care/presentations/widgets/AuthTextField.dart';

import '../../../controllers/cubit/community_cubit/community_cubit.dart';
import '../../../l10n/app_localizations.dart';
import '../../themes/app_theme.dart';
import '../../widgets/ContainerIcons.dart';

class PostDetailsScreen extends StatefulWidget {
  const PostDetailsScreen({
    super.key,
    required this.post,
  });

  final PostModel post;

  @override
  State<PostDetailsScreen> createState() => _PostDetailsScreenState();
}

class _PostDetailsScreenState extends State<PostDetailsScreen> {
  final TextEditingController commentController = TextEditingController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context
          .read<CommunityCubit>()
          .getComment(widget.post.id.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final cubit = context.read<CommunityCubit>();

    return Scaffold(
      extendBodyBehindAppBar: widget.post.imageUrl != null,

      appBar: AppBar(
        leading: AppTheme.backButton(context),
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleSpacing: 0,

        actions: [
          ContainerIcons(
            icon: 'assets/images/share.png',
          ),
          SizedBox(width: 4.w),
        ],
      ),

      body: Center(
        child: SingleChildScrollView(
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
                padding: EdgeInsets.symmetric(horizontal: 16.r),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.post.content,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),

                    SizedBox(height: 12.h),

                    BlocBuilder<CommunityCubit, CommunityState>(
                      buildWhen: (previous, current) =>
                      current is CommunityLikeUpdated ||
                          current is CommunityCommentsSuccess,
                      builder: (context, state) {
                        final cubit =
                        context.read<CommunityCubit>();

                        final likes =
                            cubit.likeCounts[widget.post.id] ?? 0;

                        final liked =
                            cubit.likedPosts[widget.post.id] ?? false;

                        return Row(
                          children: [
                            InkWell(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
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
                              style:
                              Theme.of(context).textTheme.bodyMedium,
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
                              style:
                              Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        );
                      },
                    ),

                    SizedBox(height: 12.h),

                    const Divider(),

                    SizedBox(height: 12.h),

                    Row(
                      children: [
                        Expanded(
                          child: AuthTextField(
                            controller: commentController,
                            hintText: localization.addComment,
                            keyboardType: TextInputType.text,
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
                            final isAdding =
                            state is CommunityCommentAdding;

                            return InkWell(
                              onTap: isAdding
                                  ? null
                                  : () async {
                                final content =
                                commentController.text.trim();

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
                                    width: 22.w,
                                    height: 22.h,
                                    child: SpinKitSpinningLines(
                                      color: Theme.of(context)
                                          .textTheme
                                          .headlineSmall!
                                          .color!,
                                      size: 30.sp,
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

                    BlocBuilder<CommunityCubit, CommunityState>(
                      buildWhen: (previous, current) =>
                      current is CommunityCommentsLoading ||
                          current is CommunityCommentsSuccess ||
                          current is CommunityCommentsError,
                      builder: (context, state) {
                        final cubit =
                        context.read<CommunityCubit>();

                        if (state is CommunityCommentsLoading) {
                          return SizedBox(
                            width: double.infinity,
                            height: 300.h,
                            child: Center(
                              child: SpinKitSpinningLines(
                                color: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .color!,
                                size: 30.sp,
                              ),
                            ),
                          );
                        }

                        if (state is CommunityCommentsError) {
                          return SizedBox(
                            width: double.infinity,
                            height: 300.h,
                            child: Center(
                              child: Text(state.message),
                            ),
                          );
                        }

                        return SizedBox(
                          width: double.infinity,
                          height: 400.h,
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: cubit.comments.length,
                            itemBuilder: (context, index) {
                              final comment =
                              cubit.comments[index];

                              return ListTile(
                                contentPadding: EdgeInsets.zero,
                                hoverColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                splashColor: Colors.transparent,

                                leading: CircleAvatar(
                                  radius: 20.r,
                                  backgroundImage:
                                  CachedNetworkImageProvider(
                                    comment[
                                    CommunityApiKeys.userImage]
                                        .toString(),
                                  ),
                                ),

                                title: Text(
                                  comment[
                                  CommunityApiKeys.userName]
                                      .toString(),
                                ),

                                subtitle: Text(
                                  comment[
                                  CommunityApiKeys.content]
                                      .toString(),
                                ),

                                trailing: Text(
                                  comment[
                                  CommunityApiKeys.createdAt]
                                      .toString()
                                      .substring(0, 10),
                                  style: Theme.of(context)
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }
}