import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:picnicgarden/provider/auth_provider.dart';
import 'package:picnicgarden/provider/providers.dart';
import 'package:picnicgarden/ui/root_page.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupProviders();
  runApp(Application());
}

class Application extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Picnic Garden',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FutureBuilder(
        future: _initialization,
        builder: (_, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          }
          return ChangeNotifierProvider(
            create: (_) => providers<AuthProvider>(),
            child: RootPage(),
          );
        },
      ),
    );
  }
}
