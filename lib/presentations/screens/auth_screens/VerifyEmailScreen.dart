import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plant_care/presentations/screens/auth_screens/LoginScreen.dart';

import '../../../controllers/cubit/user_cubit/user_cubit.dart';
import '../../themes/app_button_theme.dart';
import '../../themes/app_theme.dart';
import '../../widgets/MainButton.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({super.key, required this.email});

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

    setState(() {
      _secondsRemaining = 60;
      _canResend = false;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        timer.cancel();

        setState(() {
          _canResend = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff7fbf5),
      appBar: AppBar(
        title: AppTheme.plantCareAILogo(),
        leading: AppTheme.backButton(context),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0.r),
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
                    text: "We've sent a verification link to ",
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  TextSpan(
                    text: widget.email,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              "Click the link in the email to verify your account and start growing with PlantCare AI.",
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 20.h),

            MainButton(
              onPressed: () {
                // await context.read<UserCubit>().verifyEmail(widget.email);
                // Navigator.pushReplacement(
                //   context,
                //   CupertinoPageRoute(builder: (context) => LoginScreen()),
                // );
              },
              content: "Email Verified",
              textStyle: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
              buttonStyle: AppButtonTheme.theme.style!.copyWith(),
              mainAxisSize: MainAxisSize.max,
            ),
            SizedBox(height: 20.h),

            Row(
              children: [
                TextButton(
                  onPressed: _secondsRemaining == 0
                      ? () {
                          context.read<UserCubit>().resendVerificationEmail(
                            widget.email,
                          );

                          _startResendTimer();
                        }
                      : null,
                  child: Text(
                    _secondsRemaining == 0
                        ? 'Didn\'t receive the email?'
                        : 'Resend email',
                  ),
                ),

                if (_secondsRemaining > 0)
                  Text(
                    '$_secondsRemaining seconds',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
