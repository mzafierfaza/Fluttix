part of 'pages.dart';

class PreferencePage extends StatefulWidget {
  final List<String> genres = [
    "Horror",
    "Music",
    "Action",
    "Drama",
    "Crime",
    "War",
  ];

  final List<String> languages = [
    "Bahasa",
    "Korean",
    "English",
    "Japanesse",
  ];

  final RegistrationData registrationData;

  // registration data disini dioper dari SignUpPage.
  PreferencePage(this.registrationData);

  @override
  _PreferencePageState createState() => _PreferencePageState();
}

class _PreferencePageState extends State<PreferencePage> {
  List<String> selectedGenres = [];
  String selectedLanguage = "English"; // english sebagai default

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        widget.registrationData.password = "";
        context.bloc<PageBloc>().add(GoToRegistrationPage(
            widget.registrationData)); // mundur sambil bawak data
        return;
      },
      child: Scaffold(
        body: Container(
          color: secondaryColor,
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      height: 56,
                      margin: EdgeInsets.only(top: 20, bottom: 6),
                      child: GestureDetector(
                          onTap: () {
                            widget.registrationData.password = "";
                            context.bloc<PageBloc>().add(
                                GoToRegistrationPage(widget.registrationData));
                          },
                          child: Icon(Icons.arrow_back))),
                  Text("Pilih Genre \nFavorite Kamu!",
                      style: blackTextFont.copyWith(fontSize: 20)),
                  SizedBox(height: 16),
                  // buat Genre nyo, spayo biso turun ke bawah cakitu Pake Wrap
                  Wrap(
                    spacing: 24, // jarak antara elemen
                    runSpacing: 24,
                    children: generateGenreWidgets(context),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Film dengan Bahasa\nYang Kamu Sukai",
                    style: blackTextFont.copyWith(fontSize: 20),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Wrap(
                    spacing: 24,
                    runSpacing: 24,
                    children: generateLangWidgets(context),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: FloatingActionButton(
                        elevation: 0,
                        backgroundColor: mainColor,
                        child: Icon(Icons.arrow_forward),
                        onPressed: () {
                          if (selectedGenres.length != 4) {
                            Flushbar(
                              duration: Duration(milliseconds: 1500),
                              flushbarPosition: FlushbarPosition.TOP,
                              backgroundColor: Color(0xFFFF5C83),
                              message: "Please select 4 genres",
                            )..show(context);
                          } else {
                            widget.registrationData.selectedGenres =
                                selectedGenres;
                            widget.registrationData.selectedLang =
                                selectedLanguage;

                            context.bloc<PageBloc>().add(
                                GoToAccountConfirmationPage(
                                    widget.registrationData));
                          }
                        }),
                  ),
                  SizedBox(
                    height: 50,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  // membuat method genre widget
  List<Widget> generateGenreWidgets(BuildContext context) {
    double width =
        (MediaQuery.of(context).size.width - 2 * defaultMargin - 24) / 2;

    return widget.genres
        .map((e) => SelectableBox(
              e,
              width: width,
              isSelected: selectedGenres.contains(e),
              onTap: () {
                onSelectGenre(e);
              },
            ))
        .toList();
  }

  List<Widget> generateLangWidgets(BuildContext context) {
    double width =
        (MediaQuery.of(context).size.width - 2 * defaultMargin - 24) / 2;

    return widget.languages
        .map((e) => SelectableBox(
              e,
              width: width,
              isSelected: selectedLanguage == e,
              onTap: () {
                setState(() {
                  selectedLanguage = e;
                });
              },
            ))
        .toList();
  }

  void onSelectGenre(String genre) {
    if (selectedGenres.contains(genre)) {
      setState(() {
        selectedGenres.remove(genre);
      });
    } else {
      if (selectedGenres.length < 4) {
        setState(() {
          selectedGenres.add(genre);
        });
      }
    }
  }
}
