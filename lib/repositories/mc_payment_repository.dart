/*
*  mc_payment_repository.dart
*
*  Created by Yakub Pasha.
*  Copyright © 2020 Tara.id. All rights reserved.
*/

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:tara_app/data/user_local_data_source.dart';
import 'package:tara_app/models/auth/auth_response.dart';
import 'package:tara_app/models/core/base_response.dart';
import 'package:tara_app/models/mcpayment/card_data.dart';
import 'package:tara_app/models/mcpayment/create_card_or_pay_request.dart';
import 'package:tara_app/models/mcpayment/create_card_or_payment_response.dart';
import 'package:tara_app/models/mcpayment/pay_card_request.dart';
import 'package:tara_app/services/error/failure.dart';
import 'package:tara_app/services/rest/mcpayment_rest_client.dart';
import 'package:tara_app/services/rest/rest_client.dart';
import 'package:tara_app/services/util/network_info.dart';
import 'package:tara_app/common/constants/values.dart';

abstract class McPaymentRepository {
  Future<Either<Failure,List<CardData>>> getCards();
  Future<Either<Failure,BaseResponse>> deleteCard(String cardToken);
  Future<Either<Failure,CreateCardOrPaymentResponse>> createCardOrPay(CreateCardOrPayRequest createCardOrPayRequest); // Add Credit Card(just pass customer Id ) and Pay Via Credit Card by passing the registerId(mcPaymentCardId) and transaction info
  Future<Either<Failure,CreateCardOrPaymentResponse>> payWithCreditCard(PayCardRequest payCardRequest); // Pay Via Credit Card by passing the registerId(mcPaymentCardId)
}


class McPaymentRepositoryImpl extends McPaymentRepository{

  UserLocalDataStore userLocalDataSource;
  NetworkInfo networkInfo;
  McPaymentRestClient remoteDataSource;
  String token;

  McPaymentRepositoryImpl(this.userLocalDataSource,this.networkInfo,this.remoteDataSource);


  @override
  Future<Either<Failure, CreateCardOrPaymentResponse>> createCardOrPay(CreateCardOrPayRequest createCardOrPayRequest) async{
    AuthResponse user = await userLocalDataSource.getUser();

    token = user.securityToken.token.tara.bearer();
    var customerId = user?.customerProfile?.id?.toString();

    if(customerId?.isEmpty??false){
      return Left(Failure(message: "Please login"));
    }
    var optionalData = OptionalDataBean(customerId: customerId);
    createCardOrPayRequest.optionalData = optionalData;
    try {
      var response = await remoteDataSource.createCardOrPay(token, createCardOrPayRequest);
      return Right(response);
    }catch(e){
      return Left(Failure.fromServerError(e));
    }
  }

  @override
  Future<Either<Failure, List<CardData>>> getCards() async{

    AuthResponse user = await userLocalDataSource.getUser();

    token = user.securityToken.token.tara.bearer();
    try {
      var response = await remoteDataSource.getCards(token,user?.customerProfile?.id?.toString());
      return Right(response);
    }catch(e){
      return Left(Failure.fromServerError(e));
    }

  }

  @override
  Future<Either<Failure, BaseResponse>> deleteCard(String cardToken) async{

    AuthResponse user = await userLocalDataSource.getUser();
    token = user.securityToken.token.tara.bearer();
    try {
      var response = await remoteDataSource.deleteCard(token, cardToken);
      return Right(response);
    }catch(e){
      return Left(Failure.fromServerError(e));
    }

  }

  @override
  Future<Either<Failure, CreateCardOrPaymentResponse>> payWithCreditCard(PayCardRequest payCardRequest) async{
    AuthResponse user = await userLocalDataSource.getUser();
    token = user.securityToken.token.tara.bearer();
    try {
      var response = await remoteDataSource.payWithCard(token, payCardRequest);
      return Right(response);
    }catch(e){
      return Left(Failure.fromServerError(e));
    }
  }




}