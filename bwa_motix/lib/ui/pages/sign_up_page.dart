part of 'pages.dart';

class SignUpPage extends StatefulWidget {
  final RegistrationData registrationData;
  // kita perlu parameter registration Data
  SignUpPage(this.registrationData);
  // registrationData ini akan dipakai untuk menyimpan data-data yang sudah diisi, supaya kalau back, data nya masih ke isi.
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // berikut untuk text field nya
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController retypePasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.registrationData.name;
    emailController.text = widget.registrationData.email;
  }

  @override
  Widget build(BuildContext context) {
    context
        .bloc<ThemeBloc>()
        .add(ChangeTheme(ThemeData().copyWith(primaryColor: mainColor)));

    return WillPopScope(
      onWillPop: () async {
        context.bloc<PageBloc>().add(GoToSplashPage());

        return;
      },
      child: Scaffold(
        body: Container(
          color: secondaryColor,
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: ListView(children: [
            Column(children: [
              // NOTE: tombol back ama judul Create new account
              Container(
                  margin: EdgeInsets.only(top: 20, bottom: 22),
                  height: 56,
                  child: Stack(
                    // kita pake Stack supaya judul create new account bisa di tengah dan arrow back tetap dikiri
                    children: [
                      // NOTE: Arrowback Rata kiri
                      Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                            onTap: () {
                              context.bloc<PageBloc>().add(GoToSplashPage());
                            },
                            child: Icon(Icons.arrow_back, color: Colors.black)),
                      ),
                      Center(
                          child: Text(
                        "Buat Akun\nBaru",
                        style: blackTextFont.copyWith(fontSize: 20),
                        textAlign: TextAlign.center,
                      ))
                    ],
                  )),
              // NOTE: Profile Picture
              Container(
                  width: 90,
                  height: 104,
                  child: Stack(
                    children: [
                      // NOTE: gambar nyo
                      Container(
                        height: 90,
                        width: 90,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: (widget.registrationData.profileImage ==
                                        null)
                                    ? AssetImage("assets/user_pic.png")
                                    : FileImage(
                                        widget.registrationData.profileImage),
                                fit: BoxFit.cover)),
                      ),
                      Align(
                          alignment: Alignment.bottomCenter,
                          child: GestureDetector(
                            onTap: () async {
                              // NOTE: ambil foto PP
                              if (widget.registrationData.profileImage ==
                                  null) {
                                widget.registrationData.profileImage =
                                    await getImagee();
                              } else {
                                widget.registrationData.profileImage = null;
                              }
                              setState(() {});
                            },
                            child: Container(
                              height: 36,
                              width: 36,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: AssetImage((widget.registrationData
                                                  .profileImage ==
                                              null)
                                          ? "assets/btn_add_photo.png"
                                          : "assets/btn_del_photo.png"))),
                            ),
                          ))
                    ],
                  )),
              SizedBox(height: 36),
              TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      labelText: "Nama Lengkap",
                      hintText: "Nama Lengkap")),
              SizedBox(height: 16),
              TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      labelText: "Email",
                      hintText: "Email")),
              SizedBox(height: 16),
              TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      labelText: "Password",
                      hintText: "Password")),
              SizedBox(height: 16),
              TextField(
                  controller: retypePasswordController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      labelText: "Konfirmasi Password",
                      hintText: "Konfirmasi Password")),
              SizedBox(height: 30),
              FloatingActionButton(
                  child: Icon(Icons.arrow_forward),
                  backgroundColor: mainColor,
                  elevation: 0,
                  onPressed: () {
                    if (!(nameController.text.trim() != "" &&
                        emailController.text.trim() != "" &&
                        passwordController.text.trim() != "" &&
                        retypePasswordController.text.trim() != "")) {
                      Flushbar(
                        duration: Duration(milliseconds: 1500),
                        flushbarPosition: FlushbarPosition.TOP,
                        backgroundColor: Color(0xFFFF5C83),
                        message: "Silahkan isi semua kolom",
                      )..show(context);
                    } else if (passwordController.text !=
                        retypePasswordController.text) {
                      Flushbar(
                        duration: Duration(milliseconds: 1500),
                        flushbarPosition: FlushbarPosition.TOP,
                        backgroundColor: Color(0xFFFF5C83),
                        message: "Password tidak sama silahkan coba lagi",
                      )..show(context);
                    } else if (passwordController.text.length < 6) {
                      Flushbar(
                        duration: Duration(milliseconds: 1500),
                        flushbarPosition: FlushbarPosition.TOP,
                        backgroundColor: Color(0xFFFF5C83),
                        message: "Password tidak boleh kurang dari 6 huruf",
                      )..show(context);
                    } else if (!EmailValidator.validate(emailController.text)) {
                      Flushbar(
                        duration: Duration(milliseconds: 1500),
                        flushbarPosition: FlushbarPosition.TOP,
                        backgroundColor: Color(0xFFFF5C83),
                        message: "Format Email salah",
                      )..show(context);
                    } else {
                      widget.registrationData.name = nameController.text;
                      widget.registrationData.email = emailController.text;
                      widget.registrationData.password =
                          passwordController.text;
                      context
                          .bloc<PageBloc>()
                          .add(GoToPreferencePage(widget.registrationData));
                      // pindah page + bawa data yg disimpin.
                    }
                  })
            ])
          ]),
        ),
      ),
    );
  }
}
