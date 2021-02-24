/*
*  auth_repository.dart
*
*  Created by Yakub Pasha.
*  Copyright © 2020 Tara.id. All rights reserved.
*/
import 'package:dartz/dartz.dart';
import 'package:tara_app/models/auth/auth_request.dart';
import 'package:tara_app/models/auth/customer_profile.dart';
import 'package:tara_app/models/auth/auth_response.dart';
import 'package:tara_app/models/core/base_response.dart';
import 'package:tara_app/models/core/device/common_registration_request.dart';
import 'package:tara_app/models/transfer/customer_profile_details_response.dart';
import 'package:tara_app/services/error/failure.dart';
import 'package:tara_app/models/auth/to_address_response.dart';


abstract class AuthRepository {
  Future<Either<Failure,BaseResponse>> getOtp(AuthRequestWithData authRequestWithData);
  Future<Either<Failure,BaseResponse>> validateOtp(AuthRequestWithData authRequestWithData);
  Future<Either<Failure,AuthResponse>> login(AuthRequest authRequest);
  Future<Either<Failure,AuthResponse>> signUp(SignUpRequest signUpRequest);
  Future<Either<Failure,BaseResponse>> refreshToken(String test);
  Future<Either<Failure,CustomerProfile>> getCustomerInfoByCustomerId(String customerId);
  Future<Either<Failure,BaseResponse>> updateProfile(CustomerProfile profile);
  Future<Either<Failure,CustomerProfileDetailsResponse>> getCustomerProfile(CommonRegistrationRequest profile);
  Future<Either<Failure,ToAddressResponse>>  getToAddress(String mobileNumber);


}

