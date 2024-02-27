import 'package:prestige_valet_app/core/resources/english_strings.dart';

class Strings {
  static const String noInternetConnection =
      EnglishStrings.noInternetConnection;

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
  static const String parking = 'Parking';

  //Home Screen
  static String carParkedHiString(String userName) =>
      'Hi $userName, Your Car Is\nParked Safely';

  static String mainScreenHiString({required String userName}) =>
      'Hi $userName, Let the\ndoorman scan the QR\ncode in order to park';
  static const String uniqueId = 'Unique Identifier';
  static const String showYourHistory = 'Show Your History';
  static const String requestCar = 'Request Car';
  static const String washCar = 'Wash Car';

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
  static String walletHiString (String userName)=>
      'Hi $userName, This is your\n saved payment methods';
  static const String addPaymentMethod = 'Add a new payment method';
  static const String addNewPaymentMethod = 'Add a new card';
  static const String creditCardOverView = 'Credit card overview';
  static const String thereAreNoData = 'There are no data';

  static String creditCardNumber(String lastFourDigits) =>
      '**** **** **** ${lastFourDigits.length < 10 ? 1234 : lastFourDigits.substring(10)}';

  //Add Credit Card Screen
  static const String addCreditCard = 'Add Credit Card';
  static const String editCreditCard = 'Edit Credit Card';
  static const String cardHolderName = "Cardholder's Name";
  static const String billingAddress = 'Billing Address';
  static const String cardNumber = 'Card Number';
  static const String expirationDate = 'Expiration Date';
  static const String cvv = 'CVV';
  static const String addCard = 'Add Card';
  static const String updateCard = 'Update Card';
  static const String creditCardNumberError =
      'Credit card number must be 14 number';

  //Valet History Screen
  static String valetHistoryHiString(String userName) =>
      "Hi $userName, This is your\n valet history";

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
      "we will send you a notification when it's ready";

  // Login Screen
  static const String login = "Log in";
  static const String password = "Password";
  static const String emailHint = "Enter your email";
  static const String passwordHint = "Enter your password";
  static const String loginTitle = "Log in to your Prestige\nAccount";
  static const String forgetPassword = "Forgot your password?";
  static const String or = "or";
  static const String loginError = "Please check E-mail and password";

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
  static const String emailActivated = "The account activated from email";
  static const String enterOtp = 'Enter OTP';
  static const String textFieldError = 'This field must not be empty';
  static const String wrongEmail = 'Please enter valid E-mail';
  static const String passwordDoesNotMatch = 'Password does not match';

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
  static const String generateQrCode = "Generate guest QR code";
  static const String retrieveGuestCar = "Retrieve guest car";
  static const String gate = "Gate";

  static String parkingHiString(String valetName) =>
      "Hi $valetName, This is Your\nParking History";

  // NotificationBody
  static String notificationTitle(String userName) => 'Hello $userName';
  static const String userCarParked = 'Your car has been successfully parked';
  static const String userCarRetrievingRequest =
      'Your request has been received';
  static const String userCarWashRequest = 'Your request has been received';
  static const String userCancelRetrieving = 'Your request has been canceled';
  static const String userCarRetrieving = 'Your car is ready for pickup';

//Valet
  static String valetCarRetrievingRequest(String userName) =>
      'User $userName has submitted a request to restore their car. Please review and process accordingly';

  static String valetCarWashingRequest(String userName) =>
      'User $userName has submitted a request for a car wash. Please review and process accordingly';

  static String valetUserCanceled(String userName) =>
      'User $userName has requested to cancel their previous request to retrieve their car. Please review and process the cancellation';
  static String requests = 'Requests';
  static String history = 'History';
}
