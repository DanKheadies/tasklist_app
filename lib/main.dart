import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tasklist_app/add_item_screen.dart';
import 'package:tasklist_app/landing.dart';
import 'package:tasklist_app/lists_screen.dart';
import 'package:tasklist_app/sign_in.dart';
import 'package:tasklist_app/sign_up.dart';
import 'package:tasklist_app/view_list_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChannels.textInput.invokeMethod('TextInput.hide');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tasklist App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const Landing(),
        '/sign-in': (context) => const SignIn(),
        '/sign-up': (context) => const SignUp(),
        '/lists': (context) => const ListsScreen(),
        ViewListScreen.routeName: (context) => const ViewListScreen(),
        AddItemScreen.routeName: (context) => const AddItemScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
