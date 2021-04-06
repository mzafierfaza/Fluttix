part of 'pages.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 136,
            decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage("assets/logo.png"))),
          ),
          Container(
            margin: EdgeInsets.only(top: 70, bottom: 16),
            child: Text(
              "N",
              style: blackTextFont.copyWith(fontSize: 20),
            ),
          )
        ],
      )),
    );
  }
}
