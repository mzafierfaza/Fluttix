part of "pages.dart";

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isEmailValid = false;
  bool isPasswordValid = false;
  bool isSigninIn = false;

  @override
  Widget build(BuildContext context) {
    // sebelum return Scaffoldnya, kita ubah dulu theme nya.
    context
        .bloc<ThemeBloc>()
        .add(ChangeTheme(ThemeData().copyWith(primaryColor: mainColor)));

    return WillPopScope(
      onWillPop: () {
        context.bloc<PageBloc>().add(GoToSplashPage());

        return;
      },
      child: Scaffold(
        backgroundColor: secondaryColor,
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 60),
                  SizedBox(height: 70, child: Image.asset("assets/logo.png")),
                  Container(
                    margin: EdgeInsets.only(top: 70, bottom: 40),
                    child: Text("Selamat datang \nkembali Moviegoers!",
                        textAlign: TextAlign.start,
                        style: blueTextFont.copyWith(
                            fontSize: 22, fontWeight: FontWeight.w700)),
                  ),
                  TextField(
                      controller: emailController,
                      onChanged: (text) {
                        setState(() {
                          // setState berfungsi jika email tidak valid, maka floating action button gakbisa di pencet
                          isEmailValid = EmailValidator.validate(text);
                        });
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: "Email Address",
                          hintText: "Email Address")),
                  SizedBox(height: 16),
                  TextField(
                      onChanged: (text) {
                        setState(() {
                          // setState berfungsi jika password tidak valid, maka floating action button gakbisa di pencet
                          isPasswordValid = text.length >= 6;
                        });
                      },
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: "Password",
                          hintText: "Password")),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Text("Lupa password? ",
                          style: blackTextFont.copyWith(fontSize: 16)),
                      Text("Klik disini",
                          style: blueTextFont.copyWith(fontSize: 16))
                    ],
                  ),
                  Center(
                    child: Container(
                      width: 50,
                      height: 50,
                      margin: EdgeInsets.only(top: 70, bottom: 20),
                      child:
                          isSigninIn // kalau isSignIn true maka yang ditampilkan spinkit
                              ? SpinKitFadingCircle(color: mainColor)
                              : FloatingActionButton(
                                  elevation: 0, // biar gak ada bayangan
                                  child: Icon(Icons.arrow_forward,
                                      color: isEmailValid && isPasswordValid
                                          ? Colors.white
                                          : Color(0xFFBEBEBEBE)),
                                  backgroundColor:
                                      isEmailValid && isPasswordValid
                                          ? mainColor
                                          : Color(0xFFE4E4E4),
                                  onPressed: isEmailValid && isPasswordValid
                                      ? () async {
                                          setState(() {
                                            isSigninIn = true;
                                          });

                                          SignInSignUpResult result =
                                              await AuthServices.signIn(
                                                  emailController.text,
                                                  passwordController.text);

                                          if (result.user == null) {
                                            setState(() {
                                              isSigninIn = false;
                                            });

                                            print(result.message);

                                            // tampilkan kesalahan
                                            Flushbar(
                                              duration: Duration(seconds: 4),
                                              flushbarPosition:
                                                  FlushbarPosition.TOP,
                                              backgroundColor:
                                                  Color(0xFFFF5C83),
                                              message: result.message,
                                            )..show(context);
                                          }
                                        }
                                      : null),
                    ),
                  ),
                  Row(
                    children: [
                      Text("Belum mempunyai akun? ",
                          style: blackTextFont.copyWith(fontSize: 16)),
                      Text("Daftar Sekarang",
                          style: blueTextFont.copyWith(fontSize: 16))
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
