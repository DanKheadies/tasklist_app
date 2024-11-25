import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tasklist_app/add_item_screen.dart';
import 'package:tasklist_app/change_password_screen.dart';
import 'package:tasklist_app/chat_room_screen.dart';
import 'package:tasklist_app/custom_provider.dart';
import 'package:tasklist_app/file_upload_screen.dart';
import 'package:tasklist_app/landing.dart';
import 'package:tasklist_app/lists_screen.dart';
import 'package:tasklist_app/recipes_screen.dart';
import 'package:tasklist_app/settings_screen.dart';
import 'package:tasklist_app/sign_in.dart';
import 'package:tasklist_app/sign_up.dart';
import 'package:tasklist_app/view_list_screen.dart';

CustomProvider customProvider = CustomProvider();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChannels.textInput.invokeMethod('TextInput.hide');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CustomProvider()),
      ],
      child: MaterialApp(
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
          '/recipes': (context) => const RecipesScreen(),
          '/file-upload': (context) => const FileUploadScreen(),
          '/chat-room': (context) => const ChatRoomScreen(),
          '/settings': (context) => const SettingsScreen(),
          '/change-password': (context) => const ChangePasswordScreen(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
