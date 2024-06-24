import 'package:get_it/get_it.dart';
import 'package:homework_statemangment_1/service/cat_service.dart';

GetIt core = GetIt.instance;

void init() {
  core.registerSingleton(CatServiceImp());
}
