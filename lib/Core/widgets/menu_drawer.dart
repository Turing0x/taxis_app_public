import 'package:flutter/material.dart';
import 'package:taxis_app_public/Core/pages/About_us_screen.dart';
import 'package:taxis_app_public/Core/pages/history_screen.dart';
import 'package:taxis_app_public/Core/pages/profile_screen.dart';
import 'package:taxis_app_public/Core/pages/referido_screen.dart';
import 'package:taxis_app_public/Core/pages/settings_screen.dart';
import 'package:taxis_app_public/Core/pages/wallet_screen.dart';

class MenuDrawer extends StatefulWidget {
  const MenuDrawer({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MenuDrawerState createState() => _MenuDrawerState();
}

class _MenuDrawerState extends State<MenuDrawer> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<Offset> slideAnimation;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 450),
    );
    slideAnimation = Tween<Offset>(begin: const Offset(0.0, -5.0), end: const Offset(0, -0.85))
        .animate(CurvedAnimation(parent: controller, curve: Curves.decelerate));
    controller.addListener(() {
      setState(() {});
    });
    controller.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: slideAnimation,
      child: const MDrawer(),
    );
  }
}

class MDrawer extends StatelessWidget {
  const MDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(13.0),
      height: MediaQuery.of(context).size.height / 2.7,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 255, 255, 255),
      ),
      child: Drawer(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text('Menú'),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    _MenuButtom(
                        icon: const Icon(Icons.person),
                        text: 'Perfil',
                        function: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ProfileScreen(),
                              ));
                        }),
                    _MenuButtom(
                        icon: const Icon(Icons.wallet),
                        text: 'Billetera',
                        function: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const WalletScreen(),
                              ));
                        }),
                    _MenuButtom(
                      icon: const Icon(Icons.settings),
                      text: 'Opciones',
                      function: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SettingScreen(),
                            ));
                      },
                    )
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.07,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    _MenuButtom(
                        icon: const Icon(Icons.history),
                        text: 'Historial',
                        function: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HistoryScreen(),
                              ));
                        }),
                    _MenuButtom(
                        icon: const Icon(Icons.face_retouching_natural),
                        text: 'Referidos',
                        function: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ReferidoScreen(),
                              ));
                        }),
                    _MenuButtom(
                      icon: const Icon(Icons.question_mark),
                      text: 'Acerca De',
                      function: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AboutUsScreen(),
                            ));
                      },
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _MenuButtom extends StatelessWidget {
  final Icon icon;
  final String text;
  final Function function;
  const _MenuButtom({
    required this.icon,
    required this.text,
    required this.function,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        function();
      },
      icon: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            icon,

            Text(text), // Usa el texto que desees
          ],
        ),
      ),
    );
  }
}
