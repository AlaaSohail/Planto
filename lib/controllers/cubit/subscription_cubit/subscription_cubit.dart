import 'dart:async';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';

part 'subscription_state.dart';

class SubscriptionCubit extends Cubit<SubscriptionState> {
  SubscriptionCubit() : super(SubscriptionInitial());

  final InAppPurchase _inAppPurchase = InAppPurchase.instance;

  StreamSubscription<List<PurchaseDetails>>? _purchaseSubscription;

  static const String premiumProductId = 'plant_care_premium';

  ProductDetails? weeklyPlan;
  ProductDetails? monthlyPlan;
  ProductDetails? yearlyPlan;

  Future<void> initialize() async {
    emit(SubscriptionLoading());

    try {
      final bool available = await _inAppPurchase.isAvailable();

      if (!available) {
        emit(
          const SubscriptionError(
            'Google Play Billing is not available.',
          ),
        );
        return;
      }

      _purchaseSubscription ??=
          _inAppPurchase.purchaseStream.listen(
            _handlePurchaseUpdates,
            onError: (error) {
              emit(SubscriptionError(error.toString()));
            },
          );

      await loadSubscriptions();
    } catch (e) {
      emit(SubscriptionError(e.toString()));
    }
  }

  Future<void> loadSubscriptions() async {
    try {
      String? playCountry;

      if (Platform.isAndroid) {
        try {
          final androidAddition =
          _inAppPurchase.getPlatformAddition<
              InAppPurchaseAndroidPlatformAddition>();

          playCountry = await androidAddition.getCountryCode();

          print('GOOGLE PLAY COUNTRY = $playCountry');
        } catch (e) {
          print('COUNTRY ERROR = $e');
        }
      }

      final ProductDetailsResponse response =
      await _inAppPurchase.queryProductDetails({
        premiumProductId,
      });

      print('ERROR = ${response.error}');
      print('NOT FOUND = ${response.notFoundIDs}');
      print('PRODUCTS = ${response.productDetails.length}');
      print('PLAY COUNTRY = $playCountry');

      if (response.error != null) {
        emit(SubscriptionError(response.error!.message));
        return;
      }

      if (response.notFoundIDs.isNotEmpty) {
        emit(
          SubscriptionError(
            'Subscription not found: ${response.notFoundIDs.join(', ')}\n'
                'Play country: ${playCountry ?? 'unknown'}',
          ),
        );
        return;
      }

      if (response.productDetails.isEmpty) {
        emit(
          const SubscriptionError(
            'No subscription plans found.',
          ),
        );
        return;
      }

      weeklyPlan = null;
      monthlyPlan = null;
      yearlyPlan = null;

      if (Platform.isAndroid) {
        for (final product in response.productDetails) {
          if (product is! GooglePlayProductDetails) {
            continue;
          }

          final subscriptionIndex = product.subscriptionIndex;

          if (subscriptionIndex == null) {
            continue;
          }

          final offers =
              product.productDetails.subscriptionOfferDetails;

          if (offers == null ||
              subscriptionIndex >= offers.length) {
            continue;
          }

          final offer = offers[subscriptionIndex];

          switch (offer.basePlanId) {
            case 'weekly':
              weeklyPlan = product;
              break;

            case 'monthly':
              monthlyPlan = product;
              break;

            case 'yearly':
              yearlyPlan = product;
              break;
          }
        }
      }

      emit(
        SubscriptionLoaded(
          weeklyPlan: weeklyPlan,
          monthlyPlan: monthlyPlan,
          yearlyPlan: yearlyPlan,
        ),
      );
    } catch (e) {
      emit(
        SubscriptionError(
          e.toString(),
        ),
      );
    }
  }

  Future<void> buyPlan(ProductDetails product) async {
    try {
      emit(SubscriptionPurchasing());

      PurchaseParam purchaseParam;

      if (product is GooglePlayProductDetails) {
        purchaseParam = GooglePlayPurchaseParam(
          productDetails: product,
          offerToken: product.offerToken,
        );
      } else {
        purchaseParam = PurchaseParam(
          productDetails: product,
        );
      }

      await _inAppPurchase.buyNonConsumable(
        purchaseParam: purchaseParam,
      );
    } catch (e) {
      emit(
        SubscriptionError(
          e.toString(),
        ),
      );
    }
  }

  Future<void> restorePurchases() async {
    try {
      emit(SubscriptionRestoring());

      await _inAppPurchase.restorePurchases();
    } catch (e) {
      emit(
        SubscriptionError(
          e.toString(),
        ),
      );
    }
  }

  Future<void> _handlePurchaseUpdates(
      List<PurchaseDetails> purchases,
      ) async {
    for (final purchase in purchases) {
      switch (purchase.status) {
        case PurchaseStatus.pending:
          emit(SubscriptionPurchasePending());
          break;

        case PurchaseStatus.error:
          emit(
            SubscriptionError(
              purchase.error?.message ??
                  'Purchase failed',
            ),
          );
          break;

        case PurchaseStatus.purchased:
        case PurchaseStatus.restored:
        /*
           * الخطوة القادمة:
           *
           * أرسل هذا إلى Backend:
           *
           * purchase.verificationData.serverVerificationData
           *
           * ثم Backend يتحقق منه مع Google Play.
           */

          emit(
            SubscriptionPurchaseSuccess(
              purchase: purchase,
            ),
          );
          break;

        case PurchaseStatus.canceled:
          emit(SubscriptionPurchaseCanceled());
          break;
      }

      if (purchase.pendingCompletePurchase) {
        await _inAppPurchase.completePurchase(
          purchase,
        );
      }
    }
  }

  @override
  Future<void> close() async {
    await _purchaseSubscription?.cancel();
    return super.close();
  }
}