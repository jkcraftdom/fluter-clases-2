import 'package:f_sesion12/providers/storage_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<StorageProvider>(context);
    return Scaffold(
      backgroundColor: Colors.orange,
      appBar: AppBar(
        title: Text('Storage'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () {
              provider.activeCleanImage();
            },
            icon: Icon(Icons.delete),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              onTap: () {
                provider.activeGalleryImage();
              },
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.green,
                ),
                child: (provider.image == null
                    ? const Icon(
                        Icons.photo,
                        size: 100,
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: SizedBox.fromSize(
                          size: const Size.fromRadius(48),
                          child: Image.file(
                            provider.image!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      )),
              ),
            ),
            SizedBox(
              width: 120,
              height: 50,
              child: MaterialButton(
                  onPressed: () {
                    provider.activeCamaraImage();
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  color: Colors.green,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [Icon(Icons.camera), Text('Camara')],
                  )),
            ),
            SizedBox(
              width: 120,
              height: 50,
              child: MaterialButton(
                  onPressed: () {
                    // provider.saveApi();
                    provider.alertCustom(context);
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  color: Colors.green,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [Icon(Icons.save), Text('Guardar')],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
