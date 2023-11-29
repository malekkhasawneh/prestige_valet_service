import 'package:prestige_valet_app/core/resources/english_strings.dart';

class Strings {
  static String noInternetConnection() {
    return EnglishStrings.noInternetConnection;
  }

  static String processFailed() {
    return EnglishStrings.processFailed;
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

  static String mainScreenHiString({required String userName}) =>
      'Hi $userName, Let the\ndoorman scan the QR\ncode in order to park';
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
  static const String thereAreNoData = 'There are no data';

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

  // Sign Up Screen
  static const String signUp = "Sign Up";
  static const String signUpFirstName = "First Name*";
  static const String signUpLastName = "Last Name*";
  static const String signUpPhoneNumber = "Phone Number*";
  static const String signUpEmailAddress = "Email Address*";
  static const String signUpPassword = "Password*";
  static const String verifyYourAccount = "Verify Your Account";
  static const String enterVerificationCode = "Enter Verification Code";
  static const String resendCode = "Resend Code";
  static const String enterOtp = 'Enter OTP';

  // Forget Password Screen
  static const String forgetPasswordTitle = "Forgot Your Password?";
  static const String updateYourPasswordTitle = "Update Your Password";
  static const String enterEmailAddress = "Enter Email Address";
  static const String enterEmailHint = "email.email@mail.com";
  static const String sendVerificationCode = "Send Verification Code";
  static const String doNotHaveAccount = "Don't have an account? Register now";
  static const String enterPassword = "Enter New Password";
  static const String enterPasswordHint = "Enter your password";
  static const String confirmPassword = "Confirm New Password";
  static const String confirmPasswordHint = "Confirm your password";
  static const String save = "Save";

  // Scan Qr code screen
  static const String scanQrCode = "Scan QR code";

}
