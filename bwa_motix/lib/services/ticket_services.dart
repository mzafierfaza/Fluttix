part of 'services.dart';

// Ticket Services ini berfungsi untuk men save ticket dan get ticket dari firebase.
// karena ticket yang sudah dibeli oleh user akan di save ke dala database.
// supaya pas kita buka aplikasi ,kita juga bisa mendapatkan history dari ticket yg dibeli
//

class TicketServices {
  static CollectionReference ticketCollection =
      Firestore.instance.collection('tickets');

  static Future<void> saveTicket(String id, Ticket ticket) async {
    await ticketCollection.document().setData({
      // data yang akan disimpan
      'movieID': ticket.movieDetail.id ?? "", // movie id dari tmdb
      'userID': id ?? "", // ID user
      'theaterName': ticket.theater.name ?? 0, // nama bioskop
      'time': ticket.time.millisecondsSinceEpoch ?? // waktu pemesanan tiket,
          DateTime.now()
              .millisecondsSinceEpoch, // yang disave dalam firebase adalah int
      'bookingCode': ticket.bookingCode, // booking code
      'seats': ticket
          .seatsInString, // tempat duduk masih berbentuk list ada koma2 nya
      'name': ticket.name, // nama user.
      'totalPrice': ticket.totalPrice // total harga
    });
  }

  // method get ticket, kembaliannya list of ticket
  static Future<List<Ticket>> getTickets(String userId) async {
    QuerySnapshot snapshot = await ticketCollection.getDocuments();
    // ^ ambil dokumen terlebih dahulu
    var documents = snapshot.documents
        .where((document) => document.data['userID'] == userId);
    // lalu query, ambil ticket yang sesuai dengan ID nya user.

    List<Ticket> tickets = [];
    for (var document in documents) {
      MovieDetail movieDetail = await MovieServices.getDetails(null,
          movieID: document.data['movieID']);
      tickets.add(Ticket(
          movieDetail,
          Theater(document.data['theaterName']),
          DateTime.fromMillisecondsSinceEpoch(document.data['time']),
          document.data['bookingCode'],
          document.data['seats'].toString().split(','),
          document.data['name'],
          document.data['totalPrice']));
    }

    return tickets;
  }
}
