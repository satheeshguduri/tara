// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'psp_rest_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _PSPRestClient implements PSPRestClient {
  _PSPRestClient(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= 'https://182.71.195.99:30443/';
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<String> getAppToken(ki, request) async {
    ArgumentError.checkNotNull(ki, 'ki');
    ArgumentError.checkNotNull(request, 'request');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'ki': ki};
    final _data = request;
    final _result = await _dio.request<String>(
        'psp-umps-adaptor/umps-login/app-login',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{r'Content-Type': 'text/plain'},
            extra: _extra,
            contentType: 'text/plain',
            baseUrl: baseUrl),
        data: _data);
    final value = _result.data;
    return value;
  }

  @override
  Future<String> getAppTokenMerchant(ki, request) async {
    ArgumentError.checkNotNull(ki, 'ki');
    ArgumentError.checkNotNull(request, 'request');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'ki': ki};
    final _data = request;
    final _result = await _dio.request<String>(
        'psp-umps-adaptor/umps-login/merchant-login',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{r'Content-Type': 'text/plain'},
            extra: _extra,
            contentType: 'text/plain',
            baseUrl: baseUrl),
        data: _data);
    final value = _result.data;
    return value;
  }

  @override
  Future<TokenResponse> getPrivateAccessToken(commonRegistrationRequest) async {
    ArgumentError.checkNotNull(
        commonRegistrationRequest, 'commonRegistrationRequest');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(commonRegistrationRequest?.toJson() ?? <String, dynamic>{});
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<Map<String, dynamic>>(
        'psp-umps-adaptor/umps-app/issue-private-access-token',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = TokenResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<RegisterResponse> register(registerRequest) async {
    ArgumentError.checkNotNull(registerRequest, 'registerRequest');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(registerRequest?.toJson() ?? <String, dynamic>{});
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<Map<String, dynamic>>(
        'psp-umps-adaptor/umps-app/register',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = RegisterResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<TrackRegistrationResponse> trackRegistration(
      commonRegistrationRequest) async {
    ArgumentError.checkNotNull(
        commonRegistrationRequest, 'commonRegistrationRequest');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(commonRegistrationRequest?.toJson() ?? <String, dynamic>{});
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<Map<String, dynamic>>(
        'psp-umps-adaptor/umps-app/track-registration',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = TrackRegistrationResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<List<BankDetailsBean>> getBanksList(commonRegistrationRequest) async {
    ArgumentError.checkNotNull(
        commonRegistrationRequest, 'commonRegistrationRequest');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(commonRegistrationRequest?.toJson() ?? <String, dynamic>{});
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<List<dynamic>>(
        'psp-umps-adaptor/umps-app/fetch-ecosystem-banklist',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    var value = _result.data
        .map((dynamic i) => BankDetailsBean.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<TrackAccountDetailsResponse> initiateAccountDetailsRequest(
      commonRegistrationRequest) async {
    ArgumentError.checkNotNull(
        commonRegistrationRequest, 'commonRegistrationRequest');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(commonRegistrationRequest?.toJson() ?? <String, dynamic>{});
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<Map<String, dynamic>>(
        'psp-umps-adaptor/umps-app/initiate-account-details-request-api',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = TrackAccountDetailsResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<TrackAccountDetailsResponse> trackAccountDetailsRequest(
      commonRegistrationRequest) async {
    ArgumentError.checkNotNull(
        commonRegistrationRequest, 'commonRegistrationRequest');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(commonRegistrationRequest?.toJson() ?? <String, dynamic>{});
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<Map<String, dynamic>>(
        'psp-umps-adaptor/umps-app/track-account-details-request-api',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = TrackAccountDetailsResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<TransactionResponse> initiatePreTransactionRequest(
      preTransactionRequest) async {
    ArgumentError.checkNotNull(preTransactionRequest, 'preTransactionRequest');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(preTransactionRequest?.toJson() ?? <String, dynamic>{});
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<Map<String, dynamic>>(
        'psp-umps-adaptor/umps-app/pre-transaction-request',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = TransactionResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<TransactionResponse> initiateTransactionRequest(
      transactionRequest) async {
    ArgumentError.checkNotNull(transactionRequest, 'transactionRequest');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(transactionRequest?.toJson() ?? <String, dynamic>{});
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<Map<String, dynamic>>(
        'psp-umps-adaptor/umps-app/initiate-transaction-request',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = TransactionResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<TransactionResponse> initiateMerchantTransactionRequest(
      transactionRequest) async {
    ArgumentError.checkNotNull(transactionRequest, 'transactionRequest');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(transactionRequest?.toJson() ?? <String, dynamic>{});
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<Map<String, dynamic>>(
        'psp-umps-adaptor/umps-merchant/initiate-transaction-request',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = TransactionResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<TransactionResponse> trackTransactionRequest(
      transactionRequest) async {
    ArgumentError.checkNotNull(transactionRequest, 'transactionRequest');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(transactionRequest?.toJson() ?? <String, dynamic>{});
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<Map<String, dynamic>>(
        'psp-umps-adaptor/umps-app/track-transaction-request',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = TransactionResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<String> merchantLogin(ki, request) async {
    ArgumentError.checkNotNull(ki, 'ki');
    ArgumentError.checkNotNull(request, 'request');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'ki': ki};
    final _data = request;
    final _result = await _dio.request<String>(
        'psp-umps-adaptor/umps-login/merchant-login',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{r'Content-Type': 'text/plain'},
            extra: _extra,
            contentType: 'text/plain',
            baseUrl: baseUrl),
        data: _data);
    final value = _result.data;
    return value;
  }

  @override
  Future<TransactionResponse> payerCollectResponse(payerCollectRequest) async {
    ArgumentError.checkNotNull(payerCollectRequest, 'payerCollectRequest');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(payerCollectRequest?.toJson() ?? <String, dynamic>{});
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<Map<String, dynamic>>(
        'psp-umps-adaptor/umps-app/payer-collect-response',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = TransactionResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<TransactionHistoryResponse> getTxnHistory(queries) async {
    ArgumentError.checkNotNull(queries, 'queries');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(queries ?? <String, dynamic>{});
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        'psp-umps-adaptor/umps-app/txn-history-details',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = TransactionHistoryResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<String> getBankLogo(queries) async {
    ArgumentError.checkNotNull(queries, 'queries');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(queries ?? <String, dynamic>{});
    final _data = <String, dynamic>{};
    final _result = await _dio.request<String>(
        'psp-umps-adaptor/umps-app/bank-logo',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = _result.data;
    return value;
  }

  @override
  Future<CustomerProfileDetailsResponse> getCustomerProfileDetails(
      commonRegistrationRequest) async {
    ArgumentError.checkNotNull(
        commonRegistrationRequest, 'commonRegistrationRequest');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(commonRegistrationRequest?.toJson() ?? <String, dynamic>{});
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<Map<String, dynamic>>(
        'psp-umps-adaptor/umps-app/customer-profile-details',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = CustomerProfileDetailsResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<ValidateMobileResponse> validateMobile(validateMobileRequest) async {
    ArgumentError.checkNotNull(validateMobileRequest, 'validateMobileRequest');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(validateMobileRequest?.toJson() ?? <String, dynamic>{});
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<Map<String, dynamic>>(
        'psp-umps-adaptor/umps-app/validate-mobile-request',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ValidateMobileResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<AddBeneficiaryResponse> addBeneficiary(addBeneficiaryRequest) async {
    ArgumentError.checkNotNull(addBeneficiaryRequest, 'addBeneficiaryRequest');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(addBeneficiaryRequest?.toJson() ?? <String, dynamic>{});
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<Map<String, dynamic>>(
        'psp-umps-adaptor/umps-app/add-beneficiary',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = AddBeneficiaryResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<GetBeneficiariesResponse> getBeneficiaries(queries) async {
    ArgumentError.checkNotNull(queries, 'queries');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(queries ?? <String, dynamic>{});
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        'psp-umps-adaptor/umps-app/get-beneficiaries',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = GetBeneficiariesResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<AddBeneficiaryResponse> mapBeneficiaryDetails(
      mapBeneficiaryRequest) async {
    ArgumentError.checkNotNull(mapBeneficiaryRequest, 'mapBeneficiaryRequest');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(mapBeneficiaryRequest?.toJson() ?? <String, dynamic>{});
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<Map<String, dynamic>>(
        'psp-umps-adaptor/umps-app/map-beneficiary-detail',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = AddBeneficiaryResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<SearchBeneficiaryResponse> searchBeneficiary(queries) async {
    ArgumentError.checkNotNull(queries, 'queries');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(queries ?? <String, dynamic>{});
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        'psp-umps-adaptor/umps-app/search-beneficiary-detail',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = SearchBeneficiaryResponse.fromJson(_result.data);
    return value;
  }
}
