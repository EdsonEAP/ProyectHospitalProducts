import 'package:app2/src/Pages/login/bloc/bloclogin.dart';
import 'package:app2/src/Pages/registro/registro.dart';
import 'package:app2/src/Preferences/preferences.dart';
import 'package:app2/src/widget/classGeneral.dart';
import 'package:app2/src/widget/widgets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  static const String name = "LoginView";

  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

TextEditingController userController = TextEditingController();
TextEditingController passController = TextEditingController();
LoginBloc loginBloc = LoginBloc();
final prefs = PreferenciasUsuario();
int animated = 1;
bool isChecked = false;

class _LoginViewState extends State<LoginView> {
  @override
  void initState() {
    if (prefs.guardadoUserAndPassword == true) {
      userController.text = prefs.user;
      passController.text = prefs.password;
      isChecked = prefs.guardadoUserAndPassword;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
          child: Stack(
        children: [
          Opacity(
            opacity: 0.3,
            // child: Image(
            //   image: AssetImage('assets/icon/doctor.jpg'),
            //   width: size.width,
            //   height: size.height,
            //   fit: BoxFit.cover,
            // ),
          ),
          Container(
            height: size.height * 1,
            width: size.width * 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: size.height * 0.15,
                  child: Image.asset(
                    'assets/icon/logofarmacia.png',
                    fit: BoxFit.contain,
                  ),
                ),
                // SizedBox(
                //   height: size.height * 0.05,
                // ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                SizedBox(height: size.height * 0.11),
                WidgetsRepetidos().inputLogin(
                    active: true,
                    seleccione: "Usuario",
                    oculto: false,
                    controlador: userController),
                WidgetsRepetidos().inputLogin(
                    active: true,
                    seleccione: "Contraseña",
                    oculto: true,
                    controlador: passController),
                SizedBox(height: size.height * 0.01),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                        child: Text(
                      "Recordarme",
                      style: TextStyle(
                          color: General.grissApp,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    )),
                    Checkbox(
                        activeColor: Colors.black,
                        value: isChecked,
                        onChanged: (value) {
                          setState(() {
                            isChecked = value!;
                            print(isChecked);
                          });
                        }),
                  ],
                ),
                SizedBox(height: size.height * 0.01),
                Container(
                  margin: const EdgeInsets.only(left: 70, right: 70, bottom: 0),
                  child: streamBotonReactive(context),
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                Container(
                  child: Center(
                    child: RichText(
                      text: TextSpan(
                        text: "¿No tienes cuenta? ",
                        style: TextStyle(
                          color: General.grissApp,
                          fontSize: 12,
                        ),
                        children: [
                          TextSpan(
                            text: "Regístrate",
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 12,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushNamed(context, RegistroView.name);
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}

streamBotonReactive(context) {
  final size = MediaQuery.of(context).size;
  return StreamBuilder<String>(
    initialData: "INGRESAR",
    stream: loginBloc.botonLoginS,
    builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
      if (snapshot.data == "INGRESAR") {
        animated = 1;
      } else if (snapshot.data == "ERROR") {
        animated = 2;
      }
      return AnimatedContainer(
        padding: const EdgeInsets.symmetric(vertical: 10),
        width: size.width * 0.5 / animated,
        curve: Curves.fastOutSlowIn,
        duration: const Duration(seconds: 2),
        child: InkWell(
          onTap: () => {
            prefs.emailSave = userController.text,
            prefs.user = userController.text,
            prefs.password = passController.text,
            prefs.guardadoUserAndPassword = isChecked,
            loginBloc.requestLogin(context,
                user: userController.text, pass: passController.text),
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            width: size.width * 0.5,
            decoration: BoxDecoration(
              color: General.colorApp,
              borderRadius: BorderRadius.circular(30),
            ),
            child: snapshot.data == "INGRESAR"
                ? Center(
                    child: Text(
                      snapshot.data ?? '',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                      ),
                    ),
                  )
                : Center(
                    child: const CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  ),
          ),
        ),
      );
    },
  );
}
