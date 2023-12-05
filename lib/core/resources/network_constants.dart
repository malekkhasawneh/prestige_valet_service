class NetworkConstants {
  static const String baseUrl = 'http://82.208.22.118/prestige/api/v1/';
  static const String authenticateEndPoint = 'auth/authenticate';
  static const String registerEndPoint = 'auth/register';
  static const String loginEndPoint = 'auth/authenticate';
  static const String changePasswordEndPoint = 'auth/changePassword';
  static const String getCards = 'wallet';
  static const String editProfile = 'auth/user/profile';
  static const String addUserImage = 'auth/user/image';

  static String addCardEndPoint(int userId) => 'wallet?userId=$userId';

  static String editCardEndPoint(int userId, int walletId) =>
      'wallet?walletId=$walletId&userId=$userId';
  static const String getGatesEndPoint = 'location/gates';

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

  static String retrieveCar({required int parkingId}) =>
      'Parking/retrieve?parkingId=$parkingId';

  static String washCar({required int parkingId, required bool washFlag}) =>
      'Parking/washCar/$parkingId?washCar=$washFlag';
}
