import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:tara_app/controller/order_controller.dart';
import 'package:tara_app/controller/store_controller.dart';
import 'package:tara_app/data/user_local_data_source.dart';
import 'package:tara_app/models/order_management/store/store.dart';
import 'package:tara_app/models/order_management/store/store_owner.dart';
import 'package:tara_app/models/order_management/store/store_type_model.dart';
import 'package:tara_app/repositories/stores_repository.dart';
import 'package:tara_app/services/error/failure.dart';
import 'package:tara_app/services/rest/order_rest_client.dart';
import 'package:tara_app/services/util/network_info.dart';
import 'package:tara_app/models/auth/auth_response.dart';
import 'package:tara_app/common/constants/values.dart';

class StoreRepositoryImpl extends StoresRepository {
  UserLocalDataStore userLocalDataSource;
  NetworkInfo networkInfo;
  OrderRestClient remoteDataSource;
  String token;

  StoreRepositoryImpl(
      this.userLocalDataSource, this.networkInfo, this.remoteDataSource);

  @override
  Future<Either<Failure, Owner>> createOwner(Owner owner) async {
    AuthResponse user = await userLocalDataSource.getUser();
    token = user.securityToken.token.tara.bearer();
    try {
      var response = await remoteDataSource.createOwner(token, owner);
      return Right(response);
    } catch (e) {
      return Left(Failure.fromServerError(e));
    }
  }

  @override
  Future<Either<Failure, Store>> createStore(Store store) async {
    AuthResponse user = await userLocalDataSource.getUser();
    token = user.securityToken.token.tara.bearer();
    try {
      var response = await remoteDataSource.createStore(token, store);
      return Right(response);
    } catch (e) {
      return Left(Failure.fromServerError(e));
    }
  }
  /*@override
  Future<Either<Failure, BaseResponse>> deleteStore(String id) async{
    try {
     // var response = await remoteDataSource.deleteStore(token, id);
     // return Right(response);
    }catch(e){
     // return Left(Failure.fromServerError(e));
    }
  }*/

  @override
  Future<Either<Failure, List<Store>>> getAllStores() async {
    try {
      print("token");
      print("gettt");
      // AuthResponse user = await userLocalDataSource.getUser();
      // token = user.securityToken.token.tara.bearer();
      // var response = await remoteDataSource.getAllStores(token);
      var response = await remoteDataSource.getAllStores();
      return Right(response);
    } catch (e, stacktrace) {
      print(stacktrace);
      return Left(Failure.fromServerError(e));
    }
  }

  @override
  Future<Either<Failure, List<StoreTypeModel>>> getStoreTypes() async {
    AuthResponse user = await userLocalDataSource.getUser();
    token = user.securityToken.token.tara.bearer();
    try {
      var response = await remoteDataSource.getStoreTypes(token);

      // to save store types in singleton object
      var storeTypes = StoreTypeResponse();
      storeTypes.storeTypesList = response;

      OrderController ctl = Get.find();
      ctl.storeTypesList = response;
      Get.put(ctl);

      return Right(response);
    } catch (e) {
      return Left(Failure.fromServerError(e));
    }
  }
  /* @override
  Future<Either<Failure, Store>> getStore(String storeId) async{
    try {
     // var response = await remoteDataSource.getStore(token, storeId);
     // return Right(response);
    }catch(e){
     // return Left(Failure.fromServerError(e));
    }
  }*/
  /* @override
  Future<Either<Failure, Store>> setStatus(String storeId, String status)async{
    try {
     // var response = await remoteDataSource.setStatus(token, storeId,status);
     // return Right(response);
    }catch(e){
     // return Left(Failure.fromServerError(e));
    }
  }*/

  /*@override
  Future<Either<Failure, Store>> updateStore(Store store) async{
    try {
      var response = await remoteDataSource.updateStore(token, store);
      return Right(response);
    }catch(e){
      return Left(Failure.fromServerError(e));
    }
  }
*/
}
