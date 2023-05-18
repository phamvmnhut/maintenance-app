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
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
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
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Setting`
  String get setting {
    return Intl.message(
      'Setting',
      name: 'setting',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Dark Mode`
  String get dark_mode {
    return Intl.message(
      'Dark Mode',
      name: 'dark_mode',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notification {
    return Intl.message(
      'Notifications',
      name: 'notification',
      desc: '',
      args: [],
    );
  }

  /// `General`
  String get general {
    return Intl.message(
      'General',
      name: 'general',
      desc: '',
      args: [],
    );
  }

  /// `Privacy and Policy`
  String get privacy_policy {
    return Intl.message(
      'Privacy and Policy',
      name: 'privacy_policy',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Next Time Care`
  String get next_time_care {
    return Intl.message(
      'Next Time Care',
      name: 'next_time_care',
      desc: '',
      args: [],
    );
  }

  /// `Reminder`
  String get reminder {
    return Intl.message(
      'Reminder',
      name: 'reminder',
      desc: '',
      args: [],
    );
  }

  /// `Time used`
  String get time_used {
    return Intl.message(
      'Time used',
      name: 'time_used',
      desc: '',
      args: [],
    );
  }

  /// `Care time`
  String get care_time {
    return Intl.message(
      'Care time',
      name: 'care_time',
      desc: '',
      args: [],
    );
  }

  /// `You have xx time care`
  String get have_care_time {
    return Intl.message(
      'You have xx time care',
      name: 'have_care_time',
      desc: '',
      args: [],
    );
  }

  /// `xx Days`
  String get xx_day {
    return Intl.message(
      'xx Days',
      name: 'xx_day',
      desc: '',
      args: [],
    );
  }

  /// `Care as soon`
  String get care_as_soon {
    return Intl.message(
      'Care as soon',
      name: 'care_as_soon',
      desc: '',
      args: [],
    );
  }

  /// `Hello`
  String get hello {
    return Intl.message(
      'Hello',
      name: 'hello',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message(
      'Edit',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `Loading`
  String get loading {
    return Intl.message(
      'Loading',
      name: 'loading',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Sent`
  String get sent {
    return Intl.message(
      'Sent',
      name: 'sent',
      desc: '',
      args: [],
    );
  }

  /// `Update`
  String get udpate {
    return Intl.message(
      'Update',
      name: 'udpate',
      desc: '',
      args: [],
    );
  }

  /// `Verify Email`
  String get verify_email {
    return Intl.message(
      'Verify Email',
      name: 'verify_email',
      desc: '',
      args: [],
    );
  }

  /// `Update Username`
  String get update_username {
    return Intl.message(
      'Update Username',
      name: 'update_username',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `id, media and shopping`
  String get user_intro {
    return Intl.message(
      'id, media and shopping',
      name: 'user_intro',
      desc: '',
      args: [],
    );
  }

  /// `Type for search`
  String get search_hint {
    return Intl.message(
      'Type for search',
      name: 'search_hint',
      desc: '',
      args: [],
    );
  }

  /// `Your device care`
  String get your_device_care {
    return Intl.message(
      'Your device care',
      name: 'your_device_care',
      desc: '',
      args: [],
    );
  }

  /// `Successfully added new care`
  String get msg_add_care_success {
    return Intl.message(
      'Successfully added new care',
      name: 'msg_add_care_success',
      desc: '',
      args: [],
    );
  }

  /// `Add new device care`
  String get add_new_care {
    return Intl.message(
      'Add new device care',
      name: 'add_new_care',
      desc: '',
      args: [],
    );
  }

  /// `Device`
  String get device {
    return Intl.message(
      'Device',
      name: 'device',
      desc: '',
      args: [],
    );
  }

  /// `Please choose Device | Model`
  String get please_choose_device_model {
    return Intl.message(
      'Please choose Device | Model',
      name: 'please_choose_device_model',
      desc: '',
      args: [],
    );
  }

  /// `Memo name`
  String get memo_name {
    return Intl.message(
      'Memo name',
      name: 'memo_name',
      desc: '',
      args: [],
    );
  }

  /// `Start Date`
  String get start_date {
    return Intl.message(
      'Start Date',
      name: 'start_date',
      desc: '',
      args: [],
    );
  }

  /// `Care next time`
  String get care_next_time {
    return Intl.message(
      'Care next time',
      name: 'care_next_time',
      desc: '',
      args: [],
    );
  }

  /// `Information`
  String get information {
    return Intl.message(
      'Information',
      name: 'information',
      desc: '',
      args: [],
    );
  }

  /// `Please choose Equipment`
  String get please_choose_equipment {
    return Intl.message(
      'Please choose Equipment',
      name: 'please_choose_equipment',
      desc: '',
      args: [],
    );
  }

  /// `Please choose number (Days, Weeks..)`
  String get please_choose_day_week {
    return Intl.message(
      'Please choose number (Days, Weeks..)',
      name: 'please_choose_day_week',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get done {
    return Intl.message(
      'Done',
      name: 'done',
      desc: '',
      args: [],
    );
  }

  /// `Input Model name...`
  String get model_hint {
    return Intl.message(
      'Input Model name...',
      name: 'model_hint',
      desc: '',
      args: [],
    );
  }

  /// `xx Equipments`
  String get xx_equipment {
    return Intl.message(
      'xx Equipments',
      name: 'xx_equipment',
      desc: '',
      args: [],
    );
  }

  /// `Input Equipment name...`
  String get equipment_hint {
    return Intl.message(
      'Input Equipment name...',
      name: 'equipment_hint',
      desc: '',
      args: [],
    );
  }

  /// `Add new`
  String get add_new {
    return Intl.message(
      'Add new',
      name: 'add_new',
      desc: '',
      args: [],
    );
  }

  /// `Input Device name...`
  String get device_hint {
    return Intl.message(
      'Input Device name...',
      name: 'device_hint',
      desc: '',
      args: [],
    );
  }

  /// `xx Models`
  String get xx_model {
    return Intl.message(
      'xx Models',
      name: 'xx_model',
      desc: '',
      args: [],
    );
  }

  /// `Warning`
  String get warning {
    return Intl.message(
      'Warning',
      name: 'warning',
      desc: '',
      args: [],
    );
  }

  /// `Do you really want to delete?`
  String get msg_delete {
    return Intl.message(
      'Do you really want to delete?',
      name: 'msg_delete',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message(
      'Confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `Can't find Device Care!`
  String get not_found_device_care {
    return Intl.message(
      'Can\'t find Device Care!',
      name: 'not_found_device_care',
      desc: '',
      args: [],
    );
  }

  /// `Return`
  String get return_text {
    return Intl.message(
      'Return',
      name: 'return_text',
      desc: '',
      args: [],
    );
  }

  /// `Input Care name...`
  String get care_hint {
    return Intl.message(
      'Input Care name...',
      name: 'care_hint',
      desc: '',
      args: [],
    );
  }

  /// `Input Care History name...`
  String get care_history_hint {
    return Intl.message(
      'Input Care History name...',
      name: 'care_history_hint',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'vi'),
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
