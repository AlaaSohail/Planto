import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:meta/meta.dart';
import 'package:plant_care/controllers/core/api/api_consumer.dart';
import 'package:plant_care/controllers/core/errors/exceptions.dart';
import 'package:plant_care/controllers/paths/ApiEndpoints.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit(this.api) : super(PaymentInitial());

  ApiConsumer api;
  String? secretClient;
  Dio dio = Dio();

  Future<void> makePayment(double amount, String currency) async {
    emit(PaymentLoading());

    try {
      final response = await dio.post(
        ApiEndpoints.paymentUrl,
        options: Options(

        ),
        data: {
          PaymentApiKeys.amount: _getFinalAmount(amount),
          PaymentApiKeys.currency: currency.toLowerCase(),
        },
      );

      secretClient = response.data['client_secret'];

      if (secretClient == null || secretClient!.isEmpty) {
        throw Exception('client_secret is missing');
      }

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: secretClient!,
          merchantDisplayName: 'Planto',
        ),
      );

      await Stripe.instance.presentPaymentSheet();

      emit(PaymentSuccess());
    } on DioException {
      emit(PaymentError());
    } on StripeException {
      emit(PaymentError());
    } catch (e) {
      emit(PaymentError());
    }
  }

  int _getFinalAmount(double amount) {
    return (amount * 100).round();
  }
}
