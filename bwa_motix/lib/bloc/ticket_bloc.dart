import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bwa_motix/models/models.dart';
import 'package:bwa_motix/services/services.dart';
import 'package:equatable/equatable.dart';

part 'ticket_event.dart';
part 'ticket_state.dart';

// ticket bloc ini berfungsi untuk menyimpan state dari ticket yang kita beli.
// kalo di ecommerce ini bisa dibilang "keranjang belanja".

class TicketBloc extends Bloc<TicketEvent, TicketState> {
  @override
  TicketState get initialState => TicketState([]);

  @override
  Stream<TicketState> mapEventToState(
    TicketEvent event,
  ) async* {
    if (event is BuyTicket) {
      await TicketServices.saveTicket(event.userID, event.ticket);

      List<Ticket> tickets = state.tickets + [event.ticket];

      yield TicketState(tickets);
    } else if (event is GetTickets) {
      List<Ticket> tickets = await TicketServices.getTickets(event.userID);

      yield TicketState(tickets);
    }
  }
}
