import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:musync/ui/on_boarding/provider/google_sign_in.dart';
import 'package:musync/widgets/icon_buttons.dart';
import 'package:provider/provider.dart';

class MusicDashboard extends StatefulWidget {
  const MusicDashboard({Key? key}) : super(key: key);

  @override
  State<MusicDashboard> createState() => _MusicDashboardState();
}

class _MusicDashboardState extends State<MusicDashboard> {
  User? currentUser; // define a nullable User object

  @override
  void initState() {
    super.initState();
    // check if user is already logged in when widget is created
    currentUser = FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Music Dashboard'),
        toolbarHeight: 150,
        actions: [
          if (currentUser == null)
            IconButtons(
              icon: "assets/icons/google.png",
              onPressed: () {
                // handle login with Google
                final provider =
                    Provider.of<GoogleSignInProvider>(context, listen: false);
                provider.googleLogin();
                setState(() {
                  currentUser = FirebaseAuth.instance.currentUser;
                });
              },
            ),
          if (currentUser != null)
            IconButton(
              onPressed: () {
                // handle logout
                FirebaseAuth.instance.signOut().then((value) {
                  setState(() {
                    currentUser = null;
                  });
                });
              },
              icon: const Icon(Icons.logout),
            ),
        ],
      ),
      body: const Placeholder(),
    );
  }
}
