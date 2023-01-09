import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher_string.dart';

class LauncherProvider extends ChangeNotifier {
  bool isVisible = false;

  void activeMenu() {
    (isVisible == false) ? (isVisible = true) : (isVisible = false);
    notifyListeners();
  }

  void goMapLauncher() async {
    String url = 'https://goo.gl/maps/oJGPBKDhkKzTJdNy6';
    String urlEncode = Uri.encodeFull(url);
    if (await canLaunchUrlString(urlEncode)) {
      await launchUrlString(urlEncode, mode: LaunchMode.externalApplication);
    }
  }

  void goEmailLauncher() async {
    String email = 'fluter@gmail.com';
    String subject = 'Regalos NAvidad';
    String msg = 'Tus regalos estan en camino';

    String urlEncode =
        Uri.encodeFull('mailto:$email?subject=$subject&body=$msg');

    if (await canLaunchUrlString(urlEncode)) {
      await launchUrlString(urlEncode, mode: LaunchMode.externalApplication);
    }
  }

  void goBrowerLauncher() async {
    String url = 'https://youtube.com';
    String urlEncode = Uri.encodeFull(url);

    if (await canLaunchUrlString(urlEncode)) {
      await launchUrlString(urlEncode, mode: LaunchMode.externalApplication);
    }
  }

  void goPhoneLauncher() async {
    String phone = '+519999999';
    String url = 'tel:$phone';

    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    }
  }

  void goWhatsappLauncher() async {
    String phone = '+51999999';
    String msg = 'Feliz navidad!';
    String urlEncode = Uri.encodeFull('https://wa.me/$phone?text=$msg');

    if (await canLaunchUrlString(urlEncode)) {
      await launchUrlString(urlEncode, mode: LaunchMode.externalApplication);
    }
  }
}
