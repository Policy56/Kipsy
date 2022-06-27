import 'package:get_it/get_it.dart';
import 'package:kipsy/core/services/db.dart';
import 'package:kipsy/features/add_house/data/data_source/add_existing_houses_local_data_source.dart';
import 'package:kipsy/features/add_house/data/data_source/add_houses_local_data_source.dart';
import 'package:kipsy/features/add_house/data/repository/add_existing_house_repository_impl.dart';
import 'package:kipsy/features/add_house/data/repository/add_house_repository_impl.dart';
import 'package:kipsy/features/add_house/domain/repositiory/add_existing_house_repository.dart';
import 'package:kipsy/features/add_house/domain/repositiory/add_house_repository.dart';
import 'package:kipsy/features/add_house/domain/use_case/add_existing_house_use_case.dart';
import 'package:kipsy/features/add_house/domain/use_case/add_house_use_case.dart';
import 'package:kipsy/features/add_list/data/data_source/add_tasks_local_data_source.dart';
import 'package:kipsy/features/add_list/data/repository/add_list_repository_impl.dart';
import 'package:kipsy/features/add_list/domain/repositiory/add_list_repository.dart';
import 'package:kipsy/features/add_list/domain/use_case/add_list_use_case.dart';
import 'package:kipsy/features/add_task/data/data_source/add_tasks_local_data_source.dart';
import 'package:kipsy/features/add_task/data/repository/add_task_repository_impl.dart';
import 'package:kipsy/features/add_task/domain/repositiory/add_task_repository.dart';
import 'package:kipsy/features/add_task/domain/use_case/add_task_use_case.dart';
import 'package:kipsy/features/show_task/data/data_source/show_houses_local_data_source.dart';
import 'package:kipsy/features/show_task/data/data_source/show_listes_of_house_local_data_source.dart';
import 'package:kipsy/features/show_task/data/data_source/show_tasks_local_data_source.dart';
import 'package:kipsy/features/show_task/data/repository/show_houses_repository_impl.dart';
import 'package:kipsy/features/show_task/data/repository/show_lists_of_house_repository_impl.dart';
import 'package:kipsy/features/show_task/data/repository/show_tasks_repository_impl.dart';
import 'package:kipsy/features/show_task/domain/repositiory/show_houses_repository.dart';
import 'package:kipsy/features/show_task/domain/repositiory/show_listes_of_house_repository.dart';
import 'package:kipsy/features/show_task/domain/repositiory/show_tasks_repository.dart';
import 'package:kipsy/features/show_task/domain/use_case/all_houses_use_case.dart';
import 'package:kipsy/features/show_task/domain/use_case/all_tasks_use_case.dart';
import 'package:kipsy/features/show_task/domain/use_case/delete_house_use_case.dart';
import 'package:kipsy/features/show_task/domain/use_case/delete_listes_of_house_use_case.dart';
import 'package:kipsy/features/show_task/domain/use_case/delete_task_use_case.dart';
import 'package:kipsy/features/show_task/domain/use_case/get_list_of_house_use_case.dart';
import 'package:kipsy/features/show_task/domain/use_case/get_task_of_list_use_case.dart';
import 'package:kipsy/features/show_task/domain/use_case/update_house_use_case.dart';
import 'package:kipsy/features/show_task/domain/use_case/update_listes_of_house_use_case.dart';

import 'features/show_task/domain/use_case/update_task_use_case.dart';

final sl = GetIt.I;

Future<void> init() async {
  //Use case
  sl.registerLazySingleton(() => AddTaskUseCase(sl()));
  sl.registerLazySingleton(() => AddListUseCase(sl()));
  sl.registerLazySingleton(() => AddHouseUseCase(sl()));
  sl.registerLazySingleton(() => AddExistingHouseUseCase(sl()));

  sl.registerLazySingleton(() => AllTasksUseCase(sl()));
  sl.registerLazySingleton(() => GetTaskOfListUseCase(sl()));
  sl.registerLazySingleton(() => DeleteTaskUseCase(sl()));
  sl.registerLazySingleton(() => UpdateTaskUSeCase(sl()));

  sl.registerLazySingleton(() => AllHousesUseCase(sl()));
  //sl.registerLazySingleton(() => const ShareHouseUseCase());
  sl.registerLazySingleton(() => DeleteHouseUseCase(sl()));
  sl.registerLazySingleton(() => UpdateHouseUseCase(sl()));

  sl.registerLazySingleton(() => GetListOfHousesUseCase(sl()));
  sl.registerLazySingleton(() => DeleteListesOfHouseUseCase(sl()));
  sl.registerLazySingleton(() => UpdateListesOfHouseUseCase(sl()));

  //Repository
  sl.registerLazySingleton<AddTaskRepository>(
      () => AddTaskRepositoryImpl(localSource: sl()));

  sl.registerLazySingleton<AddListRepository>(
      () => AddListRepositoryImpl(localSource: sl()));

  sl.registerLazySingleton<AddHouseRepository>(
      () => AddHouseRepositoryImpl(localSource: sl()));

  sl.registerLazySingleton<AddExistingHouseRepository>(
      () => AddExistingHouseRepositoryImpl(localSource: sl()));

  sl.registerLazySingleton<ShowTasksOfListesRepository>(
      () => ShowTasksOfListesRepositoryImpl(sl()));

  sl.registerLazySingleton<ShowListesOfHouseRepository>(
      () => ShowListesOfHouseRepositoryImpl(sl()));

  sl.registerLazySingleton<ShowHouseRepository>(
      () => ShowHouseRepositoryImpl(sl()));

  //Data Source
  sl.registerLazySingleton<AddTasksLocalDataSource>(
      () => AddTasksLocalDataSourceImpl(sl()));
  sl.registerLazySingleton<AddListsLocalDataSource>(
      () => AddListsLocalDataSourceImpl(sl()));
  sl.registerLazySingleton<AddHousesLocalDataSource>(
      () => AddHousesLocalDataSourceImpl(sl()));
  sl.registerLazySingleton<AddExistingHousesLocalDataSource>(
      () => const AddExistingHousesLocalDataSourceImpl());

  sl.registerLazySingleton<ShowTasksOfListesLocalDataSource>(
      () => ShowTaskLocalDataSourceImpl(sl()));

  sl.registerLazySingleton<ShowHouseLocalDataSource>(
      () => ShowHouseLocalDataSourceImpl(sl()));

  sl.registerLazySingleton<ShowListesOfHouseLocalDataSource>(
      () => ShowListesOfHouseLocalDataSourceImpl(sl()));

  //Data base
  sl.registerLazySingleton(() => DbService());
}
