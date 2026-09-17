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

  /// No description provided for @weatherClearSky.
  ///
  /// In en, this message translates to:
  /// **'Clear Sky'**
  String get weatherClearSky;

  /// No description provided for @weatherMainlyClear.
  ///
  /// In en, this message translates to:
  /// **'Mainly Clear'**
  String get weatherMainlyClear;

  /// No description provided for @weatherMostlyClear.
  ///
  /// In en, this message translates to:
  /// **'Mostly Clear'**
  String get weatherMostlyClear;

  /// No description provided for @weatherOvercast.
  ///
  /// In en, this message translates to:
  /// **'Overcast'**
  String get weatherOvercast;

  /// No description provided for @weatherFog.
  ///
  /// In en, this message translates to:
  /// **'Fog'**
  String get weatherFog;

  /// No description provided for @weatherRimeFog.
  ///
  /// In en, this message translates to:
  /// **'Depositing Rime Fog'**
  String get weatherRimeFog;

  /// No description provided for @weatherLightDrizzle.
  ///
  /// In en, this message translates to:
  /// **'Light Drizzle'**
  String get weatherLightDrizzle;

  /// No description provided for @weatherModerateDrizzle.
  ///
  /// In en, this message translates to:
  /// **'Moderate Drizzle'**
  String get weatherModerateDrizzle;

  /// No description provided for @weatherDenseDrizzle.
  ///
  /// In en, this message translates to:
  /// **'Dense Drizzle'**
  String get weatherDenseDrizzle;

  /// No description provided for @weatherSlightRain.
  ///
  /// In en, this message translates to:
  /// **'Light Rain'**
  String get weatherSlightRain;

  /// No description provided for @weatherModerateRain.
  ///
  /// In en, this message translates to:
  /// **'Moderate Rain'**
  String get weatherModerateRain;

  /// No description provided for @weatherHeavyRain.
  ///
  /// In en, this message translates to:
  /// **'Heavy Rain'**
  String get weatherHeavyRain;

  /// No description provided for @weatherLightSnow.
  ///
  /// In en, this message translates to:
  /// **'Light Snow'**
  String get weatherLightSnow;

  /// No description provided for @weatherModerateSnow.
  ///
  /// In en, this message translates to:
  /// **'Moderate Snow'**
  String get weatherModerateSnow;

  /// No description provided for @weatherHeavySnow.
  ///
  /// In en, this message translates to:
  /// **'Heavy Snow'**
  String get weatherHeavySnow;

  /// No description provided for @weatherSnowGrains.
  ///
  /// In en, this message translates to:
  /// **'Snow Grains'**
  String get weatherSnowGrains;

  /// No description provided for @weatherSlightShowers.
  ///
  /// In en, this message translates to:
  /// **'Light Showers'**
  String get weatherSlightShowers;

  /// No description provided for @weatherModerateShowers.
  ///
  /// In en, this message translates to:
  /// **'Moderate Showers'**
  String get weatherModerateShowers;

  /// No description provided for @weatherViolentShowers.
  ///
  /// In en, this message translates to:
  /// **'Heavy Showers'**
  String get weatherViolentShowers;

  /// No description provided for @weatherThunderstorm.
  ///
  /// In en, this message translates to:
  /// **'Thunderstorm'**
  String get weatherThunderstorm;

  /// No description provided for @weatherHail.
  ///
  /// In en, this message translates to:
  /// **'Hail'**
  String get weatherHail;

  /// No description provided for @weatherUnknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get weatherUnknown;

  /// No description provided for @humidity.
  ///
  /// In en, this message translates to:
  /// **'Humidity'**
  String get humidity;

  /// No description provided for @wind.
  ///
  /// In en, this message translates to:
  /// **'Wind'**
  String get wind;

  /// No description provided for @km.
  ///
  /// In en, this message translates to:
  /// **'km'**
  String get km;

  /// No description provided for @hour.
  ///
  /// In en, this message translates to:
  /// **'h'**
  String get hour;

  /// No description provided for @aiChatOnlineExpert.
  ///
  /// In en, this message translates to:
  /// **'Online · Expert botanist AI'**
  String get aiChatOnlineExpert;

  /// No description provided for @aiChatHint.
  ///
  /// In en, this message translates to:
  /// **'Ask me anything...'**
  String get aiChatHint;

  /// No description provided for @planto.
  ///
  /// In en, this message translates to:
  /// **'Planto'**
  String get planto;

  /// No description provided for @appearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearance;

  /// No description provided for @chooseThemeDescription.
  ///
  /// In en, this message translates to:
  /// **'Choose how Planto looks on your device'**
  String get chooseThemeDescription;

  /// No description provided for @lightMode.
  ///
  /// In en, this message translates to:
  /// **'Light Mode'**
  String get lightMode;

  /// No description provided for @lightModeDescription.
  ///
  /// In en, this message translates to:
  /// **'Bright and clean appearance'**
  String get lightModeDescription;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// No description provided for @darkModeDescription.
  ///
  /// In en, this message translates to:
  /// **'Comfortable for low-light environments'**
  String get darkModeDescription;

  /// No description provided for @noTasksForToday.
  ///
  /// In en, this message translates to:
  /// **'No Tasks For Today'**
  String get noTasksForToday;

  /// No description provided for @contactUs.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get contactUs;

  /// No description provided for @helpCenter.
  ///
  /// In en, this message translates to:
  /// **'Help Center'**
  String get helpCenter;

  /// No description provided for @aboutApp.
  ///
  /// In en, this message translates to:
  /// **'About App'**
  String get aboutApp;

  /// No description provided for @support.
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get support;

  /// No description provided for @personalInfo.
  ///
  /// In en, this message translates to:
  /// **'Personal Information'**
  String get personalInfo;

  /// No description provided for @changePassword.
  ///
  /// In en, this message translates to:
  /// **'Update Password'**
  String get changePassword;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @privacyLastUpdate.
  ///
  /// In en, this message translates to:
  /// **'Last updated: September 17, 2026'**
  String get privacyLastUpdate;

  /// No description provided for @infoWeCollect.
  ///
  /// In en, this message translates to:
  /// **'1. Information We Collect'**
  String get infoWeCollect;

  /// No description provided for @howToUseTheInformation.
  ///
  /// In en, this message translates to:
  /// **'2. How We Use Information'**
  String get howToUseTheInformation;

  /// No description provided for @picturesAndPlantAnalysis.
  ///
  /// In en, this message translates to:
  /// **'3. Images and Plant Analysis'**
  String get picturesAndPlantAnalysis;

  /// No description provided for @geographicLocation.
  ///
  /// In en, this message translates to:
  /// **'4. Geographic Location'**
  String get geographicLocation;

  /// No description provided for @thirdPartyServices.
  ///
  /// In en, this message translates to:
  /// **'5. Third-Party Services'**
  String get thirdPartyServices;

  /// No description provided for @ads.
  ///
  /// In en, this message translates to:
  /// **'6. Advertising'**
  String get ads;

  /// No description provided for @subscriptionsAndPayments.
  ///
  /// In en, this message translates to:
  /// **'7. Subscriptions and Payments'**
  String get subscriptionsAndPayments;

  /// No description provided for @dataProtection.
  ///
  /// In en, this message translates to:
  /// **'8. Data Protection'**
  String get dataProtection;

  /// No description provided for @dataRetention.
  ///
  /// In en, this message translates to:
  /// **'9. Data Retention'**
  String get dataRetention;

  /// No description provided for @deleteAccountAndData.
  ///
  /// In en, this message translates to:
  /// **'10. Account and Data Deletion'**
  String get deleteAccountAndData;

  /// No description provided for @appPermissions.
  ///
  /// In en, this message translates to:
  /// **'11. App Permissions'**
  String get appPermissions;

  /// No description provided for @privacyPolicyChanges.
  ///
  /// In en, this message translates to:
  /// **'12. Changes to the Privacy Policy'**
  String get privacyPolicyChanges;

  /// No description provided for @contactUsPrivacy.
  ///
  /// In en, this message translates to:
  /// **'13. Contact Us'**
  String get contactUsPrivacy;

  /// No description provided for @contactUsPrivacyContent.
  ///
  /// In en, this message translates to:
  /// **'If you have any questions or requests regarding this Privacy Policy or your data, you can contact us at:\nEmail:\n3laa.sohail@gmail.com\nApp: Planto'**
  String get contactUsPrivacyContent;

  /// No description provided for @privacyPolicyChangesContent.
  ///
  /// In en, this message translates to:
  /// **'We may update this Privacy Policy from time to time to reflect changes in the application or legal requirements.\nThe updated version will be published within the application or on the official Privacy Policy page, along with an updated last revision date.'**
  String get privacyPolicyChangesContent;

  /// No description provided for @appPermissionsContent.
  ///
  /// In en, this message translates to:
  /// **'The application may request certain permissions, such as:\nCamera and Photos: To capture or select plant images.\nLocation: To obtain weather information and provide location-based services.\nNotifications: To send reminders and alerts related to plant care.\nYou can manage or revoke these permissions at any time through your device settings.'**
  String get appPermissionsContent;

  /// No description provided for @deleteAccountAndDataContent.
  ///
  /// In en, this message translates to:
  /// **'Users may request the deletion of their account and associated data.\nWhen an account is deleted, the personal data associated with it will be deleted or removed in accordance with applicable legal and technical requirements. Some information may be retained when legally required.'**
  String get deleteAccountAndDataContent;

  /// No description provided for @dataRetentionContent.
  ///
  /// In en, this message translates to:
  /// **'We may retain information for as long as your account remains active or as long as the information is necessary to provide the application\'s services and comply with legal and regulatory requirements.\nSome data may be removed when the account is deleted, except for information that must be retained for a specific period due to legal requirements or legitimate security interests.'**
  String get dataRetentionContent;

  /// No description provided for @dataProtectionContent.
  ///
  /// In en, this message translates to:
  /// **'We take appropriate technical and organizational measures to help protect user information against unauthorized access, use, modification, or unlawful disclosure.\nHowever, no method of electronic transmission or storage can be guaranteed to be 100% secure.'**
  String get dataProtectionContent;

  /// No description provided for @subscriptionsAndPaymentsContent.
  ///
  /// In en, this message translates to:
  /// **'The application may offer paid subscriptions, such as weekly, monthly, or yearly plans.\nPayments are processed through the applicable app store, such as Google Play or Apple App Store. Plant Care does not store your credit card numbers or banking payment information.'**
  String get subscriptionsAndPaymentsContent;

  /// No description provided for @adsContent.
  ///
  /// In en, this message translates to:
  /// **'Planto may display advertisements provided by third-party advertising networks. These services may use technical information, such as device information and advertising identifiers, to display advertisements and measure their performance in accordance with the user\'s privacy settings and consent.'**
  String get adsContent;

  /// No description provided for @thirdPartyServicesContent.
  ///
  /// In en, this message translates to:
  /// **'The application may rely on third-party services to provide certain features, such as:\nGoogle Sign-In services.\nNotification services.\nImage storage and processing services.\nData analysis or artificial intelligence services.\nAdvertising services.\nApp stores and subscription management services.\nThese third parties may process certain data according to their own privacy policies.'**
  String get thirdPartyServicesContent;

  /// No description provided for @geographicLocationContent.
  ///
  /// In en, this message translates to:
  /// **'Planto may request access to your device\'s location to provide weather information and location-based services.\nYour location will only be used after you grant the required permission through your device settings, and you can disable location access at any time through your phone settings.'**
  String get geographicLocationContent;

  /// No description provided for @picturesAndPlantAnalysisContent.
  ///
  /// In en, this message translates to:
  /// **'When using the plant analysis feature, the image you select may be sent to our servers or to third-party technology providers for processing and analysis.\nImages are used to provide plant identification, diagnose their condition, and provide appropriate recommendations.\nWe recommend that you do not upload images containing personal information or people unless necessary for using the service.'**
  String get picturesAndPlantAnalysisContent;

  /// No description provided for @howToUseTheInformationContent.
  ///
  /// In en, this message translates to:
  /// **'We use the information we collect to:\nCreate and manage user accounts.\nIdentify plants and analyze their condition using artificial intelligence technologies.\nProvide advice on watering, lighting, fertilizing, and plant care.\nProvide weather information related to the user\'s location.\nSend notifications and alerts related to plants and the application.\nImprove application performance and user experience.\nManage subscriptions and premium features.\nDetect errors and technical issues and prevent misuse of the service.'**
  String get howToUseTheInformationContent;

  /// No description provided for @infoWeCollectContent.
  ///
  /// In en, this message translates to:
  /// **'We may collect certain information necessary to provide the application\'s services, such as:\n\nAccount Information: Such as your name, email address, and login information.\nImages: Images that you upload or capture to analyze plants, identify them, or diagnose their condition.\nLocation Data: When you grant permission, we may use your approximate location to display weather information relevant to your area and improve plant care recommendations.\nDevice and App Information: Such as device type, operating system, and certain technical data related to your use of the application.\nSubscription Information: Information about your subscription status and selected plan. The application does not directly store your payment card information.'**
  String get infoWeCollectContent;

  /// No description provided for @privacyLastUpdateContent.
  ///
  /// In en, this message translates to:
  /// **'At Planto, we respect your privacy and are committed to protecting your personal information. This Privacy Policy explains how we collect, use, and protect information when you use the Planto application.'**
  String get privacyLastUpdateContent;

  /// No description provided for @helpCenterTitle.
  ///
  /// In en, this message translates to:
  /// **'Help Center'**
  String get helpCenterTitle;

  /// No description provided for @helpCenterIntro.
  ///
  /// In en, this message translates to:
  /// **'Welcome to the Planto Help Center.\nHere you can find answers to frequently asked questions and get help if you experience any issues while using the application.'**
  String get helpCenterIntro;

  /// No description provided for @accountAndLogin.
  ///
  /// In en, this message translates to:
  /// **'1. Account and Login'**
  String get accountAndLogin;

  /// No description provided for @accountAndLoginContent.
  ///
  /// In en, this message translates to:
  /// **'You can create an account using your email address or sign in with Google.\nIf you forget your password, use the \"Forgot Password?\" option and follow the instructions to reset it.\nIf you experience problems signing in, make sure your email address and password are correct and that you have an active internet connection.'**
  String get accountAndLoginContent;

  /// No description provided for @addPlantHelp.
  ///
  /// In en, this message translates to:
  /// **'2. Adding a Plant'**
  String get addPlantHelp;

  /// No description provided for @addPlantHelpContent.
  ///
  /// In en, this message translates to:
  /// **'You can manually add a new plant by entering its name, species, description, and adding a photo.\nYou can edit the plant information or update its photo later from the plant details page.'**
  String get addPlantHelpContent;

  /// No description provided for @aiPlantAnalysisHelp.
  ///
  /// In en, this message translates to:
  /// **'3. AI Plant Analysis'**
  String get aiPlantAnalysisHelp;

  /// No description provided for @aiPlantAnalysisHelpContent.
  ///
  /// In en, this message translates to:
  /// **'To capture or select an image of your plant, use the Plant Analysis feature.\nPlanto will analyze the image and provide information such as:\nPlant condition.\nPlant health score.\nPotential problems or diseases.\nWatering advice.\nLighting advice.\nFertilizing advice.\nCare recommendations.\nFor the best results, use a clear image of the plant with good lighting.'**
  String get aiPlantAnalysisHelpContent;

  /// No description provided for @weatherAndLocationHelp.
  ///
  /// In en, this message translates to:
  /// **'4. Weather and Location'**
  String get weatherAndLocationHelp;

  /// No description provided for @weatherAndLocationHelpContent.
  ///
  /// In en, this message translates to:
  /// **'Planto uses your location to provide weather information relevant to your area.\nIf weather information does not appear, make sure that:\nLocation services are enabled on your phone.\nPlant Care has permission to access your location.\nYour device is connected to the internet.'**
  String get weatherAndLocationHelpContent;

  /// No description provided for @notificationsHelp.
  ///
  /// In en, this message translates to:
  /// **'5. Notifications'**
  String get notificationsHelp;

  /// No description provided for @notificationsHelpContent.
  ///
  /// In en, this message translates to:
  /// **'Planto may send notifications and reminders related to Planto.\nYou can enable or disable notifications through the app settings or your device settings.'**
  String get notificationsHelpContent;

  /// No description provided for @subscriptionHelp.
  ///
  /// In en, this message translates to:
  /// **'6. Subscription'**
  String get subscriptionHelp;

  /// No description provided for @subscriptionHelpContent.
  ///
  /// In en, this message translates to:
  /// **'Some features may be available through a paid weekly, monthly, or yearly subscription.\nPayments and subscriptions are managed through Google Play or the Apple App Store, depending on your device.\nYou can manage or cancel your subscription through the subscription settings in your device\'s app store.'**
  String get subscriptionHelpContent;

  /// No description provided for @imageAnalysisProblem.
  ///
  /// In en, this message translates to:
  /// **'7. Image Analysis Problems'**
  String get imageAnalysisProblem;

  /// No description provided for @imageAnalysisProblemContent.
  ///
  /// In en, this message translates to:
  /// **'If the image is not analyzed correctly:\nMake sure the plant is clearly visible.\nAvoid dark or blurry images.\nTry taking a closer photo of the leaves or affected area.\nMake sure your device is connected to the internet.\nTry again using a different image.'**
  String get imageAnalysisProblemContent;

  /// No description provided for @deleteAccountHelp.
  ///
  /// In en, this message translates to:
  /// **'8. Delete Account'**
  String get deleteAccountHelp;

  /// No description provided for @deleteAccountHelpContent.
  ///
  /// In en, this message translates to:
  /// **'You can request deletion of your account and associated data through the account settings.\nPlease note that deleting your account may also delete your saved plants and other information associated with your account.'**
  String get deleteAccountHelpContent;

  /// No description provided for @frequentlyAskedQuestions.
  ///
  /// In en, this message translates to:
  /// **'9. Frequently Asked Questions'**
  String get frequentlyAskedQuestions;

  /// No description provided for @offlineQuestion.
  ///
  /// In en, this message translates to:
  /// **'Can I use the app without an internet connection?'**
  String get offlineQuestion;

  /// No description provided for @offlineAnswer.
  ///
  /// In en, this message translates to:
  /// **'Some saved information may be available offline, but features such as plant analysis and weather information require an internet connection.'**
  String get offlineAnswer;

  /// No description provided for @analysisAccuracyQuestion.
  ///
  /// In en, this message translates to:
  /// **'Is plant analysis always accurate?'**
  String get analysisAccuracyQuestion;

  /// No description provided for @analysisAccuracyAnswer.
  ///
  /// In en, this message translates to:
  /// **'Planto uses artificial intelligence technologies to provide the best possible analysis, but results may not always be 100% accurate.'**
  String get analysisAccuracyAnswer;

  /// No description provided for @existingPlantAnalysisQuestion.
  ///
  /// In en, this message translates to:
  /// **'Can I analyze a plant that I added previously?'**
  String get existingPlantAnalysisQuestion;

  /// No description provided for @existingPlantAnalysisAnswer.
  ///
  /// In en, this message translates to:
  /// **'Yes. You can open the plant and perform a new analysis to update its condition and care information.'**
  String get existingPlantAnalysisAnswer;

  /// No description provided for @plantImagesQuestion.
  ///
  /// In en, this message translates to:
  /// **'Does the app store plant images?'**
  String get plantImagesQuestion;

  /// No description provided for @plantImagesAnswer.
  ///
  /// In en, this message translates to:
  /// **'Plant images associated with your account may be stored to provide application features and display the plants you have added.'**
  String get plantImagesAnswer;

  /// No description provided for @contactSupport.
  ///
  /// In en, this message translates to:
  /// **'10. Contact Us'**
  String get contactSupport;

  /// No description provided for @contactSupportContent.
  ///
  /// In en, this message translates to:
  /// **'If you cannot find a solution to your problem, you can contact us at:\nEmail:\n3laa.sohail@gmail.com\nApp: Planto\nWe will use the information you send us only to help resolve your issue and improve the service.'**
  String get contactSupportContent;

  /// No description provided for @aboutAppIntro.
  ///
  /// In en, this message translates to:
  /// **'Planto is a smart application that helps you identify your plants, monitor their condition, and care for them easily using artificial intelligence technologies.'**
  String get aboutAppIntro;

  /// No description provided for @aboutAppWhatIs.
  ///
  /// In en, this message translates to:
  /// **'What is Planto?'**
  String get aboutAppWhatIs;

  /// No description provided for @aboutAppWhatIsContent.
  ///
  /// In en, this message translates to:
  /// **'Planto is designed to help plant lovers manage their plants and access useful information and recommendations to care for them and keep them healthy.'**
  String get aboutAppWhatIsContent;

  /// No description provided for @aboutAppFeatures.
  ///
  /// In en, this message translates to:
  /// **'App Features'**
  String get aboutAppFeatures;

  /// No description provided for @aboutAppFeaturesContent.
  ///
  /// In en, this message translates to:
  /// **'Identify plants using images.\nAnalyze plant health using artificial intelligence.\nDetect potential problems and diseases.\nGet watering, lighting, and fertilizing advice.\nSave and manage your plants in one place.\nView weather information based on your location.\nReceive plant care reminders and notifications.'**
  String get aboutAppFeaturesContent;

  /// No description provided for @aboutAppAI.
  ///
  /// In en, this message translates to:
  /// **'Artificial Intelligence'**
  String get aboutAppAI;

  /// No description provided for @aboutAppAIContent.
  ///
  /// In en, this message translates to:
  /// **'Planto uses artificial intelligence technologies to analyze plant images and provide information and care recommendations. Results may vary depending on image quality and the condition of the plant, so the information should be considered guidance and not a substitute for professional advice.'**
  String get aboutAppAIContent;

  /// No description provided for @aboutAppMission.
  ///
  /// In en, this message translates to:
  /// **'Our Mission'**
  String get aboutAppMission;

  /// No description provided for @aboutAppMissionContent.
  ///
  /// In en, this message translates to:
  /// **'Our goal is to make Planto simpler and easier and help users better understand their plants\' needs and make better care decisions.'**
  String get aboutAppMissionContent;

  /// No description provided for @aboutAppVersion.
  ///
  /// In en, this message translates to:
  /// **'App Version'**
  String get aboutAppVersion;

  /// No description provided for @aboutAppVersionContent.
  ///
  /// In en, this message translates to:
  /// **'You can find the current Planto version number in the application information or your device settings.'**
  String get aboutAppVersionContent;

  /// No description provided for @aboutAppContact.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get aboutAppContact;

  /// No description provided for @aboutAppContactContent.
  ///
  /// In en, this message translates to:
  /// **'If you have a suggestion, feedback, or experience a problem while using Planto, you can contact us at:\nEmail:\n3laa.sohail@gmail.com'**
  String get aboutAppContactContent;

  /// No description provided for @aboutAppCopyright.
  ///
  /// In en, this message translates to:
  /// **'© 2026 Planto. All rights reserved.'**
  String get aboutAppCopyright;

  /// No description provided for @deleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get deleteAccount;

  /// No description provided for @deleteAccountMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete your account? Your associated data will be deleted, and this action cannot be undone.'**
  String get deleteAccountMessage;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;
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
