
import '../model/DashboardModel.dart';

class CardDetails {
  final cardData = const [
    DashboardModel(
        icon: 'assets/home.png',  title: "Settings"),
    DashboardModel(
        icon: 'assets/stock.png',  title: "StockAdjustment"),
    DashboardModel(
        icon: 'assets/distance.png',  title: "ServerSynchronization"),
    DashboardModel(icon: 'assets/sleep.png', title: "ItemModelUpdate"),
  ];
}
