import 'package:app/config/helper/widgets/ride_selection.dart';
import 'package:app/config/helper/widgets/sctollable_card.dart';
import 'package:flutter/material.dart';

class SlidableBookRidePage extends StatelessWidget {
  int ? flow =1;
   SlidableBookRidePage({super.key , this.flow});

  @override
  Widget build(BuildContext context) {

   switch (flow) {
      case 1:
        return const SctollableCard();

      case 2:
        return const RideSelectionSheet();

    }

    return RideSelectionSheet();
  }
}