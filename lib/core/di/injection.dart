import 'package:get_it/get_it.dart';
import 'package:smart_todo/core/di/bloc_injection.dart';
import 'package:smart_todo/core/di/data_source_injection.dart';
import 'package:smart_todo/core/di/repository_injection.dart';
import 'package:smart_todo/core/di/service_injection.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  registerDataSources();
  registerRepositories();
  registerBlocs();
  registerServices();
}
