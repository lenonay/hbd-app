import 'package:flutter/material.dart';
import 'package:hbd_app/core/mixins/auth_mixin.dart';
import 'package:hbd_app/data/coupons_repository.dart';
import 'package:hbd_app/screens/auth/unauth_screen.dart';
import 'package:hbd_app/widgets/auth/auth_wrapper.dart';
import 'package:hbd_app/widgets/empty_viewer.dart';
import 'package:hbd_app/widgets/ticket_card.dart';

class CouponsScreen extends StatefulWidget {
  const CouponsScreen({super.key});

  @override
  State<CouponsScreen> createState() => _CouponsScreenState();
}

class _CouponsScreenState extends State<CouponsScreen> with AuthMixin {
  final CouponsRepository _repository = CouponsRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthWrapper(
        authFuture: checkAuth(),
        authBuilder: (context) => Screen(repository: _repository),
        unAuthBuilder: (context) => UnAuthScreen(),
      ),
      //
    );
  }
}

class Screen extends StatelessWidget {
  const Screen({super.key, required CouponsRepository repository})
    : _repository = repository;

  final CouponsRepository _repository;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _repository.all(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError || !snapshot.hasData) {
          return Text("Hubo un error");
        }

        final coupons = List.from(snapshot.data!);

        // Si no tenemos posts en la lista
          if (coupons.isEmpty) {
            return EmptyViewer(item: "cupones");
          }

        return ListView.builder(
          itemCount: coupons.length,
          itemBuilder: (context, index) {
            final c = coupons[index];
            return TicketCard(coupon: c, onTap: () {});
          },
        );
      },
    );
  }
}
