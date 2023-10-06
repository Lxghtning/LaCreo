import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../Screens/calender.dart';
import '../Screens/notices.dart';
import '../Screens/profile.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});


  Future<void> navigateToProfile(context) async {
    Navigator.push(
        context,
        PageTransition(
          child: const Profile(),
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 500),
        ));
  }

  Future<void> navigateToCourseRoot(context) async {
    Navigator.push(
        context,
        PageTransition(
          child: const Notices(),
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 500),
        ));
  }
  Future<void> navigateToAboutUs(context) async {
    Navigator.push(
        context,
        PageTransition(
          child: const Calender(),
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 500),
        ));
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    String? name = FirebaseAuth.instance.currentUser?.displayName == null
        ? "N/A"
        : FirebaseAuth.instance.currentUser!.displayName.toString();
    String email = user!.email != null ? user.email.toString() : "N/A";
    return Drawer(
      backgroundColor:Theme.of(context).colorScheme.primaryContainer,
      child: ListView(
        // Remove padding
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(name),
            accountEmail: Text(email),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.asset(
                  'images/X_CODE.jpg',
                  fit: BoxFit.cover,
                  width: 90,
                  height: 90,
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
            ),
          ),
          ListTile(

            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            onTap: () => navigateToProfile(context),
          ),
          ListTile(

            leading: const Icon(Icons.book_online),
            title: const Text('Courses'),
            onTap: () => navigateToCourseRoot(context),
          ),
          ListTile(

            leading: const Icon(Icons.question_mark),
            title: const Text('FAQ'),
            onTap: () => null,
          ),
          ListTile(

            leading: const Icon(Icons.abc),
            title: const Text('About Us'),
            onTap: () => navigateToAboutUs(context),
          ),
          //ListTile(
          //
          //             title: const Text('Log Out'),
          //             leading: const Icon(Icons.exit_to_app),
          //             onTap: () {
          //               navigatorKey.currentState!.popUntil((route) => route.isFirst);
          //               FirebaseAuth.instance.signOut();
          //             },
          //           ),
        ],
      ),
    );
  }
}