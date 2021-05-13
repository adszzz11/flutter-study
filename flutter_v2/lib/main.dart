import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_v2/pages/auth_page.dart';
import 'package:flutter_v2/pages/my_home.dart';
import 'package:flutter_v2/provider/page_notifier.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PageNotifier()),
      ],
      child: MaterialApp(
          title: 'FlutterAuth Demo',
          home: Consumer<PageNotifier>(
            builder: (context, pageNotifier, child) {
              return Navigator(
                onPopPage: (route, result) {
                  if (!route.didPop(result)) return false;
                  return true;
                },
                pages: [
                  AuthPage(),
                  if (pageNotifier.currentPage == MyHomePage.pageName)
                    MaterialPage(
                        key: ValueKey(AuthPage.pageName),
                        child: MyHomePage(
                            title: FirebaseAuth.instance.currentUser.email)),
                ],
              );
            },
          )),
    );
  }
}
