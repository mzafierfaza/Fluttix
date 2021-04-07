part of "pages.dart";

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwrodController = TextEditingController();

  bool isEmailValid = false;
  bool isPasswordValid = false;
  bool isSigninIn = false;

  @override
  Widget build(BuildContext context) {
    // sebelum return Scaffoldnya, kita ubah dulu theme nya.
    context
        .bloc<ThemeBloc>()
        .add(ChangeTheme(ThemeData().copyWith(primaryColor: mainColor)));
    return Scaffold(
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
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: "Email Address",
                        hintText: "Email Address")),
                SizedBox(height: 16),
                TextField(
                    controller: passwrodController,
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
                    child: FloatingActionButton(
                      child: Icon(Icons.arrow_forward),
                      backgroundColor: mainColor,
                      onPressed: () {},
                    ),
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
    );
  }
}
