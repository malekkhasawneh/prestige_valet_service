import 'package:prestige_valet_app/core/helpers/cache_helper.dart';
import 'package:prestige_valet_app/core/resources/arabic_strings.dart';
import 'package:prestige_valet_app/core/resources/cache_keys.dart';
import 'package:prestige_valet_app/core/resources/english_strings.dart';

class Strings {
  static bool isEnglish = SharedPreferencesHelper.getBool(
    CacheKeys.isEnglishLanguage,
    defaultValue: true,
  );

  static String noInternetConnection() {
    return isEnglish
        ? EnglishStrings.noInternetConnection
        : ArabicStrings.noInternetConnection;
  }

  static String processFailed() {
    return isEnglish
        ? EnglishStrings.processFailed
        : ArabicStrings.processFailed;
  }

  //Welcome Screen
  static const String prestigeValet = 'Prestige Valet';
  static const String welcomeDes =
      'Book a valet service at top locations\nwith just a few taps';
  static const String getStarted = 'Get Started';

  //Bottom Nav Bar Screen
  static const String home = 'Home';
  static const String wallet = 'Wallet';
  static const String profile = 'Profile';

  //Home Screen
  static const String carParkedHiString =
      'Hi Shaker, Your Car Is\nParked Safely';
  static const String mainScreenHiString =
      'Hi Shaker, Let the\ndoorman scan the QR\ncode in order to park';
  static const String uniqueId = 'Unique Identifier';
  static const String showYourHistory = 'Show Your History';
  static const String requestCar = 'Request Car';

  //Process Screens
  static const String parkedSuccessfully =
      'Your car has been parked\n successfully!';
  static const String goToHome = 'Go To Home Page';
  static const String carReady = 'Your Car Is Ready For Pickup';
  static const String payWithCash = 'Pay with cash';
  static const String payWithCard = 'Pay with card';
  static const String seeYouSoon = 'See you soon!';

  //Profile
  static const String editProfile = 'Edit Profile';
  static const String getTenOff = 'Get \$10 off';
  static const String shareCode = 'Share Code';
  static const String learnMore = 'Learn More';
  static const String referTest = 'Refer a friend and earn \$10 each!';
  static const String logout = 'Log Out';

  //Wallet Screen
  static const String walletHiString =
      'Hi Shaker, This is your\n saved payment methods';
  static const String addPaymentMethod = 'Add a new payment method';
  static const String creditCardOverView = 'Credit card overview';

  static String creditCardNumber(String lastFourDigits) =>
      '**** **** **** $lastFourDigits';

  //Add Credit Card Screen
  static const String addCreditCard = 'Add Credit Card';
  static const String cardHolderName = "Cardholder's Name";
  static const String billingAddress = 'Billing Address';
  static const String cardNumber = 'Card Number';
  static const String expirationDate = 'Expiration Date';
  static const String cvv = 'CVV';
  static const String addCard = 'Add Card';

  //Valet History Screen
  static const String valetHistoryHiString =
      "Hi Shaker, This is your\n valet history";

  //Edit Profile Screen
  static const String changeProfilePic = 'Change Profile Picture';
  static const String firstName = 'First Name';
  static const String lastName = 'Last Name';
  static const String phoneNumber = 'Phone Number';
  static const String email = 'Email';
  static const String saveChanges = 'Save Changes';

  // Pick Up Screen
  static const String pickUpTitle = "Where Do You Want To\nPick Your Car From?";
  static const String confirm = "Confirm";
  static const String cancel = "Cancel";
  static const String carRequestTitle = "Your Car Will Be Ready\nShortly";
  static const String carRequestNotification =
      "we will send yu a notification when it's ready";

  // Login Screen
  static const String login = "Log in";
  static const String password = "Password";
  static const String emailHint = "Enter your email";
  static const String passwordHint = "Enter your password";
  static const String loginTitle = "Log in to your Prestige\nAccount";
  static const String forgetPassword = "Forgot your password?";
  static const String or = "or";
}
