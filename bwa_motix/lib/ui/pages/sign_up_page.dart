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
  void InitState() {
    super.initState();
    nameController.text = widget.registrationData.name;
    emailController.text = widget.registrationData.email;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.bloc<PageBloc>().add(GoToSplashPage());

        return;
      },
      child: Scaffold(
        body: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: ListView(children: [
            Column(children: [
              // NOTE: tombol back aman judul Create new account
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
                      )
                    ],
                  ))
            ])
          ]),
        ),
      ),
    );
  }
}
