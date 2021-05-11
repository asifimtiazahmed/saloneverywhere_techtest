import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Widgets/cardInput.dart';
import '../Widgets/seRoundButton.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  AuthUser _user;

  bool isSignedIn = false;

  final TextEditingController userEmailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> _onLogin(
      BuildContext context, String user, String password) async {
    try {
      final res = await Amplify.Auth.signIn(username: user, password: password);

      setState(() {
        isSignedIn = res.isSignedIn;
      });
    } on AuthException catch (e) {
      // ScaffoldMessenger.of(context).showSnackBar(  //Future feature
      //     SnackBar(
      //       content: Text(e.message, style: TextStyle(color: Colors.white),),
      //     )
      // );
      print(e.message);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Amplify.Auth.getCurrentUser().then((user) {
      setState(() {
        _user = user;
      });
    }).catchError((error) {
      print(error);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: Image.asset('./Assets/salonLogo.png'),
        actions: [
          MaterialButton(
              child: Icon(
                Icons.home_outlined,
                color: Colors.red[800],
              ),
              onPressed: () {
                Navigator.of(context)
                    .pushReplacementNamed(isSignedIn ? '/dashboard' : '/');
              })
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              'Sign In',
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: Colors.red[800]),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Please enter your email address and password to sign in',
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                    color: Colors.black26),
              ),
            ),
          ),
          SECardInput(userEmailController, 'Enter email', false),
          SECardInput(passwordController, 'Password', true),
          Align(
            alignment: Alignment.center,
            child: SERoundButton(
              labelText: 'Sign in',
              toPress: () {
                _onLogin(
                    context, userEmailController.text, passwordController.text);
                if (!isSignedIn)
                  _onLogin(context, userEmailController.text,
                      passwordController.text);
                print(isSignedIn);
                Navigator.of(context).pushReplacementNamed('/dashboard');
              },
            ),
          ),
        ],
      ),
    );
  }
}
