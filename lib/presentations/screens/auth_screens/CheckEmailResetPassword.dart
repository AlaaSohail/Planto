import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:plant_care/presentations/widgets/AuthTextField.dart';
import 'package:plant_care/presentations/widgets/MainButton.dart';

import '../../../controllers/cubit/user_cubit/user_cubit.dart';
import '../../../l10n/app_localizations.dart';
import '../../themes/app_button_theme.dart';
import '../../themes/app_colors.dart';
import '../../themes/app_theme.dart';
import '../../widgets/ContainerIcons.dart';
import 'VerifyCodeScreen.dart';

class CheckEmailResetPassword extends StatefulWidget {
  const CheckEmailResetPassword({
    super.key,
    this.email,
  });

  final String? email;

  @override
  State<CheckEmailResetPassword> createState() =>
      _CheckEmailResetPasswordState();
}

class _CheckEmailResetPasswordState
    extends State<CheckEmailResetPassword> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late final TextEditingController emailController =
  TextEditingController(text: widget.email ?? '');

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: AppTheme.plantCareAILogo(context),
        leading: AppTheme.backButton(context),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0).r,
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    localization.enterRegisteredEmailToResetPassword,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),

                  SizedBox(height: 20.h),

                  AuthTextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    obscureText: false,
                    hintText: localization.exampleEmail,
                    prefix: ContainerIcons(
                      icon: "assets/images/at.png",
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return localization.enterYourEmail;
                      }

                      if (!RegExp(
                        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                      ).hasMatch(value.trim())) {
                        return localization.enterValidEmail;
                      }

                      return null;
                    },
                  ),

                  SizedBox(height: 20.h),

                  MainButton(
                    content: localization.continueText,
                    onPressed: () async {
                      if (!_formKey.currentState!.validate()) {
                        return;
                      }

                      final email = emailController.text.trim();

                      context.read<UserCubit>().forgotPassword(email);

                      if (!mounted) return;

                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (_) => VerifyCodeScreen(
                            email: email,
                          ),
                        ),
                      );
                    },
                    mainAxisSize: MainAxisSize.max,
                    textStyle:
                    Theme.of(context).textTheme.headlineSmall,
                    buttonStyle:
                    AppButtonTheme.theme.style!.copyWith(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}