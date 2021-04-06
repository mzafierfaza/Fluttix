part of 'shared.dart';

const double defaultMargin = 24;

Color mainColor = Color(0xFF457AAB); // biru
Color mainColorOld = Color(0xFF23629D); // biru gelep
Color secondaryColor = Color(0xFFFBD460); // kuning
Color accentColorGrey = Color(0xFFADADAD); // abu2

TextStyle blackTextFont = GoogleFonts.nunitoSans()
    .copyWith(color: Colors.black, fontWeight: FontWeight.w500);

TextStyle whiteTextFont = GoogleFonts.nunitoSans()
    .copyWith(color: Colors.white, fontWeight: FontWeight.w500);

TextStyle blueTextFont = GoogleFonts.nunitoSans()
    .copyWith(color: mainColor, fontWeight: FontWeight.w500);

TextStyle greyTextFont = GoogleFonts.nunitoSans()
    .copyWith(color: accentColorGrey, fontWeight: FontWeight.w500);

TextStyle yellowTextFont = GoogleFonts.nunitoSans()
    .copyWith(color: secondaryColor, fontWeight: FontWeight.w500);
