import 'package:flutter/material.dart';
import 'package:prestige_valet_app/features/social_auth/presentation/cubit/social_auth_cubit.dart';
import 'package:qr_flutter/qr_flutter.dart';

class SocialAuthScreen extends StatelessWidget {
  const SocialAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: QrImageView(
        data: 'malekmamoon341@gmail.com',
        version: QrVersions.auto,
        size: 150,
        gapless: false,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await SocialAuthCubit.get(context).encryptUserId(
            userId: '15',
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
