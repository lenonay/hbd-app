import 'package:flutter/material.dart';
import 'package:hbd_app/models/coupon.dart';
import 'package:hbd_app/theme.dart';
import 'package:hbd_app/widgets/clippers/ticket_clipper.dart';

class TicketCard extends StatelessWidget {
  final Coupon coupon;
  final VoidCallback onTap;

  const TicketCard({required this.coupon, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: PhysicalShape(
        clipper: TicketClipper(),
        color: AppColors.primaryTint40, // color de la tarjeta
        shadowColor: AppColors.secondaryStrong, // color de la sombra
        elevation: 4, // intensidad de la sombra
        child: Container(
          decoration: BoxDecoration(),
          child: Row(
            children: [
              
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 15,
                    bottom: 15,
                    right: 12,
                    left: 60
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Titulo
                      Text(
                        coupon.title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        coupon.content,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
