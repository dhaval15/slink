import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'screens/screens.dart';

class SlinkApp extends StatelessWidget {
  const SlinkApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
			child:MaterialApp(
				initialRoute: Screens.login,
				debugShowCheckedModeBanner: false,
				onGenerateRoute: const ScreenRouteGenerator(),
			),
		);
  }
}
