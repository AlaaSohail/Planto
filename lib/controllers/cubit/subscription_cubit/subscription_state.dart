part of 'subscription_cubit.dart';

sealed class SubscriptionState {
  const SubscriptionState();
}

class SubscriptionInitial extends SubscriptionState {}

class SubscriptionLoading extends SubscriptionState {}

class SubscriptionLoaded extends SubscriptionState {
  final ProductDetails? weeklyPlan;
  final ProductDetails? monthlyPlan;
  final ProductDetails? yearlyPlan;

  const SubscriptionLoaded({
    required this.weeklyPlan,
    required this.monthlyPlan,
    required this.yearlyPlan,
  });
}

class SubscriptionPurchasing extends SubscriptionState {}

class SubscriptionPurchasePending extends SubscriptionState {}

class SubscriptionPurchaseSuccess
    extends SubscriptionState {
  final PurchaseDetails purchase;

  const SubscriptionPurchaseSuccess({
    required this.purchase,
  });
}

class SubscriptionPurchaseCanceled
    extends SubscriptionState {}

class SubscriptionRestoring
    extends SubscriptionState {}

class SubscriptionError extends SubscriptionState {
  final String message;

  const SubscriptionError(this.message);
}