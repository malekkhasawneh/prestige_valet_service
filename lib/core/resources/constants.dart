import 'dart:core';

class Constants {
  static const String userRole = 'USER';
  static const String valetRole = 'VALET';
  static const String encryptionKey =
      '5ClNua5WgenQBtf9lEQv5mJEftisfkq23GM5XKmmVPw=';
  static const String encryptionIv = 'R_i64s1KpBmimQ2UaQ04JQ==';
  static const String serverFailure = 'Unable to connect to server';
  static const String internetFailure = 'Check your connection';
  static const String cacheFailure = 'Unable to access to cache';
  static const String resetPasswordSuccess = 'Password reset successfully!!';
  static const String envFileName = '.env';
  static const String androidFirebaseApiKey = 'ANDROID_FIREBASE_API_KEY';
  static const String androidAppId = 'ANDROID_APP_ID';
  static const String androidMessagingSenderId = 'ANDROID_MESSAGING_SENDER_ID';
  static const String androidProjectId = 'ANDROID_PROJECT_ID';
  static const String twitterApiKey = 'TWITTER_API_KEY';
  static const String twitterApiSecretKey = 'TWITTER_API_SECRET_KEY';
  static const String twitterRedirectUrl = 'TWITTER_REDIRECT_URL';
  static const String deliveredToGateKeeper = "DELIVERED_TO_GATEKEEPER";
  static const String sendNotificationToken = "SEND_NOTIFICATION_TOKEN";
  static const String myFatoorahToken = "MY_FATOORAH_TOKEN";
  static const String carParked = "PARKED";
  static const String carDelivered = "DELIVERED_TO_USER";
  static const String carInRetrieving = "RETRIEVING";
  static const String noElement = "No element";
  static const String userLoggedOut = "user logged out";
  static const String notificationDataType = "click_action";
  static const String notificationReceiverType = "receiver type";
  static const String toUserNotification = "to user";
  static const String toValetNotification = "to valet";
  static const String carParkedNotificationAction = "CAR_PARKED";
  static const String carInRetrievingNotificationAction = "CAR_IN_RETRIEVING";
  static const String cancelCarRetrievingNotificationAction = "CANCEL CAR RETRIEVING";
  static const String carDeliveredNotificationAction = "DELIVERED_TO_USER";
  static const String carWashNotificationAction = "CAR_WASH_REQUEST";

  static const String baseNotificationChannelKey = 'send_notification';
  static const String baseNotificationChannelName =
      'notify_user_about_car_status';
  static const String baseNotificationChannelDesc =
      'send_notification_to_user_when_status_changed';
}
