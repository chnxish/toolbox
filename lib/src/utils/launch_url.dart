import 'package:url_launcher/url_launcher.dart' as url_launcher;

Future<void> launchUrl(String url) async {
  final Uri u = Uri.parse(url);

  if (!await url_launcher.launchUrl(u)) {
    throw Exception('Could not launch $u');
  }
}
