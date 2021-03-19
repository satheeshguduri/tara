
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:tara_app/common/widgets/snackbars.dart';
import 'package:tara_app/models/order_management/catalogue_category/catalogue.dart';
import 'package:tara_app/models/order_management/item/item.dart';
import 'package:tara_app/models/order_management/store/banner_data.dart';
import 'package:tara_app/models/order_management/store/store.dart';
import 'package:tara_app/models/order_management/store/store_type_model.dart';
import 'package:tara_app/services/error/failure.dart';
import 'package:tara_app/repositories/stores_repository.dart';
import '../injector.dart';
import 'package:tara_app/repositories/order_repository.dart';
import 'package:tara_app/models/order_management/catalogue_category/category.dart';






class StoreController extends GetxController{

  List<Store> arrStores;
  String storeId;
  var itemsList = List<Item>().obs;
  var filteredList = List<Item>().obs;
  var bannersList = List<BannerData>().obs;
  var categoryList = List<Category>().obs;
  var catalogues = List<Catalogue>().obs;
  var catalogueId = "".obs;
  var showProgress = false.obs;


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


 void getCategories() async{
   var response = await getIt.get<OrderRepository>().getCategories();
   if(response.isRight()) {
      response.getOrElse(() => null);
   }
   response.fold((l) => print(l.message), (r) => {
     categoryList.value =r,
     print(r),
   });
    print(response);
  }

    void  getBanners() async{
    var response = await getIt.get<OrderRepository>().getBanners("41825412");
    if(response.isRight()) {
       response.getOrElse(() => null);
    }
    response.fold((l) => print(l.message), (r) => {
      bannersList.value =r,
      print(r),
    });
    print(response);
  }

  void getCatalogue() async {
    var response = await getIt.get<OrderRepository>().getBanners("41825412");
    if (response.isRight()) {
      response.getOrElse(() => null);
    }
    response.fold(
            (l) => print(l.message),
            (r) => {
          bannersList.value = r,
          print(r),
        });
    print(response);
  }


  void getItems(String storeId) async{
    var response = await getIt.get<OrderRepository>().getItemsByCatalogue(storeId);

    if(response.isRight()) {
      response.getOrElse(() => null);
    }
    response.fold((l) => print(l.message), (r) => {
      itemsList.value=r,
      print(r),
    });
    print(response);
  }
}