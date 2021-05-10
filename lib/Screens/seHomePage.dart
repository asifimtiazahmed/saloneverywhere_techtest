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

class SEHomePage extends StatefulWidget {
  @override
  _SEHomePageState createState() => _SEHomePageState();
}

class _SEHomePageState extends State<SEHomePage> {
  bool _amplifyConfigured =
      false; //Initial check if the amplify has been configured or not

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

  void _configureAmplify() async {
    AmplifyAnalyticsPinpoint analyticsPlugin = AmplifyAnalyticsPinpoint();
    AmplifyAuthCognito authPlugin = AmplifyAuthCognito();
    Amplify.addPlugins([authPlugin, analyticsPlugin]);

    // Once Plugins are added, configure Amplify
    // Note: Amplify can only be configured once.
    try {
      await Amplify.configure(amplifyconfig);
      print('config success!');

      setState(() {
        _amplifyConfigured = true;
      });
    } on AmplifyAlreadyConfiguredException {
      print(
          "Tried to reconfigure Amplify; this can occur when your app restarts on Android.");
    }
  }

  void userRegistration() async {
    try {
      Map<String, String> userAttributes = {
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
          options: CognitoSignUpOptions(userAttributes: userAttributes));
    } on AuthException catch (e) {
      print(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
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
        ), //Join as Guest Text
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'or ',
              style: GoogleFonts.poppins(
                textStyle:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
            ),
            SETextButton(text: 'Join as PRO', toPress: () {})
            //Join as Pro hyperlink
          ],
        ), //or Text
        SECardInput(emailText, 'Email', false),
        SECardInput(passwordText, 'Password', true),
        SECardInput(firstNameText, 'First Name', false),
        SECardInput(lastNameText, 'Last Name', false),
        SECardInput(countryText, 'Country', false),
        SECardInput(postalCodeText, 'Postal Code', false),
        SECardInput(phoneNumberText, 'Phone Number', false),
        Align(
            child: SERoundButton(
          labelText: 'Next',
          toPress: () {},
        ) //Elevated Button
            ),
        OrSeparator(),
        Align(
          alignment: Alignment.center,
          child: SETextButton(
            text: 'Sign In',
            toPress: () {},
          ),
        ), //Sign In Button
      ],
    );
  }
}
