import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../controllers/cubit/user_cubit/user_cubit.dart';
import '../../../l10n/app_localizations.dart';
import '../../themes/app_button_theme.dart';
import '../../themes/app_theme.dart';
import '../../widgets/MainButton.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({
    super.key,
    required this.email,
  });

  final String email;

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  Timer? _timer;

  int _secondsRemaining = 60;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    _startResendTimer();
  }

  void _startResendTimer() {
    _timer?.cancel();

    if (mounted) {
      setState(() {
        _secondsRemaining = 60;
        _canResend = false;
      });
    }

    _timer = Timer.periodic(
      const Duration(seconds: 1),
          (timer) {
        if (!mounted) {
          timer.cancel();
          return;
        }

        if (_secondsRemaining > 1) {
          setState(() {
            _secondsRemaining--;
          });
        } else {
          timer.cancel();

          setState(() {
            _secondsRemaining = 0;
            _canResend = true;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: AppTheme.plantCareAILogo(context),
        leading: AppTheme.backButton(context),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        elevation: 0,        titleSpacing: 0,

      ),
      body: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Image.asset(
                'assets/images/emailVerify.png',
                width: 200.w,
                height: 200.h,
              ),
            ),

            SizedBox(height: 20.h),

            RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.bodyMedium,
                children: [
                  TextSpan(
                    text: localization.verificationLinkSent,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  TextSpan(
                    text: widget.email,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),

            SizedBox(height: 20.h),

            Text(
              localization.verifyEmailDescription,
              style: Theme.of(context).textTheme.bodyLarge,
            ),

            SizedBox(height: 20.h),

            MainButton(
              onPressed: () {
                // يمكنك وضع التحقق من البريد هنا لاحقًا.
                //
                // context.read<UserCubit>().verifyEmail(widget.email);
              },
              content: localization.emailVerified,
              textStyle: Theme.of(context).textTheme.headlineSmall,
              buttonStyle: AppButtonTheme.theme.style!.copyWith(),
              mainAxisSize: MainAxisSize.max,
            ),

            SizedBox(height: 20.h),

            Row(
              children: [
                TextButton(
                  onPressed: _canResend
                      ? () {
                    context
                        .read<UserCubit>()
                        .resendVerificationEmail(
                      widget.email,
                    );

                    _startResendTimer();
                  }
                      : null,
                  child: Text(
                    _canResend
                        ? localization.didntReceiveEmail
                        : localization.resendEmail,
                  ),
                ),

                if (!_canResend) ...[
                  SizedBox(width: 8.w),
                  Text(
                    localization.secondsRemaining(
                      _secondsRemaining,
                    ),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}