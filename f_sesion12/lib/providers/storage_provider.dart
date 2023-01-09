import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:http/http.dart' as htpp;

class StorageProvider extends ChangeNotifier {
  File? image;
  String? nameImage;

  final SupabaseClient client = SupabaseClient(
      "https://sfqxztleugofniwjptbq.supabase.co",
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNmcXh6dGxldWdvZm5pd2pwdGJxIiwicm9sZSI6ImFub24iLCJpYXQiOjE2NzEwMzY3MDMsImV4cCI6MTk4NjYxMjcwM30.15cjGyHUNkoGCJajMFvM1ngvC3EU5bnK8JsX-7sCnxs");

  String urlBase = 'https://sfqxztleugofniwjptbq.supabase.co/rest/v1/producto';

  String keyDb =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNmcXh6dGxldWdvZm5pd2pwdGJxIiwicm9sZSI6ImFub24iLCJpYXQiOjE2NzEwMzY3MDMsImV4cCI6MTk4NjYxMjcwM30.15cjGyHUNkoGCJajMFvM1ngvC3EU5bnK8JsX-7sCnxs';
  String autorization =
      'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNmcXh6dGxldWdvZm5pd2pwdGJxIiwicm9sZSI6ImFub24iLCJpYXQiOjE2NzEwMzY3MDMsImV4cCI6MTk4NjYxMjcwM30.15cjGyHUNkoGCJajMFvM1ngvC3EU5bnK8JsX-7sCnxs';

  Future<String> saveApi(BuildContext context) async {
    final url = Uri.parse(urlBase);
    String msg = "";

    Map<String, String> header = {
      'apikey': keyDb,
      'Authorization': autorization,
      'Content-Type': 'application/json',
      'Prefer': 'return=minimal'
    };

    final body = jsonEncode({
      'nombre': 'grupo2',
      'decripcion': 'prueba',
      'categoria_id': 1,
      'image': nameImage
    });

    final response = await htpp.post(url, body: body, headers: header);

    if (response.statusCode != 201) {
      print(response.body);
      msg = 'NO SE GUARDADO CORRECTAMENTE';
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Icon(
                  Icons.warning,
                  color: Colors.red,
                  size: 100,
                ),
                content: Text(
                  msg,
                  textAlign: TextAlign.center,
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop('true');
                        activeCleanImage();
                      },
                      child: const Text('Aceptar')),
                ],
              ));
    } else {
      msg = "SE GUARDADO CORRECTAMENTE";
      uploadImageStorage();

      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Icon(
                  Icons.check,
                  color: Colors.green,
                  size: 100,
                ),
                content: Text(
                  msg,
                  textAlign: TextAlign.center,
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop('true');
                        activeCleanImage();
                      },
                      child: const Text('Aceptar')),
                ],
              ));
    }

    print(msg);

    return msg;
  }

  void alertCustom(BuildContext context) {
    showDialog<String>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Icon(
              Icons.notification_important,
              color: Colors.amber,
              size: 100,
            ),
            content: const Text(
              '¿Seguro de guardar?',
              textAlign: TextAlign.center,
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop('false'),
                  child: const Text('cancelar')),
              TextButton(
                  onPressed: () => Navigator.of(context).pop('true'),
                  child: const Text('Aceptar'))
            ],
          );
        }).then((value) {
      if (value == 'true') {
        saveApi(context);
      }
    });
  }

  Future uploadImageStorage() async {
    final file = File(image!.path);

    print(image!.path);

    final ruta0 = "/data/user/0/com.example.f_sesion12/cache/${nameImage}";

    final ruta1 = image!.path
        .replaceAll('/data/user/0/com.example.f_sesion12/cache', 'img');

    final ruta2 = image!.path
        .replaceAll('/data/user/0/com.example.f_sesion12/app_flutter', 'img');

    final newPath = (image!.path == ruta0) ? ruta1 : ruta2;

    final response = await client.storage.from('image').upload(newPath, file);

    notifyListeners();
  }

  Future activeCamaraImage() async {
    final imageP = await ImagePicker().pickImage(source: ImageSource.camera);

    if (imageP == null) return;

    final imageTemp = File(imageP.path);

    nameImage = imageP.name;
    this.image = imageTemp;

    notifyListeners();
  }

  Future activeGalleryImage() async {
    final imageP = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (imageP == null) return;

    final imageTemp = File(imageP.path);

    nameImage = imageP.name;
    this.image = imageTemp;

    notifyListeners();
  }

  Future activeCleanImage() async {
    image = null;
    notifyListeners();
  }
}
