part of 'pages.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      // kalau mau pake listview, maka elemen nya itu otomatis dibawah statusbar. akalin warna statusbar jadi mainColor
      // ngakalin nya pake container
      children: [
        Container(color: mainColor),
        SafeArea(
            child: Container(
                color: Color(
                    0xFFF6F7F9))), // safearea untuk seluruh isi dibawah statusbar
        ListView(),
        createCustomBottomNavBar(), // buat widget sendiri, cek aja dibawah cara buat widget nya.
        Align(
            // floating action button di tengah nya
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 47,
              width: 47,
              margin: EdgeInsets.only(bottom: 42),
              child: FloatingActionButton(
                elevation: 0,
                backgroundColor: mainColor,
                child: SizedBox(
                    height: 30,
                    width: 30,
                    child: Icon(MdiIcons.walletPlus,
                        color: Colors.white.withOpacity(0.98))),
              ),
            ))
      ],
    ));
  }

  Widget createCustomBottomNavBar() => Align(
        alignment: Alignment.bottomCenter,
        child: ClipPath(
          clipper: BottomNavbarClipper(),
          child: Container(
            height: 70,
            decoration: BoxDecoration(
                color: secondaryColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
          ),
        ),
      );
}

class BottomNavbarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(size.width / 2 - 28, 0);
    path.quadraticBezierTo(size.width / 2 - 28, 33, size.width / 2, 33);
    path.quadraticBezierTo(size.width / 2 + 28, 33, size.width / 2 + 28, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
