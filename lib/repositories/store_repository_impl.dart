import 'package:dartz/dartz.dart';
import 'package:tara_app/data/user_local_data_source.dart';
import 'package:tara_app/models/core/base_response.dart';
import 'package:tara_app/models/order_management/store/store.dart';
import 'package:tara_app/repositories/stores_repository.dart';
import 'package:tara_app/services/error/failure.dart';
import 'package:tara_app/services/rest_client.dart';
import 'package:tara_app/services/util/network_info.dart';

class StoreRepositoryImpl extends StoresRepository{
  UserLocalDataStore userLocalDataSource;
  NetworkInfo networkInfo;
  RestClient remoteDataSource;
  String token;

  StoreRepositoryImpl(this.userLocalDataSource,this.networkInfo,this.remoteDataSource);

  @override
  Future<Either<Failure, Store>> createStore(Store store)  async{
    try {
      var response = await remoteDataSource.createStore(token, store);
      return Right(response);
    }catch(e){
      return Left(Failure.fromServerError(e));
    }
  }
  @override
  Future<Either<Failure, BaseResponse>> deleteStore(String id) async{
    try {
      var response = await remoteDataSource.deleteStore(token, id);
      return Right(response);
    }catch(e){
      return Left(Failure.fromServerError(e));
    }
  }

  @override
  Future<Either<Failure, List<Store>>> getAllStores() async{
    try {
      var response = await remoteDataSource.getAllStores(token);
      return Right(response);
    }catch(e){
      return Left(Failure.fromServerError(e));
    }
  }
  @override
  Future<Either<Failure, Store>> getStore(String storeId) async{
    try {
      var response = await remoteDataSource.getStore(token, storeId);
      return Right(response);
    }catch(e){
      return Left(Failure.fromServerError(e));
    }
  }
  @override
  Future<Either<Failure, Store>> setStatus(String storeId, String status)async{
    try {
      var response = await remoteDataSource.setStatus(token, storeId,status);
      return Right(response);
    }catch(e){
      return Left(Failure.fromServerError(e));
    }
  }

  @override
  Future<Either<Failure, Store>> updateStore(Store store) async{
    try {
      var response = await remoteDataSource.updateStore(token, store);
      return Right(response);
    }catch(e){
      return Left(Failure.fromServerError(e));
    }
  }
}