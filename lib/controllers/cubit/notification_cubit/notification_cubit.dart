import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:plant_care/controllers/core/api/api_consumer.dart';

import '../../services/notification_service.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit(this.api) : super(NotificationInitial());

  ApiConsumer api;

  Future<void> updateFcmToken() async {
    final token = await NotificationService.getToken();

    if (token == null || token.isEmpty) return;

    await api.put('/api/users/fcm-token', data: {'fcmToken': token});
  }
}
