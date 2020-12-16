
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:tara_app/models/order_management/store/store.dart';
import 'package:tara_app/models/order_management/store/store_type_model.dart';
import 'package:tara_app/services/error/failure.dart';
import 'package:tara_app/repositories/stores_repository.dart';
import '../injector.dart';


class StoreController extends GetxController{

  List<Store> arrStores;
  Future getAllStoreTypes() async{
    Either<Failure,List<StoreTypeModel>> response = await getIt.get<StoresRepository>().getStoreTypes();
    response.fold((l) => print(l.message), (r) => {
      Get.put(r),
    });
  }

  Future getAllStore() async{
    Either<Failure,List<Store>> response = await getIt.get<StoresRepository>().getAllStores();
    response.fold((l) => print(l.message), (r) => {
      arrStores = r,
    });
  }
}