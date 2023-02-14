
import 'package:intl/intl.dart';

var dateFormat =DateFormat("dd MMMM, yyyy");

String AppName="Age Calculate";
String AppDescription="Discover exactly how old you are and how many days there are until you next  birthday.";

DateTime selectedBithDate = DateTime.now().subtract(Duration(days: 1));
DateTime selectedCurrentDate = DateTime.now();