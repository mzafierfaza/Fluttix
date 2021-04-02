import 'package:bwa_motix/services/services.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Column(
            children: [
              RaisedButton(
                  child: Text("Sign Up"),
                  onPressed: () async {
                    SignInSignUpResult result = await AuthServices.signUp(
                        "floch_marley@eldia.com",
                        "eren123",
                        "floch marley",
                        ['Action', 'Drama', 'War'],
                        "Japanese");
                    if (result.user == null) {
                      print(result.message);
                    } else {
                      print(result.user.toString());
                    }
                  }),
              RaisedButton(
                  child: Text("Sign In"),
                  onPressed: () async {
                    SignInSignUpResult result = await AuthServices.signIn(
                        "connie@eldia.com", "eren1233");
                    if (result.user == null) {
                      print(result.message);
                    } else {
                      print(result.user.toString());
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
