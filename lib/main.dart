import 'package:flutter/material.dart';
import './screens/chat_screen.dart';
import './screens/auth_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FirebaseApp>(
      future: Firebase.initializeApp(),
      builder: (ctx, snapshot) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
            primarySwatch: Colors.pink,
            colorScheme: ColorScheme.fromSwatch(
              primarySwatch: Colors.pink,
              accentColor: Colors.deepPurple,
              backgroundColor: Colors.deepPurple,
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
              ),
            ),
            iconTheme: const IconThemeData(
              color: Colors.pink,
            )),
        home: snapshot.connectionState == ConnectionState.done
            ? StreamBuilder(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (_, snp) => snp.hasData ? ChatScreen() : AuthScreen(),
              )
            : Container(),
      ),
    );
  }
}
