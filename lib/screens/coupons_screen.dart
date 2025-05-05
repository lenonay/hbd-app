import 'package:flutter/material.dart';
import 'package:hbd_app/data/coupons_repository.dart';
import 'package:hbd_app/widgets/ticket_card.dart';

class CouponsScreen extends StatefulWidget {
  const CouponsScreen({super.key});

  @override
  State<CouponsScreen> createState() => _CouponsScreenState();
}

class _CouponsScreenState extends State<CouponsScreen> {
  final CouponsRepository _repository = CouponsRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _repository.all(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError || !snapshot.hasData) {
            print(snapshot.data);
            return Text("Hubo un error");
          }

          final coupons = List.from(snapshot.data!);

          return ListView.builder(
            itemCount: coupons.length,
            itemBuilder: (context, index) {
              final c = coupons[index];
              return TicketCard(
                coupon: c,
                onTap: () {
                  // TODO: navegar a detalle
                },
              );
            },
          );
        },
      ),
      //
    );
  }
}
