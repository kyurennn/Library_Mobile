import 'package:library_mobile/data/models/event_model.dart';

// Data dummy kabar & acara (sementara, sebelum terhubung ke API)
class EventDummy {
  EventDummy._();

  static const List<EventItem> events = [
    EventItem(
      month: 'MEI',
      day: '18',
      category: 'KLUB BUKU',
      title: "Diskusi Novel 'Bumi' karya Tere Liye",
      locationAndTime: 'Ruang Diskusi Komunitas • 10:00 WIB',
    ),
    EventItem(
      month: 'OCT',
      day: '01',
      category: 'KLUB BUKU',
      title: 'Happy Halloween',
      locationAndTime: 'Main Lobby • 14:00 WIB',
    ),
    EventItem(
      month: 'OCT',
      day: '21',
      category: 'KLUB BUKU',
      title: 'English Debate Competition',
      locationAndTime: 'Main Lobby • 12:00 WIB',
    ),
  ];
}