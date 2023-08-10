import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'screens.dart';
import '../providers/providers.dart';

class LoginScreen extends HookConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hostController = useTextEditingController();
    final tokenController = useTextEditingController();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Slink',
              style: TextStyle(
                fontSize: 32.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: hostController,
              decoration: const InputDecoration(
                labelText: 'Host',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: tokenController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'API Token',
              ),
            ),
            const SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () async{
								final provider = ref.read(credentialProvider.notifier);
								final host = hostController.text.toString();
								final token = tokenController.text.toString();
								if(await provider.login(host, token)){
									// ignore: use_build_context_synchronously
									Navigator.of(context).pushReplacementNamed(Screens.home);
								}
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}

