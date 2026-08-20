import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:plant_care/controllers/core/api/api_consumer.dart';
import 'package:plant_care/controllers/models/post_model.dart';
import 'package:plant_care/controllers/paths/ApiEndpoints.dart';

import '../../core/errors/exceptions.dart';

part 'community_state.dart';

class CommunityCubit extends Cubit<CommunityState> {
  CommunityCubit(this.api) : super(CommunityInitial());

  final ApiConsumer api;

  getPosts() async {
    emit(CommunityLoading());

    try {
      final response = await api.get(ApiEndpoints.posts);

      final posts = response["posts"] as List<dynamic>;

      emit(
        CommunitySuccess(
          posts.map((post) => PostModel.fromJson(post)).toList(),
        ),
      );
    } on ServerException catch (e) {
      emit(CommunityError(e.errorModel.errorMessage));
    }
  }

  addPost(String content, String? imageUrl) async {
    emit(CommunityLoading());
    try {
      final response = await api.post(
        ApiEndpoints.posts,
        data: {"content": content, "image": imageUrl},
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

}
