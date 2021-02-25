// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rest_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _RestClient implements RestClient {
  _RestClient(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= 'http://107.20.4.43:9001/';
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<BaseResponse> getOTP(authRequestWithData) async {
    ArgumentError.checkNotNull(authRequestWithData, 'authRequestWithData');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(authRequestWithData?.toJson() ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>('v1/tara/auth/otp',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = BaseResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<BaseResponse> validateOtp(authRequestWithData) async {
    ArgumentError.checkNotNull(authRequestWithData, 'authRequestWithData');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(authRequestWithData?.toJson() ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>(
        'v1/tara/auth/otp/validate',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = BaseResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<AuthResponse> login(loginRequest) async {
    ArgumentError.checkNotNull(loginRequest, 'loginRequest');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(loginRequest?.toJson() ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>(
        'v1/tara/auth/validate',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = AuthResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<AuthResponse> signUp(signUpRequest) async {
    ArgumentError.checkNotNull(signUpRequest, 'signUpRequest');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(signUpRequest?.toJson() ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>('v1/tara/auth',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = AuthResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<BaseResponse> updateProfile(token, updateProfileRequest) async {
    ArgumentError.checkNotNull(token, 'token');
    ArgumentError.checkNotNull(updateProfileRequest, 'updateProfileRequest');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(updateProfileRequest?.toJson() ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>(
        'v1/tara/crm/customer',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'PUT',
            headers: <String, dynamic>{r'Authorization': token},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = BaseResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<CustomerProfile> getCustomerInfo(token, customerId) async {
    ArgumentError.checkNotNull(token, 'token');
    ArgumentError.checkNotNull(customerId, 'customerId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        'v1/tara/crm/customer/$customerId',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'Authorization': token},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = CustomerProfile.fromJson(_result.data);
    return value;
  }

  @override
  Future<Store> createStore(token, store) async {
    ArgumentError.checkNotNull(token, 'token');
    ArgumentError.checkNotNull(store, 'store');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(store?.toJson() ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>(
        'v0.1/tara/erp/store',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{r'Authorization': token},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = Store.fromJson(_result.data);
    return value;
  }

  @override
  Future<Owner> createOwner(token, owner) async {
    ArgumentError.checkNotNull(token, 'token');
    ArgumentError.checkNotNull(owner, 'owner');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(owner?.toJson() ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>(
        'v0.1/tara/erp/owner',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{r'Authorization': token},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = Owner.fromJson(_result.data);
    return value;
  }

  @override
  Future<Store> updateStore(token, store) async {
    ArgumentError.checkNotNull(token, 'token');
    ArgumentError.checkNotNull(store, 'store');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(store?.toJson() ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>(
        'v0.1/tara/erp/store',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{r'Authorization': token},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = Store.fromJson(_result.data);
    return value;
  }

  @override
  Future<List<Store>> getAllStores(token) async {
    ArgumentError.checkNotNull(token, 'token');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<List<dynamic>>('v0.1/tara/erp/store',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'Authorization': token},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    var value = _result.data
        .map((dynamic i) => Store.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<List<StoreTypeModel>> getStoreTypes(token) async {
    ArgumentError.checkNotNull(token, 'token');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<List<dynamic>>('v0.1/tara/erp/store',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'Authorization': token},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    var value = _result.data
        .map((dynamic i) => StoreTypeModel.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<Order> createOrder(token, order) async {
    ArgumentError.checkNotNull(token, 'token');
    ArgumentError.checkNotNull(order, 'order');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(order?.toJson() ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>(
        'v0.1/tara/erp/order',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{r'Authorization': token},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = Order.fromJson(_result.data);
    return value;
  }

  @override
  Future<Order> updateOrder(token, order, orderId) async {
    ArgumentError.checkNotNull(token, 'token');
    ArgumentError.checkNotNull(order, 'order');
    ArgumentError.checkNotNull(orderId, 'orderId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(order?.toJson() ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>(
        'v0.1/tara/erp/order/$orderId',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'PUT',
            headers: <String, dynamic>{r'Authorization': token},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = Order.fromJson(_result.data);
    return value;
  }

  @override
  Future<Order> getOrderByOrderId(token, orderId) async {
    ArgumentError.checkNotNull(token, 'token');
    ArgumentError.checkNotNull(orderId, 'orderId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        'v0.1/tara/erp/order/$orderId',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'Authorization': token},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = Order.fromJson(_result.data);
    return value;
  }

  @override
  Future<Catalogue> saveCatalogue(token, catalogue) async {
    ArgumentError.checkNotNull(token, 'token');
    ArgumentError.checkNotNull(catalogue, 'catalogue');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(catalogue?.toJson() ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>(
        'v0.1/tara/erp/order',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'Authorization': token},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = Catalogue.fromJson(_result.data);
    return value;
  }

  @override
  Future<Catalogue> updateCatalogue(token, catalogue) async {
    ArgumentError.checkNotNull(token, 'token');
    ArgumentError.checkNotNull(catalogue, 'catalogue');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(catalogue?.toJson() ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>(
        'v0.1/tara/erp/order',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'Authorization': token},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = Catalogue.fromJson(_result.data);
    return value;
  }

  @override
  Future<ToAddressResponse> getToAddress(token, mobile) async {
    ArgumentError.checkNotNull(token, 'token');
    ArgumentError.checkNotNull(mobile, 'mobile');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'mobile_number': mobile};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('v1/tara/auth',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'Authorization': token},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ToAddressResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<CustomerProfile> getCustomerInfoByFirebaseId(token, firebaseId) async {
    ArgumentError.checkNotNull(token, 'token');
    ArgumentError.checkNotNull(firebaseId, 'firebaseId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'firebaseId': firebaseId};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        'v1/tara/crm/customer/firebase',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'Authorization': token},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = CustomerProfile.fromJson(_result.data);
    return value;
  }
}
