/*
*  bill_repository.dart
*
*  Created by Yakub Pasha.
*  Copyright © 2020 Tara.id. All rights reserved.
*/

import 'package:dartz/dartz.dart';
import 'package:tara_app/data/user_local_data_source.dart';
import 'package:tara_app/models/bills/balance_data_response.dart';
import 'package:tara_app/models/bills/bill_details_response.dart';
import 'package:tara_app/models/bills/bill_product_request.dart';
import 'package:tara_app/models/bills/bill_products_response.dart';
import 'package:tara_app/services/biller_rest_client.dart';
import 'package:tara_app/services/error/failure.dart';
import 'package:tara_app/services/util/network_info.dart';
import 'package:tara_app/models/auth/auth_response.dart';
import 'package:tara_app/common/constants/values.dart';

abstract class BillRepository {
  Future<Either<Failure,BillProductsResponse>> getBillProducts(BillProductRequest billProductRequest);
  Future<Either<Failure,BillDetailsResponse>> payBill(BillProductRequest billProductRequest);
  Future<Either<Failure,BillDetailsResponse>> checkBill(BillProductRequest billProductRequest);
  Future<Either<Failure,BillDetailsResponse>> getBillStatus(BillProductRequest billProductRequest);
  Future<Either<Failure,BalanceDataResponse>> getBalance(BillProductRequest billProductRequest);
}

class BillRepositoryImpl implements BillRepository{

  UserLocalDataStore userLocalDataSource;
  NetworkInfo networkInfo;
  BillerRestClient remoteDataSource;
  String token;

  BillRepositoryImpl(this.userLocalDataSource,this.networkInfo,this.remoteDataSource);


  Future<String> getToken() async {
    AuthResponse user = await userLocalDataSource.getUser();
    return user.securityToken.token.tara.bearer();
  }
  @override
  Future<Either<Failure, BillDetailsResponse>> checkBill(BillProductRequest billProductRequest) async{
    token = await getToken();
    try {
      var response = await remoteDataSource.checkBill(token, billProductRequest);
      return Right(response);
    }catch(e ){
      return Left(Failure.fromServerError(e));
    }
  }

  @override
  Future<Either<Failure, BalanceDataResponse>> getBalance(BillProductRequest billProductRequest) async{
    token = await getToken();
    try {
      var response = await remoteDataSource.getBalance(token, billProductRequest);
      return Right(response);
    }catch(e ){
      return Left(Failure.fromServerError(e));
    }
  }

  @override
  Future<Either<Failure, BillProductsResponse>> getBillProducts(BillProductRequest billProductRequest) async{
    token = await getToken();
    try {
      var response = await remoteDataSource.getBillProducts(token, billProductRequest);
      return Right(response);
    }catch(e ){
      return Left(Failure.fromServerError(e));
    }
  }

  @override
  Future<Either<Failure, BillDetailsResponse>> getBillStatus(BillProductRequest billProductRequest) async{
    token = await getToken();
    try {
      var response = await remoteDataSource.getBillStatus(token, billProductRequest);
      return Right(response);
    }catch(e ){
      return Left(Failure.fromServerError(e));
    }
  }

  @override
  Future<Either<Failure, BillDetailsResponse>> payBill(BillProductRequest billProductRequest) async{
    token = await getToken();
    try {
      var response = await remoteDataSource.payBill(token, billProductRequest);
      return Right(response);
    }catch(e ){
      return Left(Failure.fromServerError(e));
    }
  }

}