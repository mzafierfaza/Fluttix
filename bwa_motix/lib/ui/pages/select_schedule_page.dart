part of 'pages.dart';

class SelectSchedulePage extends StatefulWidget {
  final MovieDetail movieDetail;
  // MovieDetail ini kita butuhkan untuk kita pasang ke dalam tiketnya
  //
  SelectSchedulePage(this.movieDetail);

  @override
  _SelectSchedulePageState createState() => _SelectSchedulePageState();
}

class _SelectSchedulePageState extends State<SelectSchedulePage> {
  List<DateTime> dates;
  DateTime selectedDate;
  int selectedTime;
  Theater selectedTheater;
  bool isValid = false; // untuk cek apakah kita sudah pilih tanggal dan waktu

  @override
  void initState() {
    super.initState();

    dates =
        List.generate(7, (index) => DateTime.now().add(Duration(days: index)));
    selectedDate = dates[0];
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.bloc<PageBloc>().add(GoToMovieDetailPage(widget.movieDetail));

        return;
      },
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              color: secondaryColor,
            ),
            SafeArea(
                child: Container(
              color: Colors.white,
            )),
            ListView(
              children: <Widget>[
                // NOTE: BACK BUTTON
                Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 20, left: defaultMargin),
                      padding: EdgeInsets.all(1),
                      child: GestureDetector(
                        onTap: () {
                          context
                              .bloc<PageBloc>()
                              .add(GoToMovieDetailPage(widget.movieDetail));
                        },
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                // NOTE: CHOOSE DATE
                Container(
                  margin:
                      EdgeInsets.fromLTRB(defaultMargin, 20, defaultMargin, 16),
                  child: Text(
                    "Choose Date",
                    style: blackTextFont.copyWith(fontSize: 20),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 24),
                  height: 90,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: dates.length,
                      itemBuilder: (_, index) => Container(
                            margin: EdgeInsets.only(
                                left: (index == 0) ? defaultMargin : 0,
                                right: (index < dates.length - 1)
                                    ? 16
                                    : defaultMargin),
                            child: DateCard(
                              dates[index],
                              isSelected: selectedDate == dates[index],
                              onTap: () {
                                setState(() {
                                  selectedDate = dates[index];
                                });
                              },
                            ),
                          )),
                ),
                // NOTE: CHOOSE TIME
                generateTimeTable(),
                // note: NEXT BUTTON
                SizedBox(
                  height: 10,
                ),
                Align(
                    alignment: Alignment.topCenter,
                    // kenapa pake userbloc bloc builder, karena button nya ketika di pencet nanti akan bawa nama user.
                    child: BlocBuilder<UserBloc, UserState>(
                      builder: (_, userState) => FloatingActionButton(
                          elevation: 0,
                          backgroundColor:
                              (isValid) ? secondaryColor : Color(0xFFE4E4E4),
                          child: Icon(
                            Icons.arrow_forward,
                            color: isValid ? Colors.white : Color(0xFFBEBEBE),
                          ),
                          onPressed: () {
                            // nah ketika di klik, dia minta Ticket beserta parameter nya.
                            if (isValid) {
                              context.bloc<PageBloc>().add(GoToSelectSeatPage(
                                  Ticket(
                                      widget.movieDetail,
                                      selectedTheater,
                                      DateTime(
                                          selectedDate.year,
                                          selectedDate.month,
                                          selectedDate.day,
                                          selectedTime),
                                      randomAlphaNumeric(12).toUpperCase(),
                                      null,
                                      (userState as UserLoaded).user.name,
                                      null)));
                            }
                          }),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }

  Column generateTimeTable() {
    List<int> schedule = List.generate(7, (index) => 10 + index * 2);
    // ^ buat schedule jam tayang dari jam 10 pagi sampai jam 10 malam dengan jeda 2 jam
    List<Widget> widgets = [];

    for (var theater in dummyTheaters) {
      // perulangan buat nampilkan nama theater
      widgets.add(Container(
          margin: EdgeInsets.fromLTRB(defaultMargin, 0, defaultMargin, 16),
          child:
              Text(theater.name, style: blackTextFont.copyWith(fontSize: 20))));

      // perulangan buat nampilkan jadwal jam tayang theater
      widgets.add(Container(
        height: 50,
        margin: EdgeInsets.only(bottom: 20),
        child: ListView.builder(
          itemCount: schedule.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, index) => Container(
            margin: EdgeInsets.only(
                left: (index == 0) ? defaultMargin : 0,
                right: (index < schedule.length - 1) ? 16 : defaultMargin),
            child: SelectableBox(
              "${schedule[index]}:00",
              height: 50,
              isSelected: // is selected akan true jika yang dipilih bioskop saat ini dan jam saat ini.
                  selectedTheater == theater && selectedTime == schedule[index],
              isEnabled: // is enabled akan true jika waktu setelah saat ini, (seperti pada bisokop biasanya)
                  schedule[index] > DateTime.now().hour ||
                      selectedDate.day != DateTime.now().day,
              onTap: () {
                setState(() {
                  selectedTheater = theater;
                  selectedTime = schedule[index];
                  isValid = true;
                });
              },
            ),
          ),
        ),
      ));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
  }
}
