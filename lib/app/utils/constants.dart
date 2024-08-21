import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:scratch_project/app/routes/app_pages.dart';

final baseUrl = "https://meet-around-apis-production.up.railway.app";
final noImagePlaceHolder =
    "https://plus.unsplash.com/premium_photo-1666899940579-6c931e34d52c?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8bm8lMjBpbWFnZXxlbnwwfHwwfHx8MA%3D%3D";

String mapToString(Map<String, dynamic> x) {
  String e = '';
  var y = x.entries.map((e) => e.value);
  for (String str in y) {
    e = e + ' $str';
  }
  return e;
}

String timeFormatter(String date) {
  // Parse the datetime string to a DateTime object
  DateTime datetime = DateTime.parse(date);

  // Format the DateTime object to get only the time part
  String formattedTime = DateFormat('h:mm a').format(datetime);
  return formattedTime;
}

var musicGeneres = [
  'Made For You',
  'New Releases',
  'Summer',
  'Country',
  'Hip-Hop',
  'La Tierra de Música Mexicana',
  'Charts',
  'Pop',
  'Latin',
  'Student',
  'Discover',
  'Rock',
  'Dance/Electronic',
  'In the car',
  'Mood',
  'Indie',
  'R&B',
  'Christian & Gospel',
  'Workout',
  'Disney'
];

var songs = [
  "1(Remastered)",
  "1(Remastered)",
  "1(Remastered)",
  "1(Remastered)",
  "1(Remastered)",
  "1(Remastered)",
  "1(Remastered)",
];

var singer = [
  "The Beatles",
  "The Beatles",
  "The Beatles",
  "The Beatles",
  "The Beatles",
  "The Beatles",
  "The Beatles",
];

var profileTabs = ["Preview", "Edit Profile"];

var musicGeners = [
  'Made For You',
  'New Releases',
  'Summer',
  'Country',
  'Hip-Hop',
  'La Tierra de Música Mexicana',
  'Charts',
  'Pop',
  'Latin',
  'Student',
  'Discover',
  'Rock',
  'Dance/Electronic',
  'In the car',
  'Mood',
  'Indie',
  'R&B',
  'Christian & Gospel',
  'Workout',
  'Disney'
];

final List<String> gender = ["Male", "Female", "Non Binary"];

final List<String> genderIcon = [
  "assets/icons/male.svg",
  "assets/icons/female.svg",
  "assets/icons/nogender.svg",
];

var musicGeners2 = [
  'Pop',
  'Rock',
  'Popular',
  'Pop',
  'Jazz',
  'Popular',
];

var settingOptions = [
  "Location",
  "Notifications",
  "Edit Profile",
  "Rate Us",
  "Help",
  "Share",
  "Delete Account",
  "Log Out",
];

var settingIcons = [
  "assets/icons/loc.svg",
  "assets/icons/not.svg",
  "assets/icons/pro.svg",
  "assets/icons/rate.svg",
  "assets/icons/help.svg",
  "assets/icons/share.svg",
  "assets/icons/del.svg",
  "assets/icons/logout.svg",
];

var settingRoutes = [
  Routes.NOTIFICATION_SCREEN,
  Routes.NOTIFICATION_SCREEN,
  Routes.PROFILE_SCREEN,
  Routes.SETTINGS_SCREEN,
  Routes.SETTINGS_SCREEN,
  Routes.SETTINGS_SCREEN,
  Routes.SETTINGS_SCREEN,
  Routes.SETTINGS_SCREEN,
];

var notficationTime = ["Now", "4h ago", "1w ago"];

var chat = ["CHAT NOW", "REPLY NOW", "REPLY NOW"];

var notifications = [
  "You are connected with Ivan. ",
  "Ivan sent you a message “Hey want to have a drink?”",
  "Ivan sent you a message “Hey want to have a drink?”"
];

var notificationImg = [
  "assets/images/notp.png",
  "assets/images/notp.png",
  "assets/images/notp.png"
];
