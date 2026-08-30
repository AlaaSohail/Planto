import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plant_care/controllers/cache/cache_helper.dart';
import 'package:plant_care/controllers/services/service_locator.dart';
import 'package:plant_care/presentations/screens/nav_bar_screens/PostDetailsScreen.dart';

import '../../controllers/core/functions/IsArabic.dart';
import '../../controllers/cubit/community_cubit/community_cubit.dart';
import '../../controllers/models/post_model.dart';
import '../../controllers/paths/ApiEndpoints.dart';
import 'ModalBottomSheet.dart';

class PostCard extends StatefulWidget {
  PostCard({
    super.key,
    required this.imageUrl,
    required this.content,
    required this.userName,
    required this.userImage,
    required this.postId,
    required this.userId,
    this.onTap,
    this.likesCount,
    this.commentsCount,
    this.isLiked,
    required this.post,
  });

  PostModel? post;

  final String? imageUrl;
  final int? postId;
  final String content;
  final String userName;
  final String? userImage;
  final int? userId;

  final String? likesCount;
  final String? commentsCount;

  final bool? isLiked;

  GestureTapCallback? onTap;

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      elevation: 4,
      color: Colors.grey.shade50,
      clipBehavior: Clip.antiAlias,

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(8.0.r),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20.r,

                      backgroundImage:
                          widget.userImage != null &&
                              widget.userImage!.isNotEmpty
                          ? CachedNetworkImageProvider(widget.userImage!)
                          : null,

                      child:
                          widget.userImage == null || widget.userImage!.isEmpty
                          ? Icon(Icons.person, size: 24.r)
                          : null,
                    ),

                    SizedBox(width: 10.w),

                    Text(
                      widget.userName,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Spacer(),

                    if (widget.userId ==
                        getIt<CacheHelper>().getData(key: ApiKeys.id))
                      Builder(
                        builder: (buttonContext) {
                          return IconButton(
                            icon: Image.asset(
                              'assets/images/menu.png',
                              width: 20.w,
                              height: 20.h,
                            ),
                            onPressed: () async {
                              final RenderBox button =
                                  buttonContext.findRenderObject() as RenderBox;

                              final RenderBox overlay =
                                  Overlay.of(
                                        buttonContext,
                                      ).context.findRenderObject()
                                      as RenderBox;

                              final Offset position = button.localToGlobal(
                                Offset.zero,
                                ancestor: overlay,
                              );

                              final selected = await showMenu<String>(
                                context: buttonContext,
                                position: RelativeRect.fromRect(
                                  Rect.fromLTWH(
                                    position.dx,
                                    position.dy,
                                    button.size.width,
                                    button.size.height,
                                  ),
                                  Offset.zero & overlay.size,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16.r),
                                ),
                                elevation: 4,
                                color: Colors.white,
                                items: const [
                                  PopupMenuItem<String>(
                                    value: 'Delete',
                                    child: Text('Delete'),
                                  ),
                                  PopupMenuItem<String>(
                                    value: 'edit',
                                    child: Text('Edit'),
                                  ),
                                  PopupMenuItem<String>(
                                    value: 'share',
                                    child: Text('Share'),
                                  ),
                                ],
                              );

                              if (selected == 'Delete' &&
                                  widget.postId != null) {
                                await context.read<CommunityCubit>().deletePost(
                                  widget.postId.toString(),
                                );
                              } else if (selected == 'edit' &&
                                  widget.postId != null) {}
                            },
                          );
                        },
                      ),
                  ],
                ),

                SizedBox(height: 10.h),

                Text(
                  widget.content,
                  textDirection: isArabic(widget.content)
                      ? TextDirection.rtl
                      : TextDirection.ltr,

                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                  ),
                ),

                SizedBox(height: 10.h),
              ],
            ),
          ),

          // Post Image
          if (widget.imageUrl != null && widget.imageUrl!.isNotEmpty)
            CachedNetworkImage(
              imageUrl: widget.imageUrl!,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 200.h,

              errorWidget: (context, url, error) {
                return const SizedBox.shrink();
              },
            ),

          InkWell(
            onTap: () {
              if (widget.postId != null) {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => PostDetailsScreen(post: widget.post!),
                  ),
                );
              }
            },
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,

            child: Padding(
              padding: EdgeInsets.all(8.0.r),

              child: BlocBuilder<CommunityCubit, CommunityState>(
                buildWhen: (previous, current) =>
                    current is CommunityLikeUpdated,
                builder: (context, state) {
                  final cubit = context.read<CommunityCubit>();

                  final likes = cubit.likeCounts[widget.postId] ?? 0;
                  final comments = cubit.commentsCounts[widget.postId] ?? 0;

                  final liked = cubit.likedPosts[widget.postId] ?? false;

                  return Row(
                    children: [
                      InkWell(
                        onTap: () {
                          if (widget.postId != null) {
                            cubit.addLike(widget.postId!);
                          }
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
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),

                      SizedBox(width: 20.w),

                      InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,

                        onTap: () {
                          if (widget.postId != null) {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) =>
                                    PostDetailsScreen(post: widget.post!),
                              ),
                            );
                          }
                        },
                        child: Image.asset(
                          "assets/images/comment.png",
                          width: 20.w,
                          height: 20.h,
                        ),
                      ),

                      SizedBox(width: 6.w),
                      Text(
                        comments.toString(),
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
