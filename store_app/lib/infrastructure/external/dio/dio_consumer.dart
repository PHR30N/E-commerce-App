import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:e_commerce_app/core/network/apis/api_consumer.dart';
import 'package:e_commerce_app/core/network/apis/status_codes.dart';
import 'package:e_commerce_app/core/network/errors/exceptions.dart';
import 'package:e_commerce_app/core/network/errors/failures.dart';
import 'package:fpdart/fpdart.dart';

class DioConsumer implements ApiConsumer {
  final Dio _client;
  final String _baseUrl;
  final List<Interceptor> _interceptors;

  DioConsumer({
    required Dio client,
    required String baseUrl,
    required List<Interceptor> interceptors,
  })  : _baseUrl = baseUrl,
        _interceptors = interceptors,
        _client = client {
    (_client.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
      final client = HttpClient();
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };

    _client.options = BaseOptions(
      baseUrl: _baseUrl,
      followRedirects: false,
      // Only 2xx HTTP status codes are valid success responses
      validateStatus: (status) {
        return status != null && status >= 200 && status < 300;
      },
    );

    _client.interceptors.addAll(_interceptors);
  }

  @override
  Future<Either<ServerFailure, dynamic>> get({
    required String path,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _client.get(
        path,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return Right(response.data);
    } on DioException catch (error) {
      return Left(_handleDioError(error));
    }
  }

  @override
  Future<Either<ServerFailure, Map<String, dynamic>>> post({
    required String path,
    required Object body,
    bool formDataEnabled = false,
    String? contentType,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _client.post(
        path,
        options: Options(contentType: contentType, headers: headers),
        data: formDataEnabled
            ? FormData.fromMap(body as Map<String, dynamic>)
            : body,
        queryParameters: queryParameters,
      );
      if (response.data is Map<String, dynamic>) {
        return Right(response.data as Map<String, dynamic>);
      }
      return Right({"data": response.data});
    } on DioException catch (error) {
      return Left(_handleDioError(error));
    }
  }

  @override
  Future<Either<ServerFailure, Map<String, dynamic>>> put({
    required String path,
    required Map<String, dynamic> body,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _client.put(
        path,
        data: body,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      if (response.data is Map<String, dynamic>) {
        return Right(response.data as Map<String, dynamic>);
      }
      return Right({"data": response.data});
    } on DioException catch (error) {
      return Left(_handleDioError(error));
    }
  }

  @override
  Future<Either<ServerFailure, Map<String, dynamic>>> delete({
    required String path,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _client.delete(
        path,
        data: body,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      if (response.data is Map<String, dynamic>) {
        return Right(response.data as Map<String, dynamic>);
      }
      return Right({"data": response.data});
    } on DioException catch (error) {
      return Left(_handleDioError(error));
    }
  }

  ServerFailure _handleDioError(DioException error) {
    if (error.type == DioExceptionType.badResponse && error.response != null) {
      final statusCode = error.response?.statusCode;
      final responseData = error.response?.data;
      String? backendMsg;
      if (responseData is Map) {
        if (responseData.containsKey('errors') && responseData['errors'] is Map) {
          final errorsMap = responseData['errors'] as Map;
          final firstErrorList = errorsMap.values.firstOrNull;
          if (firstErrorList is List && firstErrorList.isNotEmpty) {
            backendMsg = firstErrorList.first.toString();
          }
        }
        backendMsg ??= responseData['message']?.toString();
      } else if (responseData is String && responseData.isNotEmpty) {
        backendMsg = responseData;
      }

      if (backendMsg != null && backendMsg.isNotEmpty) {
        return ServerFailure(msg: backendMsg);
      }

      if (statusCode == StatusCodes.unauthorized) {
        return const ServerFailure(
          msg: "Unauthorized: Please log in to view this content.",
        );
      } else if (statusCode == StatusCodes.badRequest) {
        return const ServerFailure(msg: "Bad Request");
      } else if (statusCode == StatusCodes.notFound) {
        return const ServerFailure(msg: "Requested Info Not Found");
      } else if (statusCode == StatusCodes.forbidden) {
        return const ServerFailure(msg: "Access Forbidden");
      } else if (statusCode == StatusCodes.internalServerError) {
        return const ServerFailure(msg: "Internal Server Error");
      }
    }

    if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout ||
        error.type == DioExceptionType.sendTimeout) {
      return const ServerFailure(msg: "Connection Timeout");
    } else if (error.type == DioExceptionType.connectionError) {
      return const ServerFailure(msg: "No Internet Connection");
    }

    return ServerFailure(msg: error.message ?? "An unexpected error occurred");
  }
}