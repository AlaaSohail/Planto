import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plant_care/controllers/cache/cache_helper.dart';
import 'package:plant_care/controllers/services/service_locator.dart';

import '../../controllers/cubit/community_cubit/community_cubit.dart';
import '../../controllers/paths/ApiEndpoints.dart';

class PostCard extends StatelessWidget {
  const PostCard({
    super.key,
    required this.imageUrl,
    required this.content,
    required this.userName,
    required this.userImage,
    required this.postId,
    required this.userId,
  });

  final String? imageUrl;
  final int? postId;
  final String content;
  final String userName;
  final String? userImage;
  final int? userId;

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
                          userImage != null && userImage!.isNotEmpty
                          ? CachedNetworkImageProvider(userImage!)
                          : null,

                      child: userImage == null || userImage!.isEmpty
                          ? Icon(Icons.person, size: 24.r)
                          : null,
                    ),

                    SizedBox(width: 10.w),

                    Text(
                      userName,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Spacer(),

                    if (userId == getIt<CacheHelper>().getData(key: ApiKeys.id))
                      // IconButton(
                      //   icon: Image.asset(
                      //     'assets/images/menu.png',
                      //     width: 20.w,
                      //     height: 20.h,
                      //   ),
                      //   onPressed: () async {
                      //     final selected = await showMenu<String>(
                      //       context: context,
                      //       position: const RelativeRect.fromLTRB(
                      //         300,
                      //         100,
                      //         20,
                      //         0,
                      //       ),
                      //       shape: RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.circular(16.r),
                      //       ),
                      //       elevation: 4,
                      //       color: Colors.white,
                      //
                      //       items: const [
                      //         PopupMenuItem<String>(
                      //           value: 'Delete',
                      //           child: Text('Delete'),
                      //         ),
                      //         PopupMenuItem<String>(
                      //           value: 'edit',
                      //           child: Text('Edit'),
                      //         ),
                      //         PopupMenuItem<String>(
                      //           value: 'share',
                      //           child: Text('Share'),
                      //         ),
                      //       ],
                      //     );
                      //
                      //     if (selected == 'Delete' && postId != null) {
                      //       await context.read<CommunityCubit>().deletePost(
                      //         postId.toString(),
                      //       );
                      //     }
                      //   },
                      //
                      //   color: Colors.grey,
                      // ),
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

                              if (selected == 'Delete' && postId != null) {
                                await context.read<CommunityCubit>().deletePost(
                                  postId.toString(),
                                );
                              }

                            },
                          );
                        },
                      ),
                  ],
                ),

                SizedBox(height: 10.h),

                Text(
                  content,
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
          if (imageUrl != null && imageUrl!.isNotEmpty)
            CachedNetworkImage(
              imageUrl: imageUrl!,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 200.h,

              errorWidget: (context, url, error) {
                return const SizedBox.shrink();
              },
            ),

          Padding(
            padding: EdgeInsets.all(8.0.r),

            child: Row(
              children: [
                Image.asset(
                  "assets/images/heart.png",
                  width: 20.w,
                  height: 20.h,
                ),

                SizedBox(width: 6.w),

                Text("123", style: Theme.of(context).textTheme.bodyMedium),

                SizedBox(width: 20.w),

                Image.asset(
                  "assets/images/comment.png",
                  width: 20.w,
                  height: 20.h,
                ),

                SizedBox(width: 6.w),

                Text("123", style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
