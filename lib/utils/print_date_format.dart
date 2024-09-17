import 'package:intl/intl.dart';

String printDateTimeFormat() {
  final now = DateTime.now();
  final formatter = DateFormat('MM/dd/yyyy h:mm a');
  return formatter.format(now);
}
