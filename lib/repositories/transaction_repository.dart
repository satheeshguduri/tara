/*
*  auth_repository.dart
*
*  Created by Yakub Pasha.
*  Copyright © 2020 Tara.id. All rights reserved.
*/
import 'package:dartz/dartz.dart';
import 'package:tara_app/data/user_local_data_source.dart';
import 'package:tara_app/models/core/base_response.dart';
import 'package:tara_app/models/transactions/transaction_model.dart';
import 'package:tara_app/services/error/failure.dart';
import 'package:tara_app/services/transaction_rest_client.dart';
import 'package:tara_app/services/util/network_info.dart';
import 'package:tara_app/models/auth/auth_response.dart';
import 'package:tara_app/common/constants/values.dart';


abstract class TransactionRepository {

  Future<Either<Failure,BaseResponse>> sendMoney(TransactionModel transactionModel);
  Future<Either<Failure,BaseResponse>> updateSendRequest(TransactionModel transactionModel);

}

class TransactionRepositoryImpl implements TransactionRepository{

  UserLocalDataStore userLocalDataSource;
  NetworkInfo networkInfo;
  TransactionRestClient remoteDataSource;
  String token;

  TransactionRepositoryImpl(this.userLocalDataSource,this.networkInfo,this.remoteDataSource);

  @override
  Future<Either<Failure,BaseResponse>> sendMoney(TransactionModel transactionModel) async {
    AuthResponse user = await userLocalDataSource.getUser();
    token = user.securityToken.token.tara.bearer();
    try {
      var response = await remoteDataSource.sendMoney(token, transactionModel);
      return Right(response);
    }catch(e ){
      return Left(Failure.fromServerError(e));
    }
  }

  @override
  Future<Either<Failure,BaseResponse>> updateSendRequest(TransactionModel transactionModel) async{
    AuthResponse user = await userLocalDataSource.getUser();
    token = user.securityToken.token.tara.bearer();
    try {
      var response = await remoteDataSource.updateSendRequest(token, transactionModel);
      return Right(response);
    }catch(e ){
      return Left(Failure.fromServerError(e));
    }
  }

}

