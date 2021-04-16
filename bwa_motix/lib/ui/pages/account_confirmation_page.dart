part of 'pages.dart';

class AccountConfirmationPage extends StatefulWidget {
  final RegistrationData registrationData;

  AccountConfirmationPage(this.registrationData);

  @override
  _AccountConfirmationPageState createState() =>
      _AccountConfirmationPageState();
}

class _AccountConfirmationPageState extends State<AccountConfirmationPage> {
  bool isSigninUp = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          context
              .bloc<PageBloc>()
              .add(GoToPreferencePage(widget.registrationData));
          return;
        },
        child: Scaffold(
            body: Container(
          color: secondaryColor,
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: ListView(
            children: [
              Column(
                children: [
                  // NOTE: tombol back ama judul Create new account
                  Container(
                      margin: EdgeInsets.only(top: 20, bottom: 90),
                      height: 56,
                      child: Stack(
                        // kita pake Stack supaya judul create new account bisa di tengah dan arrow back tetap dikiri
                        children: [
                          // NOTE: Arrowback Rata kiri
                          Align(
                            alignment: Alignment.centerLeft,
                            child: GestureDetector(
                                onTap: () {
                                  context.bloc<PageBloc>().add(
                                      GoToPreferencePage(
                                          widget.registrationData));
                                },
                                child: Icon(Icons.arrow_back,
                                    color: Colors.black)),
                          ),
                          Center(
                              child: Text(
                            "Konfirmasi \nAkun Baru",
                            style: blackTextFont.copyWith(fontSize: 20),
                            textAlign: TextAlign.center,
                          ))
                        ],
                      )),
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image:
                                (widget.registrationData.profileImage == null)
                                    ? AssetImage("assets/user_pic.png")
                                    : FileImage(
                                        widget.registrationData.profileImage))),
                  ),
                  SizedBox(height: 30),
                  Text("Selamat Datang",
                      style: blackTextFont.copyWith(fontSize: 20)),
                  Text(
                    "${widget.registrationData.name}",
                    style: blackTextFont.copyWith(
                        fontSize: 25, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 130),
                  (isSigninUp)
                      ? SpinKitFadingCircle(
                          color: mainColor,
                        )
                      : SizedBox(
                          width: 250,
                          height: 50,
                          child: RaisedButton(
                              color: mainColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text("Buat Akun Saya",
                                  style: whiteTextFont.copyWith(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              onPressed: () async {
                                setState(() {
                                  isSigninUp = true;
                                });

                                // nitip gambar untuk di upload setelah daftar dan ke homescreen agar tidak memakan waktu yang lama

                                imageFileToUpload =
                                    widget.registrationData.profileImage;

                                SignInSignUpResult result =
                                    await AuthServices.signUp(
                                        widget.registrationData.email,
                                        widget.registrationData.password,
                                        widget.registrationData.name,
                                        widget.registrationData.selectedGenres,
                                        widget.registrationData.selectedLang);

                                if (result.user == null) {
                                  setState(() {
                                    isSigninUp = false;
                                  });

                                  Flushbar(
                                    duration: Duration(milliseconds: 1500),
                                    flushbarPosition: FlushbarPosition.TOP,
                                    backgroundColor: Color(0xFFFF5C83),
                                    message: result.message,
                                  )..show(context);
                                }
                              }))
                ],
              )
            ],
          ),
        )));
  }
}
