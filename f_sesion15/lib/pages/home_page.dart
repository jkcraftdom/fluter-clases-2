import 'package:f_sesion15/providers/launcher_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LauncherProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Url Launcher'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                provider.activeMenu();
              },
              icon: const Icon(Icons.menu))
        ],
      ),
      body: Stack(children: [
        const Center(
          child: Text(
            'Feliz Navidad',
            style: TextStyle(fontSize: 50),
          ),
        ),
        Visibility(
            visible: provider.isVisible,
            child: Align(
              alignment: Alignment.centerRight,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.green.withOpacity(0.3)),
                height: MediaQuery.of(context).size.height * 0.6,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FloatingActionButton(
                        onPressed: (() {
                          provider.goMapLauncher();
                        }),
                        backgroundColor: Colors.purple,
                        child: const Icon(Icons.map),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FloatingActionButton(
                        onPressed: (() {
                          provider.goEmailLauncher();
                        }),
                        backgroundColor: Colors.amber,
                        child: const Icon(Icons.email),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FloatingActionButton(
                        onPressed: (() {
                          provider.goBrowerLauncher();
                        }),
                        backgroundColor: Colors.red,
                        child: const Icon(Icons.play_arrow),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FloatingActionButton(
                        onPressed: (() {
                          provider.goPhoneLauncher();
                        }),
                        backgroundColor: Colors.lightBlue,
                        child: const Icon(Icons.phone),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FloatingActionButton(
                        onPressed: (() {
                          provider.goWhatsappLauncher();
                        }),
                        backgroundColor: Colors.green,
                        child: const Icon(Icons.whatsapp),
                      ),
                    ),
                  ],
                ),
              ),
            ))
      ]),
    );
  }
}
