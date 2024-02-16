import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taxis_app_public/Core/controllers/users_controllers.dart';
import 'package:taxis_app_public/Core/riverpod/declarations.dart';
import 'package:taxis_app_public/shared/widgets.dart';

class AuthPage extends ConsumerStatefulWidget {
  const AuthPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AuthPageState();
}

class _AuthPageState extends ConsumerState<AuthPage> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 50, bottom: 30),
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            decoration: gradient(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                topText(),
                const SizedBox(height: 80),
                dosisText('Inicio se sesión', fontWeight: FontWeight.bold, size: 32),
                dosisText('Por favor inicie sesión para continuar'),
                const SizedBox(height: 20),
                usernameTxtField(
                    'Nombre de usuario', Icons.person_2_outlined, Icons.text_fields_rounded, username, false, () {}),
                usernameTxtField('Contraseña de sesión', Icons.security_outlined, Icons.remove_red_eye_outlined,
                    password, obscureText, () {
                  setState(() {
                    obscureText = !obscureText;
                  });
                }),
                Padding(
                  padding: const EdgeInsets.only(right: 10, top: 10),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: dosisText('Olvidaste la contraseña?', fontWeight: FontWeight.bold),
                  ),
                ),
                btnLogin(),
                const Spacer(),
                questionAccount()
              ],
            ),
          ),
        ));
  }

  AbsorbPointer btnLogin() {
    final btnManager = ref.watch(btnManagerR);
    final btnManagerM = ref.read(btnManagerR.notifier);

    return AbsorbPointer(
      absorbing: btnManager,
      child: Container(
        width: double.infinity,
        decoration: (!btnManager) ? gradientBtn() : BoxDecoration(color: Colors.grey[200]),
        height: 50,
        margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: const BorderSide(
                color: Colors.transparent,
              ),
            ),
            onPressed: () {
              try {
                btnManagerM.state = true;

                final userCrtl = UserControllers();
                String txtusername = username.text;
                String txtpassword = password.text;

                if (txtusername == '' || txtpassword == '') {
                  showToast('Falta información para crear la cuenta. Rectifique por favor');
                  btnManagerM.state = false;
                  return;
                }

                userCrtl.login(txtusername, txtpassword).then((value) {
                  if (value) {
                    Navigator.pushReplacementNamed(context, 'maps_screen');
                  }
                });
                btnManagerM.state = false;
              } catch (e) {
                btnManagerM.state = false;
              }
            },
            child: dosisText((!btnManager) ? 'Acceder' : 'Espere por favor...',
                size: 23, fontWeight: FontWeight.bold, color: Colors.black87)),
      ),
    );
  }

  Container usernameTxtField(String hintText, IconData? prefixIcon, IconData? suffixIcon,
      TextEditingController? controller, bool obscureText, void Function()? onPressed) {
    return Container(
      width: double.infinity,
      height: 50,
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TextField(
          controller: controller,
          obscureText: obscureText,
          cursorColor: Colors.grey,
          style: const TextStyle(fontFamily: 'Dosis', fontSize: 18),
          decoration: InputDecoration(
            hintStyle: const TextStyle(
              fontFamily: 'Dosis',
            ),
            hintText: hintText,
            prefixIcon: Icon(prefixIcon, color: Colors.grey),
            suffixIcon: IconButton(onPressed: onPressed, icon: Icon(suffixIcon, color: const Color(0xFFffa500))),
            border: InputBorder.none,
          )),
    );
  }

  RichText topText() {
    return RichText(
      textAlign: TextAlign.left,
      text: const TextSpan(
        style: TextStyle(fontSize: 30, color: Colors.black, fontFamily: 'Dosis'),
        children: <TextSpan>[
          TextSpan(
            text: 'Viaje con ',
          ),
          TextSpan(
            text: 'Rapidez y Confort \n',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: 'Descubre la ',
          ),
          TextSpan(
            text: 'Mejor Manera \n',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: 'de hacerlo',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }

  RichText questionAccount() {
    return RichText(
      textAlign: TextAlign.left,
      text: TextSpan(
        style: const TextStyle(fontSize: 20, color: Colors.black, fontFamily: 'Dosis'),
        children: <TextSpan>[
          const TextSpan(text: 'Aún no tiene cuenta? ', style: TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(
            text: 'Regístrate',
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.pushNamed(context, 'register_page');
              },
            style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFffa500)),
          )
        ],
      ),
    );
  }

  BoxDecoration gradient() {
    return const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        colors: [Color.fromARGB(255, 95, 95, 97), Color.fromARGB(255, 116, 168, 101), Color(0xFFF5C454)],
      ),
    );
  }

  BoxDecoration gradientBtn() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      gradient: const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [Color(0xFFF5C454), Color(0xFFFDA13A)],
      ),
    );
  }
}
