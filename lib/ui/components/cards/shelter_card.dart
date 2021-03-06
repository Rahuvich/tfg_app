import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jumpets_app/models/models.dart';
import 'package:jumpets_app/ui/components/cards/animated_minishelter_card.dart';
import 'package:jumpets_app/ui/components/maps/google_map_shelters.dart';
import 'package:jumpets_app/ui/profile_page/profile_page.dart';
import 'package:transparent_image/transparent_image.dart';
import 'dart:math' as math;

class ShelterCard extends StatelessWidget {
  final Protectora shelter;
  final bool isSelected;
  final double offset;
  ShelterCard({@required this.shelter, this.isSelected = false, this.offset})
      : assert(shelter != null);

  @override
  Widget build(BuildContext context) {
    double gauss = math.exp(-(math.pow((offset.abs() - 0.5), 2) / 0.08));
    const double edgePadding = 20;
    return Transform.translate(
      offset: Offset(-32 * gauss * offset.sign, 0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 20,
          ),
          AnimatedShelterCard(
            edgePadding: edgePadding,
            shelter: shelter,
            isSelected: isSelected,
          ),
          Spacer(),
          SizedBox(
            height: kToolbarHeight * 1.5,
          ),
        ],
      ),
    );
  }
}
