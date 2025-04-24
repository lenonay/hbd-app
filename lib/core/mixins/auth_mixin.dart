import '/core/network/dio_client.dart';

mixin AuthMixin {
  final DioClient dioClient = DioClient();

  Future<bool> checkAuth() async {
    final hasToken = await dioClient.hasTokenCookie();

    return hasToken;
  }
}
