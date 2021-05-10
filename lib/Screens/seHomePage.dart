//Core library
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//Added libraries
import 'package:amplify_analytics_pinpoint/amplify_analytics_pinpoint.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:google_fonts/google_fonts.dart';

//Custom libraries
import '../amplifyconfiguration.dart';
import '../Widgets/orSeperator.dart';
import '../Widgets/seRoundButton.dart';
import '../Widgets/cardInput.dart';
import '../Widgets/seTextButton.dart';
import '../Screens/seSignIn.dart';

class SEHomePage extends StatefulWidget {
  @override
  _SEHomePageState createState() => _SEHomePageState();
}

class _SEHomePageState extends State<SEHomePage> {
  bool _amplifyConfigured =
      false; //Initial check if the amplify has been configured or not
  bool isSignUpComplete = false;
  Map<String, String> _userData;

  @override
  void initState() {
    super.initState();
    _configureAmplify();
  }

  //Text controllers for getting the text input
  final TextEditingController emailText = TextEditingController();
  final TextEditingController passwordText = TextEditingController();
  final TextEditingController firstNameText = TextEditingController();
  final TextEditingController lastNameText = TextEditingController();
  final TextEditingController countryText = TextEditingController();
  final TextEditingController postalCodeText = TextEditingController();
  final TextEditingController phoneNumberText = TextEditingController();

  // Seting up AWS Link
  void _configureAmplify() async {
    AmplifyAnalyticsPinpoint analyticsPlugin = AmplifyAnalyticsPinpoint();
    AmplifyAuthCognito authPlugin = AmplifyAuthCognito();
    Amplify.addPlugins([authPlugin, analyticsPlugin]);

    // Once Plugins are added, configure Amplify
    // Note: Amplify can only be configured once.
    try {
      await Amplify.configure(amplifyconfig);

      setState(() {
        _amplifyConfigured = true;
        print('config success!');
      });
    } on AmplifyAlreadyConfiguredException {
      print(
          "Tried to reconfigure Amplify; this can occur when your app restarts on Android.");
    }
  }

//Registering a new user
  void userRegistration() async {
    try {
      Map<String, String> userAttributes = {
        'email': emailText.text,
        // 'firstName': firstNameText.text,
        // 'lastName': lastNameText.text,
        // 'country': countryText.text,
        // 'postalCode': postalCodeText.text,
        // 'phoneNumber': phoneNumberText.text
      };
      _userData = {
        'email': emailText.text,
        'firstName': firstNameText.text,
        'lastName': lastNameText.text,
        'country': countryText.text,
        'postalCode': postalCodeText.text,
        'phoneNumber': phoneNumberText.text
      };

      SignUpResult res = await Amplify.Auth.signUp(
        username: emailText.text,
        password: passwordText.text,
        options: CognitoSignUpOptions(userAttributes: userAttributes),
      );
      setState(() {
        isSignUpComplete = res.isSignUpComplete;
        print(userAttributes.entries);
        print('signUp success!');
      });
    } on AuthException catch (e) {
      print(e.message);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.message,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.red[800],
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: Image.asset('./Assets/salonLogo.png'),
      ),
      body: SafeArea(
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Join as Guest',
                  style: GoogleFonts.poppins(
                    textStyle:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                  ),
                ),
              ),
            ),
            //Join as Guest Text
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Text(
            //       'or ',
            //       style: GoogleFonts.poppins(
            //         textStyle:
            //             TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            //       ),
            //     ),
            //     SETextButton(text: 'Join as PRO', toPress: () {})
            //     //Join as Pro hyperlink
            //   ],
            // ), //or Text
            SECardInput(emailText, 'Email', false),
            SECardInput(passwordText, 'Password', true),
            SECardInput(firstNameText, 'First Name', false),
            SECardInput(lastNameText, 'Last Name', false),
            // SECardInput(countryText, 'Country', false),
            // SECardInput(postalCodeText, 'Postal Code', false),
            // SECardInput(phoneNumberText, 'Phone Number', false),
            Align(
                child: SERoundButton(
              labelText: 'Next',
              toPress: () {
                userRegistration();
                if (isSignUpComplete) {
                  Navigator.of(context).pushReplacementNamed(
                      '/signUpVerification',
                      arguments: _userData);
                }
              },
            ) //Elevated Button
                ),
            OrSeparator(),
            Align(
              alignment: Alignment.center,
              child: SETextButton(
                  text: 'Sign In',
                  toPress: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignInPage()));
                  }),
            ), //Sign In Button
          ],
        ),
      ),
    );
  }
}
