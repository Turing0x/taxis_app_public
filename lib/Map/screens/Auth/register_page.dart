import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taxis_app_public/Core/controllers/users_controllers.dart';
import 'package:taxis_app_public/Core/riverpod/declarations.dart';
import 'package:taxis_app_public/shared/widgets.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {

  TextEditingController fullname = TextEditingController();
  TextEditingController email = TextEditingController();
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

              const SizedBox(height: 70),
                
              dosisText('Regístrate', fontWeight: FontWeight.bold, size: 32),
              dosisText('Por favor cree su cuenta para continuar'),
                
              const SizedBox(height: 20),
              usernameTxtField(
                'Nombre completo',
                Icons.person_2_outlined,
                Icons.text_fields_rounded,
                fullname, false, (){}
              ),
                
              usernameTxtField(
                'Correo electrónico',
                Icons.email_outlined,
                Icons.alternate_email_sharp,
                email, false, (){}
              ),
                
              usernameTxtField(
                'Nombre de usuario',
                Icons.person_2_outlined,
                Icons.text_fields_rounded,
                username, false, (){}
              ),
                
              usernameTxtField(
                'Contraseña de sesión',
                Icons.security_outlined,
                Icons.remove_red_eye_outlined,
                password,
                obscureText,
                () {setState(() {
                  obscureText = !obscureText;
                });}
              ),
                
              btnRegister(),
                
              const Spacer(),
              questionAccount()
                
            ],
                
          ),
        
        ),
      )

    );

  }

  AbsorbPointer btnRegister() {

    final btnManager = ref.watch(btnManagerR);
    final btnManagerM = ref.read(btnManagerR.notifier);

    return AbsorbPointer(
      absorbing: btnManager,
      child: Container(
        width: double.infinity,
        decoration: ( !btnManager ) ? gradientBtn() : BoxDecoration(color: Colors.grey[200]),
        height: 50,
        margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            side: const BorderSide(
              color: Colors.transparent,
            ),
          ),
          onPressed: () async{
      
            try {
              
              btnManagerM.state = true;
      
              final userCrtl = UserControllers();
      
              String fullnameTxt = fullname.text;
              String emailTxt = email.text;
              String usernameTxt = username.text;
              String passwordTxt = password.text;
      
              if( fullnameTxt == '' || emailTxt == '' || usernameTxt == '' || passwordTxt == '' ){
                showToast('Falta información para crear la cuenta. Rectifique por favor');
                return;
              }
      
              if( !emailValidator(emailTxt) ){
                showToast('El correo electrónico es incorrecto. Rectifíquelo por favor');
                btnManagerM.state = false;
                return;
              }
      
              if( passwordTxt.length < 4 ) {
                showToast('Escriba una contraseña más segura por favor');
                btnManagerM.state = false;
                return;
              }
      
              // await userCrtl.saveUser(fullnameTxt, emailTxt, usernameTxt, passwordTxt);

              FocusScope.of(context).unfocus();
              btnManagerM.state = false;
      
            } catch (e) { btnManagerM.state = false; }
      
          }, 
          child: dosisText( ( !btnManager ) ? 'Crear cuenta' : 'Creando la cuenta...', size: 23,
            fontWeight: FontWeight.bold, color: Colors.black87))
      ),
    );
  }

  RichText topText() {
    return RichText(
      textAlign: TextAlign.left,
      text: const TextSpan(
        style: TextStyle(
            fontSize: 30, 
            color: Colors.black,
            fontFamily: 'Dosis'
          ),
        children: <TextSpan>[
          TextSpan(
            text: 'Empieza tu viaje con\n',
          ),
          TextSpan(
            text: 'la excelencia que mereces',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }

  Container usernameTxtField(
    String hintText, 
    IconData? prefixIcon, 
    IconData? suffixIcon, 
    TextEditingController? controller,
    bool obscureText,
    void Function()? onPressed) {
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
          hintStyle: const TextStyle(fontFamily: 'Dosis', ),
          hintText: hintText,
          prefixIcon : Icon(prefixIcon, color : Colors.grey),
          suffixIcon : IconButton(
            onPressed: onPressed,
            icon: Icon(suffixIcon, color : const Color(0xFFffa500))),
          border : InputBorder.none,
        )
      ),
    );
  }

  RichText questionAccount() {
    return RichText(
      textAlign: TextAlign.left,
      text: TextSpan(
        style: const TextStyle(
            fontSize: 20, 
            color: Colors.white,
            fontFamily: 'Dosis'
          ),
        children: <TextSpan>[
          const TextSpan(
            text: 'Ya tienes una cuenta? ',
            style: TextStyle(
              fontWeight: FontWeight.bold
            )
          ),
          TextSpan(
            text: 'Inicia sesión',
            recognizer: TapGestureRecognizer()..onTap = () {
              Navigator.pushNamed(context, 'auth_page');
            },
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFFffa500)
            ),
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
        colors: [
          Color.fromARGB(255, 95, 95, 97),
          Color.fromARGB(255, 116, 168, 101),
          Color(0xFFF5C454)
        ],
      ),
    );
  }

  BoxDecoration gradientBtn() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      gradient: const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          Color(0xFFF5C454),
          Color(0xFFFDA13A)
        ],
      ),
    );
  }

  bool emailValidator( String email ){
    final RegExp emailValidator = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailValidator.hasMatch(email);
  }

}