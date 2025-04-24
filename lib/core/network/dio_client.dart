import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import '/data/env.dart';

class DioClient {
  // Instancia privada y estática
  static final DioClient _instance = DioClient._internal();

  late final Dio dio;
  late final PersistCookieJar cookieJar;
  bool _initialized = false;

  // Constructor privado
  DioClient._internal();

  // Constructor de fábrica que retorna siempre la misma instancia
  factory DioClient() {
    return _instance;
  }

  // Método de inicialización asíncrono
  Future<void> init() async {
    if (_initialized) return;

    // Configuración de Dio con opciones globales
    dio = Dio(
      BaseOptions(
        baseUrl: Env.apiURL, // URL base de la API
        headers: {'Content-Type': 'application/json'},
        validateStatus: (status) => status! < 500,
      ),
    );

    // Inicialización del PersistCookieJar
    final dir = await getApplicationDocumentsDirectory();
    final cookiePath = '${dir.path}/.cookies/';
    final cookieDir = Directory(cookiePath);
    if (!await cookieDir.exists()) {
      await cookieDir.create(recursive: true);
    }
    cookieJar = PersistCookieJar(storage: FileStorage(cookiePath));

    // Agregar el interceptor para manejar cookies automáticamente
    dio.interceptors.add(CookieManager(cookieJar));

    _initialized = true;
  }

  // Método general para realizar peticiones HTTP
  Future<Response> request(
    String method,
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    return dio.request(
      path,
      data: data,
      queryParameters: queryParameters,
      options: Options(method: method),
    );
  }

  Future<bool> hasTokenCookie() async {
    // Esperamos a que se termine de inciar
    if (!_initialized) await init();

    final Uri uri = Uri.parse(Env.apiURL);

    // Recuperamos todas las cookies para la URI de la API
    final cookies = await cookieJar.loadForRequest(uri);

    final Cookie? tokenCookie = cookies.cast<Cookie?>().firstWhere(
      (cookie) => cookie?.name == "token",
      orElse: () => null,
    );

    if (tokenCookie == null) return false;

    final now = DateTime.now().toUtc();
    final isExpired = tokenCookie.expires?.isBefore(now) ?? false;

    if (isExpired) {
      await cookieJar.delete(uri);
    }

    return !isExpired;
  }

  Future<void> logout() async {
    final Uri uri = Uri.parse(Env.apiURL);

    await cookieJar.delete(uri);
  }
}
