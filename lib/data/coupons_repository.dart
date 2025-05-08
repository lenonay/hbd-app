import 'package:hbd_app/core/network/api_routes.dart';
import 'package:hbd_app/core/network/dio_client.dart';
import 'package:hbd_app/models/coupon.dart';

class CouponsRepository {
  final DioClient _dioClient = DioClient();

  Future<List<Coupon>?> all() async {
    final response = await _dioClient.request("GET", ApiRoutes.coupons);


    if (response.statusCode! != 200) {
      return null;
    }

    final res = response.data;

    if(res["success"] == false) {
      return null;
    }

    final array = List.from(res["data"]);

    final List<Coupon> couponsList = List.from(
      array.map((coupon) => Coupon.fromJson(coupon)),
    );

    return couponsList;
  }
}
