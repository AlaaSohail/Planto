import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:plant_care/controllers/core/api/api_consumer.dart';
import 'package:plant_care/controllers/models/post_model.dart';
import 'package:plant_care/controllers/paths/ApiEndpoints.dart';

import '../../core/errors/exceptions.dart';
import '../../core/functions/upload_image.dart';

part 'community_state.dart';

class CommunityCubit extends Cubit<CommunityState> {
  CommunityCubit(this.api) : super(CommunityInitial());

  final ApiConsumer api;
  XFile? postImage;
  int likeCount = 0;
  List comments = [];
  Map<int, int> likeCounts = {};
  Map<int, bool> likedPosts = {};
  Map<int, int> commentsCounts = {};
  List<PostModel> posts = [];

  Future<void> uploadPostImage(XFile image) async {
    emit(UploadPostImageLoading());

    try {
      postImage = image;

      emit(UploadPostImageSuccess());
    } catch (e) {
      emit(UploadPostImageError(e.toString()));
    }
  }

  Future<void> getPosts() async {
    try {
      final response = await api.get(ApiEndpoints.posts);

      final postsData = response["posts"] as List<dynamic>;

      posts = postsData.map((post) => PostModel.fromJson(post)).toList();

      for (final post in postsData) {
        final int id = int.parse(post['id'].toString());

        likeCounts[id] =
            int.tryParse(post['likes_count']?.toString() ?? '0') ?? 0;

        commentsCounts[id] =
            int.tryParse(post['comments_count']?.toString() ?? '0') ?? 0;

        likedPosts[id] = post['liked_by_me'] == true;
      }

      emit(CommunitySuccess(posts));
    } on ServerException catch (e) {
      emit(CommunityError(e.errorModel.errorMessage));
    } catch (e) {
      emit(CommunityError(e.toString()));
    }
  }

  addPost(String content, XFile? imageUrl) async {
    emit(CommunityLoading());
    try {
      final response = await api.post(
        ApiEndpoints.posts,
        data: {
          CommunityApiKeys.content: content,
          if (imageUrl != null)
            CommunityApiKeys.postImage: await uploadImageToAPI(imageUrl),
        },
        isFormData: true,
      );

      await getPosts();
    } on ServerException catch (e) {
      emit(CommunityError(e.errorModel.errorMessage));
    } catch (e) {
      emit(CommunityError(e.toString()));
    }
  }

  deletePost(String id) async {
    emit(CommunityLoading());
    try {
      final response = await api.delete(ApiEndpoints.deletePosts(id));

      await getPosts();
    } on ServerException catch (e) {
      emit(CommunityError(e.errorModel.errorMessage));
    }
  }

  Future<void> addLike(int postId) async {
    try {
      final response = await api.post(ApiEndpoints.addLike(postId));

      likeCounts[postId] =
          int.tryParse(response['likesCount']?.toString() ?? '0') ?? 0;

      likedPosts[postId] = response['liked'] ?? false;

      emit(CommunityLikeUpdated());
    } on ServerException catch (e) {
      emit(CommunityError(e.errorModel.errorMessage));
    } catch (e) {
      emit(CommunityError(e.toString()));
    }
  }

  Future<void> addComment(
      String postId,
      String content,
      ) async {
    emit(CommunityCommentAdding());

    try {
      await api.post(
        ApiEndpoints.addComment(postId),
        data: {
          CommunityApiKeys.content: content,
        },
      );

      await getComment(
        postId,
        showLoading: false,
      );
    } on ServerException catch (e) {
      emit(
        CommunityCommentsError(
          e.errorModel.errorMessage,
        ),
      );
    } catch (e) {
      emit(
        CommunityCommentsError(
          e.toString(),
        ),
      );
    }
  }

  Future<void> getComment(
      String postId, {
        bool showLoading = true,
      }) async {
    if (showLoading) {
      emit(CommunityCommentsLoading());
    }

    try {
      final response = await api.get(
        ApiEndpoints.addComment(postId),
      );

      comments = response["comments"] as List;

      emit(CommunityCommentsSuccess());
    } on ServerException catch (e) {
      emit(
        CommunityCommentsError(
          e.errorModel.errorMessage,
        ),
      );
    } catch (e) {
      emit(
        CommunityCommentsError(
          e.toString(),
        ),
      );
    }
  }

  deleteComment(String postId, String commentId) async {
    emit(CommunityCommentsLoading());
    try {
      final response = await api.delete(
        ApiEndpoints.deleteComment(postId, commentId),
      );
      comments = response["comments"];

      emit(CommunityCommentsSuccess());
    } on ServerException catch (e) {
      emit(CommunityCommentsError(e.errorModel.errorMessage));
    }
  }
}
