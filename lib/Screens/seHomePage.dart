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

  //bool emailOK, passOK, fNameOK, lNameOK = false;
  //bool buttonEnable = false;

  @override
  void initState() {
    super.initState();
    _configureAmplify();
    //checkEmptyControllers();
  }

  // void enableNextButton(){
  //   if(emailOK && passOK && fNameOK && lNameOK) buttonEnable = true;
  // }
  //
  // void checkEmptyControllers(){ //This method will be called by initState to listen for updates to the text fiends, and then enable the submit button
  //   emailText.addListener(() {
  //     setState(() {
  //       emailText.text.isNotEmpty ? emailOK = true : emailOK = false;
  //       enableNextButton();
  //     });
  //   });
  //   passwordText.addListener(() {
  //     setState(() {
  //       passwordText.text.isNotEmpty ? passOK = true : passOK = false;
  //       enableNextButton();
  //     });
  //   });
  //   firstNameText.addListener(() {
  //     setState(() {
  //       fNameOK = firstNameText.text.isNotEmpty;
  //       enableNextButton();
  //     });
  //   });
  //   lastNameText.addListener(() {
  //     setState(() {
  //       lNameOK = lastNameText.text.isNotEmpty;
  //       enableNextButton();
  //     });
  //   });
  //
  // }

  //Text controllers for getting the text input //This was a trial for the checkE

  final TextEditingController emailText = TextEditingController();
  final TextEditingController passwordText = TextEditingController();
  final TextEditingController firstNameText = TextEditingController();
  final TextEditingController lastNameText = TextEditingController();

  // final TextEditingController countryText = TextEditingController();
  // final TextEditingController postalCodeText = TextEditingController();
  // final TextEditingController phoneNumberText = TextEditingController();

  // Seting up AWS Link

  void _configureAmplify() async {
    bool isConfigured = Amplify
        .isConfigured; //This checks if the app has already alunched and configured, when routing homepage may load again, and this resolved retrying to config errors
    if (!isConfigured) {
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
  }

//Registering a new user
  void userRegistration() async {
    try {
      Map<String, String> userAttributes = {
        'email': emailText.text,
        'name': firstNameText.text,
        'family_name': lastNameText.text,
        // 'country': countryText.text,
        // 'postalCode': postalCodeText.text,
        // 'phoneNumber': phoneNumberText.text
      };
      _userData = {
        'email': emailText.text,
        'password': passwordText.text,
        'name': firstNameText.text,
        'family_name': lastNameText.text,
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
  void dispose() {
    emailText.dispose();
    passwordText.dispose();
    firstNameText.dispose();
    lastNameText.dispose();
    super.dispose();
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
            Text(
              '*All fields are required to proceed to register',
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  //fontWeight: FontWeight.bold,
                  fontSize: 12.0,
                  color: Colors.black54,
                ),
              ),
            ),
            // SECardInput(countryText, 'Country', false),
            // SECardInput(postalCodeText, 'Postal Code', false),
            // SECardInput(phoneNumberText, 'Phone Number', false),
            Align(
                child: SERoundButton(
              labelText: 'Register',
              toPress: () {
                userRegistration();
                Navigator.of(context).pushReplacementNamed(
                    '/signUpVerification',
                    arguments: _userData);
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
