class NetworkConstants {
  static const String baseUrl = 'http://82.208.22.118/prestige/api/v1/';
  static const String authenticateEndPoint = 'auth/authenticate';
  static const String registerEndPoint = 'auth/register';
  static const String loginEndPoint = 'auth/authenticate';
  static const String changePasswordEndPoint = 'auth/resetPassword';
  static const String getCards = 'wallet';
  static const String editProfile = 'auth/user/profile';
  static const String addUserImage = 'auth/user/image';

  static String addCardEndPoint(int userId) => 'wallet?userId=$userId';

  static String editCardEndPoint(int userId, int walletId) =>
      'wallet?walletId=$walletId&userId=$userId';
  static  String getGatesEndPoint(int locationId) => 'location/$locationId/gates?pageSize=1000';

  static String logoutEndPoint(int userId) => 'auth/logout/$userId';
  static const String parkCar = 'valet/Parking';
  static const String addNotificationToken = 'notification';

  static String getNotificationToken(int userId) => 'notification/$userId';

  static String updateNotificationToken(int notificationId) =>
      'notification?notificationId=$notificationId';

  static String changeParkingStatus({required int parkingId}) =>
      'valet/Parking/parked?parkingId=$parkingId';

  static String carDelivered({required int parkingId}) =>
      'valet/Parking/delivered?parkingId=$parkingId';

  static String retrieveCar({required int parkingId, required int gateId}) =>
      'Parking/retrieve?parkingId=$parkingId&gateId=$gateId';

  static String cancelCarRetrieving({required int parkingId}) =>
      'Parking/retrieve/cancel?parkingId=$parkingId';

  static String washCar({required int parkingId, required bool washFlag}) =>
      'Parking/washCar/$parkingId?washCar=$washFlag';

  static String getValetCarHistory({required int valetId}) =>
      'valet/Parking?valetId=$valetId&pageSize=1000';

  static String getUserHistory({required int userId}) =>
      'Parking?userId=$userId&pageSize=1000';

  static String sendResetPasswordOtp({required String email}) =>
      'auth/forgetPassword?email=$email';

  static const String sendNotification = 'https://fcm.googleapis.com/fcm/send';

  static const String verifyOtp = 'auth/verifyToken';
}
