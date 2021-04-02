part of 'pages.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FirebaseUser firebaseUser = Provider.of<FirebaseUser>(context);
    // wrapper akan mendapatkan firebaseUser nya, dari status yang saat ini.
    // jika ada perubahan status, maka method build ini akan di panggil kembali.
    // dan dari sana kita akan menentukan apa yang akan kita return.

    // semakin banyak page, maka akan lebih mudah jika kita menggunakan page bloc.
    // buat page bloc untuk mengatur state dari page
    // buat juga user bloc untuk mengatur user nya
    if (firebaseUser == null) {
      // kalau firebase null / belum login maka diarahkan ke sign in page
      if (!(prevPageEvent is GoToSplashPage)) {
        prevPageEvent = GoToSplashPage();
        context.bloc<PageBloc>().add(prevPageEvent);
      }
    } else {
      if (!(prevPageEvent is GoToMainPage)) {
        context.bloc<UserBloc>().add(LoadUser(firebaseUser.uid));
        prevPageEvent = GoToMainPage();
        context.bloc<PageBloc>().add(prevPageEvent);
      }
    }
    // kan status firebase auth otomatis kasih tau ke aplikasi ini, jadi dakbiso ngontrol kapan dio ngasih kapan dio idak
    // jadi galak ado kasus firebase auth lebih dari 1x ngirim state yg sama, jadi aplikasi secara otomatis ke page itu 2x
    // jadi solusi nyo catat letak dari page sebelumnyo, supayo dak pindah page yg samo 2x.

    // ini nih tempat mengatur nyaa
    return BlocBuilder<PageBloc, PageState>(
        builder: (_, pageState) => (pageState is OnSplashPage)
            ? SplashPage()
            : (pageState is OnLoginPage)
                ? SignInPage()
                : MainPage());
  }
}
