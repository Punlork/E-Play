import 'package:e_book_app/bootstrap.dart';
import 'package:e_book_app/modules/app/presentation%20/app_index.dart';
import 'package:e_book_app/modules/dependencies_injection.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  await bootstrap(() => const AppIndex());
}
