
import 'package:flutter/material.dart';
import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:day_night_switcher/day_night_switcher.dart';

import 'MyTheme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});



  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      initTheme: MyTheme.defaultTheme,
      builder: (_, theme) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo Login',
          theme: theme,
          home: const MyHomePage(title: 'Connexion'),
        );
      },
    );
  }
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});



  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final formkey=GlobalKey<FormState>();
  final String emailPattern=r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  bool isDark = false;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var isLoading = false;







  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: ThemeSwitcher(
              builder: (context) => DayNightSwitcherIcon(
                  isDarkModeEnabled: isDark,
                  onStateChanged: (val) {
                    setState(() {
                      isDark = val;
                      isDark
                          ? ThemeSwitcher.of(context)
                          .changeTheme(theme: MyTheme.darkTheme)
                          : ThemeSwitcher.of(context)
                          .changeTheme(theme: MyTheme.defaultTheme);
                    });
                  }),
            ),
          )
        ],
      ),
      body:Form(
        key: formkey,
          child: Padding(padding: EdgeInsets.all(20),
            child: Column(
              children:<Widget> [
                TextFormField(

                    keyboardType:
                    TextInputType.emailAddress,
                  decoration: InputDecoration(hintText: 'me@exemple.com',labelText: 'Adresse email'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'veuillez saisir votre adresse email';
                    }
                    RegExp regExp=new RegExp(emailPattern);
                    if(!regExp.hasMatch(value))
                    {
                      return "veuillez saisir une adresse email valide.";
                    }

                  },
                ),
                TextFormField(obscureText: true,
                decoration:
                  InputDecoration(hintText: '***',labelText: 'Mot de passe'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'veuillez saisir votre mot de passe ';
                    }
                    return null;
                  },

                ),
                Container(
                  child: ElevatedButton(onPressed:() {
                    // Validate returns true if the form is valid, or false otherwise.
                    if (formkey.currentState!.validate()) {
          // If the form is valid, display a snackbar. In the real world,
          // you'd often call a server or save the information in a database.
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Processing Data')),);}}, child: const Text('Submit'),),

                  ),

              ],

            ),
          ),

      ),

    );
  }

  
}


