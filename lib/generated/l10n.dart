// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name =
        (locale.countryCode?.isEmpty ?? false)
            ? locale.languageCode
            : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Skip`
  String get skipButton {
    return Intl.message('Skip', name: 'skipButton', desc: '', args: []);
  }

  /// `Title`
  String get checkCardTitle {
    return Intl.message('Title', name: 'checkCardTitle', desc: '', args: []);
  }

  /// `Description`
  String get checkCardDescription {
    return Intl.message(
      'Description',
      name: 'checkCardDescription',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settingsOption {
    return Intl.message('Settings', name: 'settingsOption', desc: '', args: []);
  }

  /// `Personal Information`
  String get personalInfoLabel {
    return Intl.message(
      'Personal Information',
      name: 'personalInfoLabel',
      desc: '',
      args: [],
    );
  }

  /// `Information`
  String get personalInfoInfo {
    return Intl.message(
      'Information',
      name: 'personalInfoInfo',
      desc: '',
      args: [],
    );
  }

  /// `See All`
  String get seeAll {
    return Intl.message('See All', name: 'seeAll', desc: '', args: []);
  }

  /// `Get Started`
  String get getStarted {
    return Intl.message('Get Started', name: 'getStarted', desc: '', args: []);
  }

  /// `Order Now`
  String get orderNow {
    return Intl.message('Order Now', name: 'orderNow', desc: '', args: []);
  }

  /// `Welcome to Allo Services!`
  String get welcomeTitle {
    return Intl.message(
      'Welcome to Allo Services!',
      name: 'welcomeTitle',
      desc: '',
      args: [],
    );
  }

  /// `Discover a world of services tailored to your needs. Choose the best options with just a few clicks and enjoy a seamless and simple experience with our app.`
  String get welcomeSubtitle {
    return Intl.message(
      'Discover a world of services tailored to your needs. Choose the best options with just a few clicks and enjoy a seamless and simple experience with our app.',
      name: 'welcomeSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Explore Our Services`
  String get exploreServicesTitle {
    return Intl.message(
      'Explore Our Services',
      name: 'exploreServicesTitle',
      desc: '',
      args: [],
    );
  }

  /// `Browse a wide range of services, each offering specialized sub-services to give you exactly what you're looking for. Find the perfect solution in a few steps.`
  String get exploreServicesSubtitle {
    return Intl.message(
      'Browse a wide range of services, each offering specialized sub-services to give you exactly what you\'re looking for. Find the perfect solution in a few steps.',
      name: 'exploreServicesSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Start Today`
  String get startTodayTitle {
    return Intl.message(
      'Start Today',
      name: 'startTodayTitle',
      desc: '',
      args: [],
    );
  }

  /// `Sign up and start choosing services right away! Join our community and benefit from personalized recommendations, exclusive offers, and more.`
  String get startTodaySubtitle {
    return Intl.message(
      'Sign up and start choosing services right away! Join our community and benefit from personalized recommendations, exclusive offers, and more.',
      name: 'startTodaySubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get homeLabel {
    return Intl.message('Home', name: 'homeLabel', desc: '', args: []);
  }

  /// `Categories`
  String get categoriesLabel {
    return Intl.message(
      'Categories',
      name: 'categoriesLabel',
      desc: '',
      args: [],
    );
  }

  /// `History`
  String get historyLabel {
    return Intl.message('History', name: 'historyLabel', desc: '', args: []);
  }

  /// `Select Language`
  String get selectLanguage {
    return Intl.message(
      'Select Language',
      name: 'selectLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Languages`
  String get languageLabel {
    return Intl.message('Languages', name: 'languageLabel', desc: '', args: []);
  }

  /// `Dark Mode`
  String get darkModeLabel {
    return Intl.message('Dark Mode', name: 'darkModeLabel', desc: '', args: []);
  }

  /// `Notifications`
  String get notificationsLabel {
    return Intl.message(
      'Notifications',
      name: 'notificationsLabel',
      desc: '',
      args: [],
    );
  }

  /// `Help & Support`
  String get helpSupportLabel {
    return Intl.message(
      'Help & Support',
      name: 'helpSupportLabel',
      desc: '',
      args: [],
    );
  }

  /// `About`
  String get aboutLabel {
    return Intl.message('About', name: 'aboutLabel', desc: '', args: []);
  }

  /// `Log Out`
  String get logoutLabel {
    return Intl.message('Log Out', name: 'logoutLabel', desc: '', args: []);
  }

  /// `Security`
  String get securityLabel {
    return Intl.message('Security', name: 'securityLabel', desc: '', args: []);
  }

  /// `What are you looking for today?`
  String get whatLookingFor {
    return Intl.message(
      'What are you looking for today?',
      name: 'whatLookingFor',
      desc: '',
      args: [],
    );
  }

  /// `Search...`
  String get searchHint {
    return Intl.message('Search...', name: 'searchHint', desc: '', args: []);
  }

  /// `Cleaning Services`
  String get cleaningServices {
    return Intl.message(
      'Cleaning Services',
      name: 'cleaningServices',
      desc: '',
      args: [],
    );
  }

  /// `Cleaning`
  String get categoryCleaning {
    return Intl.message(
      'Cleaning',
      name: 'categoryCleaning',
      desc: '',
      args: [],
    );
  }

  /// `Air Conditioning`
  String get categoryClim {
    return Intl.message(
      'Air Conditioning',
      name: 'categoryClim',
      desc: '',
      args: [],
    );
  }

  /// `Electricity`
  String get categoryElectric {
    return Intl.message(
      'Electricity',
      name: 'categoryElectric',
      desc: '',
      args: [],
    );
  }

  /// `Pest Control`
  String get categoryAntiNuisible {
    return Intl.message(
      'Pest Control',
      name: 'categoryAntiNuisible',
      desc: '',
      args: [],
    );
  }

  /// `Gardening`
  String get categoryJardinage {
    return Intl.message(
      'Gardening',
      name: 'categoryJardinage',
      desc: '',
      args: [],
    );
  }

  /// `Locksmith`
  String get categorySerrurier {
    return Intl.message(
      'Locksmith',
      name: 'categorySerrurier',
      desc: '',
      args: [],
    );
  }

  /// `Surveillance`
  String get categorySurveillance {
    return Intl.message(
      'Surveillance',
      name: 'categorySurveillance',
      desc: '',
      args: [],
    );
  }

  /// `Security Guarding`
  String get categoryGardiennage {
    return Intl.message(
      'Security Guarding',
      name: 'categoryGardiennage',
      desc: '',
      args: [],
    );
  }

  /// `Accounting`
  String get categoryComptabilite {
    return Intl.message(
      'Accounting',
      name: 'categoryComptabilite',
      desc: '',
      args: [],
    );
  }

  /// `Rodent Control`
  String get categoryDeratisation {
    return Intl.message(
      'Rodent Control',
      name: 'categoryDeratisation',
      desc: '',
      args: [],
    );
  }

  /// `All Categories`
  String get allCategories {
    return Intl.message(
      'All Categories',
      name: 'allCategories',
      desc: '',
      args: [],
    );
  }

  /// `Sub Categories`
  String get subcategories {
    return Intl.message(
      'Sub Categories',
      name: 'subcategories',
      desc: '',
      args: [],
    );
  }

  /// `Change Password`
  String get changePassword {
    return Intl.message(
      'Change Password',
      name: 'changePassword',
      desc: '',
      args: [],
    );
  }

  /// `Current Password`
  String get currentPassword {
    return Intl.message(
      'Current Password',
      name: 'currentPassword',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get newPassword {
    return Intl.message(
      'New Password',
      name: 'newPassword',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirmPassword {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `This field cannot be empty`
  String get fieldRequired {
    return Intl.message(
      'This field cannot be empty',
      name: 'fieldRequired',
      desc: '',
      args: [],
    );
  }

  /// `Password must be at least 6 characters long`
  String get passwordLengthError {
    return Intl.message(
      'Password must be at least 6 characters long',
      name: 'passwordLengthError',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match`
  String get passwordMismatch {
    return Intl.message(
      'Passwords do not match',
      name: 'passwordMismatch',
      desc: '',
      args: [],
    );
  }

  /// `Current password is incorrect`
  String get currentPasswordIncorrect {
    return Intl.message(
      'Current password is incorrect',
      name: 'currentPasswordIncorrect',
      desc: '',
      args: [],
    );
  }

  /// `Password changed successfully!`
  String get passwordChangedSuccess {
    return Intl.message(
      'Password changed successfully!',
      name: 'passwordChangedSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message('Save', name: 'save', desc: '', args: []);
  }

  /// `Personal Information`
  String get personalInfo {
    return Intl.message(
      'Personal Information',
      name: 'personalInfo',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message('Edit', name: 'edit', desc: '', args: []);
  }

  /// `Full Name`
  String get fullName {
    return Intl.message('Full Name', name: 'fullName', desc: '', args: []);
  }

  /// `Email`
  String get email {
    return Intl.message('Email', name: 'email', desc: '', args: []);
  }

  /// `Phone Number`
  String get phoneNumber {
    return Intl.message(
      'Phone Number',
      name: 'phoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get address {
    return Intl.message('Address', name: 'address', desc: '', args: []);
  }

  /// `Edit Profile`
  String get editProfile {
    return Intl.message(
      'Edit Profile',
      name: 'editProfile',
      desc: '',
      args: [],
    );
  }

  /// `Create Account`
  String get signUpTitle {
    return Intl.message(
      'Create Account',
      name: 'signUpTitle',
      desc: '',
      args: [],
    );
  }

  /// `Please fill out the information below`
  String get signUpSubtitle {
    return Intl.message(
      'Please fill out the information below',
      name: 'signUpSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `First Name`
  String get firstNameHint {
    return Intl.message(
      'First Name',
      name: 'firstNameHint',
      desc: '',
      args: [],
    );
  }

  /// `Last Name`
  String get lastNameHint {
    return Intl.message('Last Name', name: 'lastNameHint', desc: '', args: []);
  }

  /// `Email`
  String get emailHint {
    return Intl.message('Email', name: 'emailHint', desc: '', args: []);
  }

  /// `Phone Number`
  String get phoneHint {
    return Intl.message('Phone Number', name: 'phoneHint', desc: '', args: []);
  }

  /// `Password`
  String get passwordHint {
    return Intl.message('Password', name: 'passwordHint', desc: '', args: []);
  }

  /// `Confirm Password`
  String get confirmPasswordHint {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPasswordHint',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account?`
  String get alreadyHaveAccount {
    return Intl.message(
      'Already have an account?',
      name: 'alreadyHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get signUp {
    return Intl.message('Sign Up', name: 'signUp', desc: '', args: []);
  }

  /// `Log In`
  String get loginText {
    return Intl.message('Log In', name: 'loginText', desc: '', args: []);
  }

  /// `Or sign up with`
  String get socialSignUp {
    return Intl.message(
      'Or sign up with',
      name: 'socialSignUp',
      desc: '',
      args: [],
    );
  }

  /// `Sign In`
  String get signInTitle {
    return Intl.message('Sign In', name: 'signInTitle', desc: '', args: []);
  }

  /// `Please sign in to continue`
  String get signInSubtitle {
    return Intl.message(
      'Please sign in to continue',
      name: 'signInSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Remember Me`
  String get rememberMe {
    return Intl.message('Remember Me', name: 'rememberMe', desc: '', args: []);
  }

  /// `Forgot Password?`
  String get forgotPassword {
    return Intl.message(
      'Forgot Password?',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Sign In`
  String get signInButton {
    return Intl.message('Sign In', name: 'signInButton', desc: '', args: []);
  }

  /// `Don't have an account?`
  String get noAccount {
    return Intl.message(
      'Don\'t have an account?',
      name: 'noAccount',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up Now`
  String get signUpLink {
    return Intl.message('Sign Up Now', name: 'signUpLink', desc: '', args: []);
  }

  /// `Sign in with`
  String get socialLogin {
    return Intl.message(
      'Sign in with',
      name: 'socialLogin',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get continueText {
    return Intl.message('Continue', name: 'continueText', desc: '', args: []);
  }

  /// `Forgot Password`
  String get forgotPasswordTitle {
    return Intl.message(
      'Forgot Password',
      name: 'forgotPasswordTitle',
      desc: '',
      args: [],
    );
  }

  /// `Enter your email to reset your password`
  String get forgotPasswordSubtitle {
    return Intl.message(
      'Enter your email to reset your password',
      name: 'forgotPasswordSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Reset Password`
  String get resetPasswordButton {
    return Intl.message(
      'Reset Password',
      name: 'resetPasswordButton',
      desc: '',
      args: [],
    );
  }

  /// `Check Your Email`
  String get dialogTitle {
    return Intl.message(
      'Check Your Email',
      name: 'dialogTitle',
      desc: '',
      args: [],
    );
  }

  /// `We’ve sent recovery instructions to your email`
  String get dialogDescription {
    return Intl.message(
      'We’ve sent recovery instructions to your email',
      name: 'dialogDescription',
      desc: '',
      args: [],
    );
  }

  /// `OK`
  String get okButton {
    return Intl.message('OK', name: 'okButton', desc: '', args: []);
  }

  /// `No sub-services available.`
  String get nocategoryfound {
    return Intl.message(
      'No sub-services available.',
      name: 'nocategoryfound',
      desc: '',
      args: [],
    );
  }

  /// `Back`
  String get back {
    return Intl.message('Back', name: 'back', desc: '', args: []);
  }

  /// `Refresh`
  String get refresh {
    return Intl.message('Refresh', name: 'refresh', desc: '', args: []);
  }

  /// `No services available`
  String get noservice {
    return Intl.message(
      'No services available',
      name: 'noservice',
      desc: '',
      args: [],
    );
  }

  /// `No history found.`
  String get nohistory {
    return Intl.message(
      'No history found.',
      name: 'nohistory',
      desc: '',
      args: [],
    );
  }

  /// `Search Result`
  String get searchresult {
    return Intl.message(
      'Search Result',
      name: 'searchresult',
      desc: '',
      args: [],
    );
  }

  /// `Please fill in all fields.`
  String get errorFillFields {
    return Intl.message(
      'Please fill in all fields.',
      name: 'errorFillFields',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid email address.`
  String get errorInvalidEmail {
    return Intl.message(
      'Please enter a valid email address.',
      name: 'errorInvalidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Please verify your email before logging in.`
  String get errorEmailNotVerified {
    return Intl.message(
      'Please verify your email before logging in.',
      name: 'errorEmailNotVerified',
      desc: '',
      args: [],
    );
  }

  /// `The password you entered is incorrect.`
  String get errorWrongPassword {
    return Intl.message(
      'The password you entered is incorrect.',
      name: 'errorWrongPassword',
      desc: '',
      args: [],
    );
  }

  /// `No account found with this email.`
  String get errorUserNotFound {
    return Intl.message(
      'No account found with this email.',
      name: 'errorUserNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match.`
  String get passwordsDoNotMatch {
    return Intl.message(
      'Passwords do not match.',
      name: 'passwordsDoNotMatch',
      desc: '',
      args: [],
    );
  }

  /// `Email is already in use.`
  String get emailAlreadyInUse {
    return Intl.message(
      'Email is already in use.',
      name: 'emailAlreadyInUse',
      desc: '',
      args: [],
    );
  }

  /// `Password is too weak.`
  String get weakPassword {
    return Intl.message(
      'Password is too weak.',
      name: 'weakPassword',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong. Please try again.`
  String get somethingWentWrong {
    return Intl.message(
      'Something went wrong. Please try again.',
      name: 'somethingWentWrong',
      desc: '',
      args: [],
    );
  }

  /// `Unexpected error occurred.`
  String get unexpectedErrorOccurred {
    return Intl.message(
      'Unexpected error occurred.',
      name: 'unexpectedErrorOccurred',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred during Google sign-in.`
  String get googleSignInError {
    return Intl.message(
      'An error occurred during Google sign-in.',
      name: 'googleSignInError',
      desc: '',
      args: [],
    );
  }

  /// `An unexpected error occurred during Google sign-in.`
  String get googleSignInUnexpectedError {
    return Intl.message(
      'An unexpected error occurred during Google sign-in.',
      name: 'googleSignInUnexpectedError',
      desc: '',
      args: [],
    );
  }

  /// `Email Verification Sent`
  String get emailVerificationSent {
    return Intl.message(
      'Email Verification Sent',
      name: 'emailVerificationSent',
      desc: '',
      args: [],
    );
  }

  /// `Please check your inbox and verify your email.`
  String get checkInboxForVerification {
    return Intl.message(
      'Please check your inbox and verify your email.',
      name: 'checkInboxForVerification',
      desc: '',
      args: [],
    );
  }

  /// `Missing Info`
  String get missingInfo {
    return Intl.message(
      'Missing Info',
      name: 'missingInfo',
      desc: '',
      args: [],
    );
  }

  /// `Order Submitted!`
  String get orderSubmitted {
    return Intl.message(
      'Order Submitted!',
      name: 'orderSubmitted',
      desc: '',
      args: [],
    );
  }

  /// `Your order for {serviceName} has been successfully placed. We will contact you soon!`
  String orderConfirmationMessage(Object serviceName) {
    return Intl.message(
      'Your order for $serviceName has been successfully placed. We will contact you soon!',
      name: 'orderConfirmationMessage',
      desc: '',
      args: [serviceName],
    );
  }

  /// `Your order for {serviceName} has been placed!`
  String orderPlacedSnackbar(Object serviceName) {
    return Intl.message(
      'Your order for $serviceName has been placed!',
      name: 'orderPlacedSnackbar',
      desc: '',
      args: [serviceName],
    );
  }

  /// `Please complete your profile with a valid phone number and address before placing an order.`
  String get profileIncompleteError {
    return Intl.message(
      'Please complete your profile with a valid phone number and address before placing an order.',
      name: 'profileIncompleteError',
      desc: '',
      args: [],
    );
  }

  /// `User profile not found.`
  String get userNotFoundError {
    return Intl.message(
      'User profile not found.',
      name: 'userNotFoundError',
      desc: '',
      args: [],
    );
  }

  /// `You must be logged in to place an order.`
  String get loginRequiredError {
    return Intl.message(
      'You must be logged in to place an order.',
      name: 'loginRequiredError',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred. Please try again.`
  String get errorOccurred {
    return Intl.message(
      'An error occurred. Please try again.',
      name: 'errorOccurred',
      desc: '',
      args: [],
    );
  }

  /// `Email sending failed. Please try again.`
  String get emailSentError {
    return Intl.message(
      'Email sending failed. Please try again.',
      name: 'emailSentError',
      desc: '',
      args: [],
    );
  }

  /// `Check Your Email`
  String get checkYourEmail {
    return Intl.message(
      'Check Your Email',
      name: 'checkYourEmail',
      desc: '',
      args: [],
    );
  }

  /// `If an account exists with this email, a password reset link has been sent.`
  String get emailResetMessage {
    return Intl.message(
      'If an account exists with this email, a password reset link has been sent.',
      name: 'emailResetMessage',
      desc: '',
      args: [],
    );
  }

  /// `There was an issue resetting your password. Please try again.`
  String get resetPasswordErrorMessage {
    return Intl.message(
      'There was an issue resetting your password. Please try again.',
      name: 'resetPasswordErrorMessage',
      desc: '',
      args: [],
    );
  }

  /// `Email is required`
  String get emailRequired {
    return Intl.message(
      'Email is required',
      name: 'emailRequired',
      desc: '',
      args: [],
    );
  }

  /// `Hello {name} 👋`
  String greetingUser(String name) {
    return Intl.message(
      'Hello $name 👋',
      name: 'greetingUser',
      desc: 'Greeting message to the user with their name',
      args: [name],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
      Locale.fromSubtags(languageCode: 'fr'),
      Locale.fromSubtags(languageCode: 'zh'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
