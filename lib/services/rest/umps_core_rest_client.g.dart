// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'umps_core_rest_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _UMPSCoreRestClient implements UMPSCoreRestClient {
  _UMPSCoreRestClient(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= 'https://54.235.233.48:10443/';
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<void> registerUserTxn(userRegistrationTxnRequest) async {
    ArgumentError.checkNotNull(
        userRegistrationTxnRequest, 'userRegistrationTxnRequest');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(userRegistrationTxnRequest?.toJson() ?? <String, dynamic>{});
    await _dio.request<void>(
        'umps-core/umps-sms/urn:apiver:1.0/user-registration-txn',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    return null;
  }

  @override
  Future<SplRegistrationResponseEnc> registerUser(
      splRegistrationRequestEnc) async {
    ArgumentError.checkNotNull(
        splRegistrationRequestEnc, 'splRegistrationRequestEnc');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(splRegistrationRequestEnc?.toJson() ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>(
        'umps-core/spl-sdk/urn:apiver:1.0/user-registration',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = SplRegistrationResponseEnc.fromJson(_result.data);
    return value;
  }

  @override
  Future<CommonResponse> retrieveKey(commonRequest) async {
    ArgumentError.checkNotNull(commonRequest, 'commonRequest');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(commonRequest?.toJson() ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>(
        'umps-core/spl-sdk/urn:apiver:1.0/retrieve-key',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = CommonResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<CommonResponse> registerCardDetail(commonRequest) async {
    ArgumentError.checkNotNull(commonRequest, 'commonRequest');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(commonRequest?.toJson() ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>(
        'umps-core/spl-sdk/urn:apiver:1.0/register-card-detail',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = CommonResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<CommonResponse> confirmAccountRegistration(commonRequest) async {
    ArgumentError.checkNotNull(commonRequest, 'commonRequest');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(commonRequest?.toJson() ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>(
        'umps-core/spl-sdk/urn:apiver:1.0/confirm-account-registration',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = CommonResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<CommonResponse> fetchOtp(commonRequest) async {
    ArgumentError.checkNotNull(commonRequest, 'commonRequest');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(commonRequest?.toJson() ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>(
        'umps-core/spl-sdk/urn:apiver:1.0/fetch-otp-challenge-code',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = CommonResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<CommonResponse> refreshOtp(commonRequest) async {
    ArgumentError.checkNotNull(commonRequest, 'commonRequest');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(commonRequest?.toJson() ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>(
        'umps-core/spl-sdk/urn:apiver:1.0/refresh-otp-api',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = CommonResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<CommonResponse> validateOtp(commonRequest) async {
    ArgumentError.checkNotNull(commonRequest, 'commonRequest');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(commonRequest?.toJson() ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>(
        'umps-core/spl-sdk/urn:apiver:1.0/validate-otp-api',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = CommonResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<CommonResponse> authorize(commonRequest) async {
    ArgumentError.checkNotNull(commonRequest, 'commonRequest');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(commonRequest?.toJson() ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>(
        'umps-core/spl-sdk/urn:apiver:1.0/authorize',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = CommonResponse.fromJson(_result.data);
    return value;
  }
}
