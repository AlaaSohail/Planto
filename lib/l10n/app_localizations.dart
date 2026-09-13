import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';
import 'app_localizations_he.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
    Locale('he'),
  ];

  /// No description provided for @welcomeGardenReimagined.
  ///
  /// In en, this message translates to:
  /// **'🌿 Your garden, reimagined'**
  String get welcomeGardenReimagined;

  /// No description provided for @welcomeGrowSmarter.
  ///
  /// In en, this message translates to:
  /// **'Grow smarter'**
  String get welcomeGrowSmarter;

  /// No description provided for @welcomeWithAI.
  ///
  /// In en, this message translates to:
  /// **'with AI'**
  String get welcomeWithAI;

  /// No description provided for @welcomeDescription.
  ///
  /// In en, this message translates to:
  /// **'Identify, diagnose, and care for your plants with the power of artificial intelligence. Join 2M+ plant lovers.'**
  String get welcomeDescription;

  /// No description provided for @welcomeCreateFreeAccount.
  ///
  /// In en, this message translates to:
  /// **'Create Free Account'**
  String get welcomeCreateFreeAccount;

  /// No description provided for @welcomeSignIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get welcomeSignIn;

  /// No description provided for @welcomePlants.
  ///
  /// In en, this message translates to:
  /// **'Plants'**
  String get welcomePlants;

  /// No description provided for @welcomeUsers.
  ///
  /// In en, this message translates to:
  /// **'Users'**
  String get welcomeUsers;

  /// No description provided for @welcomeRatings.
  ///
  /// In en, this message translates to:
  /// **'Ratings'**
  String get welcomeRatings;

  /// No description provided for @welcomePlantsValue.
  ///
  /// In en, this message translates to:
  /// **'100'**
  String get welcomePlantsValue;

  /// No description provided for @welcomePlantsUnit.
  ///
  /// In en, this message translates to:
  /// **'K+'**
  String get welcomePlantsUnit;

  /// No description provided for @welcomeUsersValue.
  ///
  /// In en, this message translates to:
  /// **'2'**
  String get welcomeUsersValue;

  /// No description provided for @welcomeUsersUnit.
  ///
  /// In en, this message translates to:
  /// **'M+'**
  String get welcomeUsersUnit;

  /// No description provided for @welcomeRatingsValue.
  ///
  /// In en, this message translates to:
  /// **'4.9'**
  String get welcomeRatingsValue;

  /// No description provided for @welcomeRatingsUnit.
  ///
  /// In en, this message translates to:
  /// **'⭐'**
  String get welcomeRatingsUnit;

  /// No description provided for @onboardingSkip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get onboardingSkip;

  /// No description provided for @onboardingIdentifyPlantsTitle.
  ///
  /// In en, this message translates to:
  /// **'Identify Plants Instantly'**
  String get onboardingIdentifyPlantsTitle;

  /// No description provided for @onboardingIdentifyPlantsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Point your camera at any plant and get instant identification with detailed care instructions in seconds.'**
  String get onboardingIdentifyPlantsSubtitle;

  /// No description provided for @onboardingSmartCareTitle.
  ///
  /// In en, this message translates to:
  /// **'Smart Plant Care'**
  String get onboardingSmartCareTitle;

  /// No description provided for @onboardingSmartCareSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Get personalized care recommendations based on your plant and its needs.'**
  String get onboardingSmartCareSubtitle;

  /// No description provided for @onboardingAiDoctorTitle.
  ///
  /// In en, this message translates to:
  /// **'AI Plant Doctor'**
  String get onboardingAiDoctorTitle;

  /// No description provided for @onboardingAiDoctorSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Diagnose diseases, pests, and deficiencies with our advanced AI and get expert treatment recommendations instantly.'**
  String get onboardingAiDoctorSubtitle;

  /// No description provided for @onboardingGetStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get onboardingGetStarted;

  /// No description provided for @onboardingNext.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get onboardingNext;

  /// No description provided for @loginWelcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome back'**
  String get loginWelcomeBack;

  /// No description provided for @loginSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in to continue growing'**
  String get loginSubtitle;

  /// No description provided for @loginEmailAddress.
  ///
  /// In en, this message translates to:
  /// **'EMAIL ADDRESS'**
  String get loginEmailAddress;

  /// No description provided for @loginEnterEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get loginEnterEmail;

  /// No description provided for @loginValidEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter valid email'**
  String get loginValidEmail;

  /// No description provided for @loginPassword.
  ///
  /// In en, this message translates to:
  /// **'PASSWORD'**
  String get loginPassword;

  /// No description provided for @loginEnterPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get loginEnterPassword;

  /// No description provided for @loginPleaseEnterPassword.
  ///
  /// In en, this message translates to:
  /// **'Please enter your password'**
  String get loginPleaseEnterPassword;

  /// No description provided for @loginPasswordMinLength.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters'**
  String get loginPasswordMinLength;

  /// No description provided for @loginForgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get loginForgotPassword;

  /// No description provided for @loginSigningIn.
  ///
  /// In en, this message translates to:
  /// **'Signing in...'**
  String get loginSigningIn;

  /// No description provided for @loginSignIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get loginSignIn;

  /// No description provided for @loginOrContinueWith.
  ///
  /// In en, this message translates to:
  /// **'Or continue with'**
  String get loginOrContinueWith;

  /// No description provided for @loginNoAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get loginNoAccount;

  /// No description provided for @loginSignUpFree.
  ///
  /// In en, this message translates to:
  /// **'Sign Up Free'**
  String get loginSignUpFree;

  /// No description provided for @registerJoinPlanto.
  ///
  /// In en, this message translates to:
  /// **'Join Planto'**
  String get registerJoinPlanto;

  /// No description provided for @registerSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Create an account to start growing'**
  String get registerSubtitle;

  /// No description provided for @registerFullName.
  ///
  /// In en, this message translates to:
  /// **'FULL NAME'**
  String get registerFullName;

  /// No description provided for @registerEnterName.
  ///
  /// In en, this message translates to:
  /// **'Enter your name'**
  String get registerEnterName;

  /// No description provided for @registerEmailAddress.
  ///
  /// In en, this message translates to:
  /// **'EMAIL ADDRESS'**
  String get registerEmailAddress;

  /// No description provided for @registerEnterEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get registerEnterEmail;

  /// No description provided for @registerValidEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter valid email'**
  String get registerValidEmail;

  /// No description provided for @registerPassword.
  ///
  /// In en, this message translates to:
  /// **'PASSWORD'**
  String get registerPassword;

  /// No description provided for @registerMinCharacters.
  ///
  /// In en, this message translates to:
  /// **'Min 8 characters'**
  String get registerMinCharacters;

  /// No description provided for @registerPasswordMinLength.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters'**
  String get registerPasswordMinLength;

  /// No description provided for @registerPleaseEnterPassword.
  ///
  /// In en, this message translates to:
  /// **'Please enter your password'**
  String get registerPleaseEnterPassword;

  /// No description provided for @registerConfirmPassword.
  ///
  /// In en, this message translates to:
  /// **'CONFIRM PASSWORD'**
  String get registerConfirmPassword;

  /// No description provided for @registerConfirmPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get registerConfirmPasswordHint;

  /// No description provided for @registerPasswordsNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get registerPasswordsNotMatch;

  /// No description provided for @registerTermsText.
  ///
  /// In en, this message translates to:
  /// **'By creating an account, you agree to our'**
  String get registerTermsText;

  /// No description provided for @registerTermsOfService.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get registerTermsOfService;

  /// No description provided for @registerAnd.
  ///
  /// In en, this message translates to:
  /// **'and'**
  String get registerAnd;

  /// No description provided for @registerPrivacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get registerPrivacyPolicy;

  /// No description provided for @registerSigningUp.
  ///
  /// In en, this message translates to:
  /// **'Signing Up...'**
  String get registerSigningUp;

  /// No description provided for @registerSignUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get registerSignUp;

  /// No description provided for @registerOrContinueWith.
  ///
  /// In en, this message translates to:
  /// **'Or continue with'**
  String get registerOrContinueWith;

  /// No description provided for @registerAlreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get registerAlreadyHaveAccount;

  /// No description provided for @registerSignIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get registerSignIn;

  /// No description provided for @registerSearch.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get registerSearch;

  /// No description provided for @registerStartTyping.
  ///
  /// In en, this message translates to:
  /// **'Start typing to search'**
  String get registerStartTyping;

  /// No description provided for @registerFillAllFields.
  ///
  /// In en, this message translates to:
  /// **'Please fill all fields'**
  String get registerFillAllFields;

  /// No description provided for @enterRegisteredEmailToResetPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter your registered email to reset your password.'**
  String get enterRegisteredEmailToResetPassword;

  /// No description provided for @exampleEmail.
  ///
  /// In en, this message translates to:
  /// **'example@alaasohail.com'**
  String get exampleEmail;

  /// No description provided for @enterYourEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get enterYourEmail;

  /// No description provided for @enterValidEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter valid email'**
  String get enterValidEmail;

  /// No description provided for @continueText.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueText;

  /// No description provided for @updatePassword.
  ///
  /// In en, this message translates to:
  /// **'Update Password'**
  String get updatePassword;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @min8Characters.
  ///
  /// In en, this message translates to:
  /// **'Min 8 characters'**
  String get min8Characters;

  /// No description provided for @pleaseEnterYourPassword.
  ///
  /// In en, this message translates to:
  /// **'Please enter your password'**
  String get pleaseEnterYourPassword;

  /// No description provided for @passwordMustBeAtLeast8Characters.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters'**
  String get passwordMustBeAtLeast8Characters;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// No description provided for @confirmPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get confirmPasswordHint;

  /// No description provided for @passwordsDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsDoNotMatch;

  /// No description provided for @update.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update;

  /// No description provided for @invalidResetToken.
  ///
  /// In en, this message translates to:
  /// **'Invalid reset token'**
  String get invalidResetToken;

  /// No description provided for @resetPassword.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get resetPassword;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @resend.
  ///
  /// In en, this message translates to:
  /// **'Resend'**
  String get resend;

  /// No description provided for @pleaseEnterAValidCode.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid code'**
  String get pleaseEnterAValidCode;

  /// No description provided for @verificationLinkSent.
  ///
  /// In en, this message translates to:
  /// **'We\'ve sent a verification link to '**
  String get verificationLinkSent;

  /// No description provided for @verifyEmailDescription.
  ///
  /// In en, this message translates to:
  /// **'Click the link in the email to verify your account and start growing with PlantCare AI.'**
  String get verifyEmailDescription;

  /// No description provided for @emailVerified.
  ///
  /// In en, this message translates to:
  /// **'Email Verified'**
  String get emailVerified;

  /// No description provided for @didntReceiveEmail.
  ///
  /// In en, this message translates to:
  /// **'Didn\'t receive the email?'**
  String get didntReceiveEmail;

  /// No description provided for @resendEmail.
  ///
  /// In en, this message translates to:
  /// **'Resend email'**
  String get resendEmail;

  /// No description provided for @secondsRemaining.
  ///
  /// In en, this message translates to:
  /// **'{seconds} seconds'**
  String secondsRemaining(int seconds);

  /// No description provided for @goodMorning.
  ///
  /// In en, this message translates to:
  /// **'Good Morning'**
  String get goodMorning;

  /// No description provided for @goodAfternoon.
  ///
  /// In en, this message translates to:
  /// **'Good Afternoon'**
  String get goodAfternoon;

  /// No description provided for @goodEvening.
  ///
  /// In en, this message translates to:
  /// **'Good Evening'**
  String get goodEvening;

  /// No description provided for @scan.
  ///
  /// In en, this message translates to:
  /// **'Scan'**
  String get scan;

  /// No description provided for @doctorAI.
  ///
  /// In en, this message translates to:
  /// **'Doctor AI'**
  String get doctorAI;

  /// No description provided for @community.
  ///
  /// In en, this message translates to:
  /// **'Community'**
  String get community;

  /// No description provided for @careTips.
  ///
  /// In en, this message translates to:
  /// **'Care Tips'**
  String get careTips;

  /// No description provided for @gardenHealth.
  ///
  /// In en, this message translates to:
  /// **'Garden\nHealth'**
  String get gardenHealth;

  /// No description provided for @aiPlantDoctor.
  ///
  /// In en, this message translates to:
  /// **'AI Plant Doctor'**
  String get aiPlantDoctor;

  /// No description provided for @aiPlantDoctorDescription.
  ///
  /// In en, this message translates to:
  /// **'Your plant may need more attention. Tap to learn more →'**
  String get aiPlantDoctorDescription;

  /// No description provided for @quickActions.
  ///
  /// In en, this message translates to:
  /// **'Quick Actions'**
  String get quickActions;

  /// No description provided for @myPlants.
  ///
  /// In en, this message translates to:
  /// **'My Plants'**
  String get myPlants;

  /// No description provided for @seeAll.
  ///
  /// In en, this message translates to:
  /// **'See all'**
  String get seeAll;

  /// No description provided for @noPlantsFound.
  ///
  /// In en, this message translates to:
  /// **'No Plants Found'**
  String get noPlantsFound;

  /// No description provided for @addPlant.
  ///
  /// In en, this message translates to:
  /// **'Add Plant'**
  String get addPlant;

  /// No description provided for @todaysTasks.
  ///
  /// In en, this message translates to:
  /// **'Today\'s Tasks'**
  String get todaysTasks;

  /// No description provided for @tasksCount.
  ///
  /// In en, this message translates to:
  /// **'{count} Tasks'**
  String tasksCount(int count);

  /// No description provided for @wateringProgress.
  ///
  /// In en, this message translates to:
  /// **'Watering Progress'**
  String get wateringProgress;

  /// No description provided for @dailyTips.
  ///
  /// In en, this message translates to:
  /// **'Daily Tips'**
  String get dailyTips;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @loadingLocation.
  ///
  /// In en, this message translates to:
  /// **'Loading location'**
  String get loadingLocation;

  /// No description provided for @unableToLoadDailyTip.
  ///
  /// In en, this message translates to:
  /// **'Unable to load daily tip'**
  String get unableToLoadDailyTip;

  /// No description provided for @rotateFiddleLeafFig.
  ///
  /// In en, this message translates to:
  /// **'Rotate Fiddle Leaf Fig'**
  String get rotateFiddleLeafFig;

  /// No description provided for @today8AM.
  ///
  /// In en, this message translates to:
  /// **'Today, 8 AM'**
  String get today8AM;

  /// No description provided for @plantError.
  ///
  /// In en, this message translates to:
  /// **'Plant Error: {message}'**
  String plantError(String message);

  /// No description provided for @whatsOnYourMind.
  ///
  /// In en, this message translates to:
  /// **'What\'s on your mind?'**
  String get whatsOnYourMind;

  /// No description provided for @deploy.
  ///
  /// In en, this message translates to:
  /// **'Post'**
  String get deploy;

  /// No description provided for @addNewPost.
  ///
  /// In en, this message translates to:
  /// **'Add a new post'**
  String get addNewPost;

  /// No description provided for @noPostsFound.
  ///
  /// In en, this message translates to:
  /// **'No Posts Found'**
  String get noPostsFound;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'FULL NAME'**
  String get fullName;

  /// No description provided for @pleaseEnterYourName.
  ///
  /// In en, this message translates to:
  /// **'Please enter your name'**
  String get pleaseEnterYourName;

  /// No description provided for @enterYourName.
  ///
  /// In en, this message translates to:
  /// **'Enter your name'**
  String get enterYourName;

  /// No description provided for @emailAddress.
  ///
  /// In en, this message translates to:
  /// **'EMAIL ADDRESS'**
  String get emailAddress;

  /// No description provided for @emailExample.
  ///
  /// In en, this message translates to:
  /// **'example@alaasohail.com'**
  String get emailExample;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'PHONE NUMBER'**
  String get phoneNumber;

  /// No description provided for @enterPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter phone number'**
  String get enterPhoneNumber;

  /// No description provided for @saveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get saveChanges;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @plants.
  ///
  /// In en, this message translates to:
  /// **'Plants'**
  String get plants;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @pushNotifications.
  ///
  /// In en, this message translates to:
  /// **'Push Notifications'**
  String get pushNotifications;

  /// No description provided for @currentPassword.
  ///
  /// In en, this message translates to:
  /// **'CURRENT PASSWORD'**
  String get currentPassword;

  /// No description provided for @newPassword.
  ///
  /// In en, this message translates to:
  /// **'NEW PASSWORD'**
  String get newPassword;

  /// No description provided for @newPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'New password'**
  String get newPasswordHint;

  /// No description provided for @addComment.
  ///
  /// In en, this message translates to:
  /// **'Add a comment'**
  String get addComment;

  /// No description provided for @proMember.
  ///
  /// In en, this message translates to:
  /// **'Pro Member'**
  String get proMember;

  /// No description provided for @plantoPro.
  ///
  /// In en, this message translates to:
  /// **'Planto Pro'**
  String get plantoPro;

  /// No description provided for @unlimitedAIScansAdvancedAnalytics.
  ///
  /// In en, this message translates to:
  /// **'Unlimited AI scans · Advanced analytics'**
  String get unlimitedAIScansAdvancedAnalytics;

  /// No description provided for @account.
  ///
  /// In en, this message translates to:
  /// **'ACCOUNT'**
  String get account;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @app.
  ///
  /// In en, this message translates to:
  /// **'APP'**
  String get app;

  /// No description provided for @premiumPlan.
  ///
  /// In en, this message translates to:
  /// **'Premium Plan'**
  String get premiumPlan;

  /// No description provided for @preferences.
  ///
  /// In en, this message translates to:
  /// **'Preferences'**
  String get preferences;

  /// No description provided for @signOut.
  ///
  /// In en, this message translates to:
  /// **'Sign Out'**
  String get signOut;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @upgradePlan.
  ///
  /// In en, this message translates to:
  /// **'Upgrade Plan'**
  String get upgradePlan;

  /// No description provided for @unlockYourFull.
  ///
  /// In en, this message translates to:
  /// **'Unlock Your Full '**
  String get unlockYourFull;

  /// No description provided for @gardenPotential.
  ///
  /// In en, this message translates to:
  /// **'Garden Potential'**
  String get gardenPotential;

  /// No description provided for @joinPlantLoversPro.
  ///
  /// In en, this message translates to:
  /// **'Join 50,000+ plant lovers who upgraded to Pro'**
  String get joinPlantLoversPro;

  /// No description provided for @free.
  ///
  /// In en, this message translates to:
  /// **'Free'**
  String get free;

  /// No description provided for @currentPlan.
  ///
  /// In en, this message translates to:
  /// **'Current Plan'**
  String get currentPlan;

  /// No description provided for @forever.
  ///
  /// In en, this message translates to:
  /// **'Forever'**
  String get forever;

  /// No description provided for @fivePlantIdentificationsPerMonth.
  ///
  /// In en, this message translates to:
  /// **'5 plant identifications/month'**
  String get fivePlantIdentificationsPerMonth;

  /// No description provided for @basicCareReminders.
  ///
  /// In en, this message translates to:
  /// **'Basic care reminders'**
  String get basicCareReminders;

  /// No description provided for @plantLibraryAccess.
  ///
  /// In en, this message translates to:
  /// **'Plant library access'**
  String get plantLibraryAccess;

  /// No description provided for @communityAccess.
  ///
  /// In en, this message translates to:
  /// **'Community access'**
  String get communityAccess;

  /// No description provided for @premium.
  ///
  /// In en, this message translates to:
  /// **'Premium'**
  String get premium;

  /// No description provided for @startFreeTrial.
  ///
  /// In en, this message translates to:
  /// **'Start Free Trial'**
  String get startFreeTrial;

  /// No description provided for @perMonth.
  ///
  /// In en, this message translates to:
  /// **'Per month'**
  String get perMonth;

  /// No description provided for @unlimitedAIIdentifications.
  ///
  /// In en, this message translates to:
  /// **'Unlimited AI identifications'**
  String get unlimitedAIIdentifications;

  /// No description provided for @aiPlantDoctorUnlimited.
  ///
  /// In en, this message translates to:
  /// **'AI Plant Doctor unlimited'**
  String get aiPlantDoctorUnlimited;

  /// No description provided for @smartCareSchedules.
  ///
  /// In en, this message translates to:
  /// **'Smart care schedules'**
  String get smartCareSchedules;

  /// No description provided for @advancedPlantAnalytics.
  ///
  /// In en, this message translates to:
  /// **'Advanced plant analytics'**
  String get advancedPlantAnalytics;

  /// No description provided for @prioritySupport.
  ///
  /// In en, this message translates to:
  /// **'Priority support'**
  String get prioritySupport;

  /// No description provided for @noAds.
  ///
  /// In en, this message translates to:
  /// **'No Ads'**
  String get noAds;

  /// No description provided for @plantName.
  ///
  /// In en, this message translates to:
  /// **'Plant Name'**
  String get plantName;

  /// No description provided for @enterPlantName.
  ///
  /// In en, this message translates to:
  /// **'Enter plant name'**
  String get enterPlantName;

  /// No description provided for @pleaseEnterPlantName.
  ///
  /// In en, this message translates to:
  /// **'Please enter plant name'**
  String get pleaseEnterPlantName;

  /// No description provided for @species.
  ///
  /// In en, this message translates to:
  /// **'Species'**
  String get species;

  /// No description provided for @enterPlantSpecies.
  ///
  /// In en, this message translates to:
  /// **'Enter plant species'**
  String get enterPlantSpecies;

  /// No description provided for @pleaseEnterPlantSpecies.
  ///
  /// In en, this message translates to:
  /// **'Please enter plant species'**
  String get pleaseEnterPlantSpecies;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @enterPlantDescription.
  ///
  /// In en, this message translates to:
  /// **'Enter plant description'**
  String get enterPlantDescription;

  /// No description provided for @pleaseFillAllFields.
  ///
  /// In en, this message translates to:
  /// **'Please fill all fields'**
  String get pleaseFillAllFields;

  /// No description provided for @yourCollection.
  ///
  /// In en, this message translates to:
  /// **'Your Collection'**
  String get yourCollection;

  /// No description provided for @searchPlants.
  ///
  /// In en, this message translates to:
  /// **'Search plants...'**
  String get searchPlants;

  /// No description provided for @noPlantsMatchSearch.
  ///
  /// In en, this message translates to:
  /// **'No plants match your search'**
  String get noPlantsMatchSearch;

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @healthy.
  ///
  /// In en, this message translates to:
  /// **'Healthy'**
  String get healthy;

  /// No description provided for @notAnalyzed.
  ///
  /// In en, this message translates to:
  /// **'Not Analyzed'**
  String get notAnalyzed;

  /// No description provided for @diseased.
  ///
  /// In en, this message translates to:
  /// **'Diseased'**
  String get diseased;

  /// No description provided for @areYouSureDeletePlant.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this plant?'**
  String get areYouSureDeletePlant;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @deletePlant.
  ///
  /// In en, this message translates to:
  /// **'Delete Plant'**
  String get deletePlant;

  /// No description provided for @unknownPlant.
  ///
  /// In en, this message translates to:
  /// **'Unknown plant'**
  String get unknownPlant;

  /// No description provided for @unknownSpecies.
  ///
  /// In en, this message translates to:
  /// **'Unknown species'**
  String get unknownSpecies;

  /// No description provided for @confidencePercent.
  ///
  /// In en, this message translates to:
  /// **'{percent}% Confidence'**
  String confidencePercent(String percent);

  /// No description provided for @healthScore.
  ///
  /// In en, this message translates to:
  /// **'Health Score'**
  String get healthScore;

  /// No description provided for @notAvailable.
  ///
  /// In en, this message translates to:
  /// **'N/A'**
  String get notAvailable;

  /// No description provided for @noRecommendationAvailable.
  ///
  /// In en, this message translates to:
  /// **'No recommendation available'**
  String get noRecommendationAvailable;

  /// No description provided for @disease.
  ///
  /// In en, this message translates to:
  /// **'Disease'**
  String get disease;

  /// No description provided for @noDiseaseAnalysisAvailable.
  ///
  /// In en, this message translates to:
  /// **'No disease analysis available'**
  String get noDiseaseAnalysisAvailable;

  /// No description provided for @fertilize.
  ///
  /// In en, this message translates to:
  /// **'Fertilize'**
  String get fertilize;

  /// No description provided for @noFertilizerAdviceAvailable.
  ///
  /// In en, this message translates to:
  /// **'No fertilizer advice available'**
  String get noFertilizerAdviceAvailable;

  /// No description provided for @water.
  ///
  /// In en, this message translates to:
  /// **'Water'**
  String get water;

  /// No description provided for @wateringInstructions.
  ///
  /// In en, this message translates to:
  /// **'Watering Instructions'**
  String get wateringInstructions;

  /// No description provided for @noWateringAdviceAvailable.
  ///
  /// In en, this message translates to:
  /// **'No watering advice available'**
  String get noWateringAdviceAvailable;

  /// No description provided for @sunlight.
  ///
  /// In en, this message translates to:
  /// **'Sunlight'**
  String get sunlight;

  /// No description provided for @sunlightInstructions.
  ///
  /// In en, this message translates to:
  /// **'Sunlight Instructions'**
  String get sunlightInstructions;

  /// No description provided for @noSunlightAdviceAvailable.
  ///
  /// In en, this message translates to:
  /// **'No sunlight advice available'**
  String get noSunlightAdviceAvailable;

  /// No description provided for @analyzePlant.
  ///
  /// In en, this message translates to:
  /// **'Analyze Plant'**
  String get analyzePlant;

  /// No description provided for @analyzingPlantWithAI.
  ///
  /// In en, this message translates to:
  /// **'Analyzing Your Plant with AI...'**
  String get analyzingPlantWithAI;

  /// No description provided for @savePlant.
  ///
  /// In en, this message translates to:
  /// **'Save Plant'**
  String get savePlant;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en', 'he'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
    case 'he':
      return AppLocalizationsHe();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
