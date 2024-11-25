import 'package:flutter/material.dart';
import 'package:tasklist_app/func.dart';
import 'package:tasklist_app/main.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> with Func {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Column(
        children: [
          const CircleAvatar(
            backgroundColor: Colors.purple,
            radius: 50,
          ),
          ListTile(
            title: const Text(
              'Your Name',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
                fontWeight: FontWeight.w800,
              ),
            ),
            subtitle: Text(
              customProvider.user['name'],
            ),
          ),
          Card(
            child: ListTile(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      icon: const CircleAvatar(
                        radius: 30,
                        child: Icon(
                          Icons.delete_forever,
                          size: 30,
                        ),
                      ),
                      content: const Text(
                        'Are you sure you want to delete your account?',
                      ),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            deleteUserUsingBasic(customProvider.user['id']);
                            Navigator.pushNamed(context, "/");
                          },
                          child: const Text('Yes'),
                        ),
                        OutlinedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Cancel'),
                        ),
                      ],
                    );
                  },
                );
              },
              title: const Text('Delete Account'),
              trailing: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ),
          ),
          Card(
            child: ListTile(
              onTap: () {
                Navigator.pushNamed(context, '/change-password');
              },
              title: const Text('Change Password'),
              trailing: const Icon(
                Icons.edit,
                color: Colors.purple,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              setLoginStatus(0);
              Navigator.pushNamed(context, '/sign-in');
            },
            child: const Text('Log out'),
          ),
        ],
      ),
    );
  }
}
