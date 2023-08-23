import 'package:breed_challenge/app_binding.dart';
import 'package:breed_challenge/app_widget.dart';
import 'package:breed_challenge/features/data/datasources/local/database_helper_datasource.dart';
import 'package:flutter/material.dart';

void main() async {
  setUpBinding();
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelperDataSource.instance.database;
  runApp(const AppWidget());
}
