import 'package:amar_shoday/features/language/language_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';

class LanguageToggleButton extends ConsumerWidget {
  const LanguageToggleButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocale = ref.watch(languageNotifierProvider);

    return IconButton(
      icon: Icon(
        currentLocale.languageCode == 'en' ? Icons.language : Icons.translate,
        color: Colors.white,
      ),
      onPressed: () {
        // Toggle Riverpod state
        ref.read(languageNotifierProvider.notifier).toggleLanguage();

        // Update EasyLocalization as well
        final newLocale = ref.read(languageNotifierProvider);
        context.setLocale(newLocale);
      },
    );
  }
}
