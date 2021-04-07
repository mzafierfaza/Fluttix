part of 'pages.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      body: Container(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          margin: EdgeInsets.only(top: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 136,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage("assets/logo.png"),
                )),
              ),
              Container(
                margin: EdgeInsets.only(top: 70, bottom: 26),
                child: Text(
                  "Hai Moviegoers! ",
                  style: blueTextFont.copyWith(
                      fontSize: 22.5, fontWeight: FontWeight.bold),
                ),
              ),
              Center(
                child: Text(
                  "Moviegoers dapat memebeli tiket\ndan mencari informasi film hanya dalam satu aplikasi!",
                  style: blackTextFont.copyWith(
                      fontSize: 18, fontWeight: FontWeight.w300),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                height: 46,
                width: 260,
                margin: EdgeInsets.only(top: 70, bottom: 16),
                child: RaisedButton(
                  child: Text(
                    "Mulai",
                    style: whiteTextFont.copyWith(fontSize: 18),
                  ),
                  color: mainColor,
                  onPressed: () {},
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Sudah punya akun?, ",
                      style: blackTextFont.copyWith(fontSize: 16)),
                  GestureDetector(
                      onTap: () {
                        context.bloc<PageBloc>().add(GoToLoginPage());
                      },
                      child: Text("Sign In",
                          style: blueTextFont.copyWith(fontSize: 16)))
                ],
              )
            ],
          )),
    );
  }
}
