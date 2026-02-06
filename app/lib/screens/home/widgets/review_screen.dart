import 'package:app/config/colors/app_color.dart';
import 'package:app/config/helper/common/common_text_field.dart';
import 'package:app/config/helper/widgets/cylinder_line.dart';
import 'package:app/screens/home/viewmodel/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

class ReviewScreen extends StatefulWidget {
  final VoidCallback onSkip;
  final Function(String rideId, String rating, String feedback) onSubmit;

  const ReviewScreen({
    super.key,
    required this.onSkip,
    required this.onSubmit,
  });

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  int selectedRating = 5;
  final TextEditingController feedbackCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {

      final homeProvider = context.read<HomeProvider>();
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // drag handle
          // Container(
          //   width: 40,
          //   height: 4,
          //   margin: const EdgeInsets.only(bottom: 12),
          //   decoration: BoxDecoration(
          //     color: Colors.grey.shade400,
          //     borderRadius: BorderRadius.circular(10),
          //   ),
          // ),

          cylinderLine(),
          SizedBox(height: 5,),

          const Text(
            "Rate your driver",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),

          const SizedBox(height: 12),

          // ⭐ Rating
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              return IconButton(
                icon: Icon(
                  index < selectedRating
                      ? Icons.star
                      : Icons.star_border,
                  color: AppColor.primaryYellow,
                  size: 32,
                ),
                onPressed: () {
                  setState(() => selectedRating = index + 1);
                },
              );
            }),
          ),

          Text(
            "$selectedRating / 5",
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),

          const SizedBox(height: 16),

       

          CommonTextField(hintText: "Write feedback (optional)",maxLines: 3,controller: feedbackCtrl,),

          const SizedBox(height: 20),

          // buttons
          Row(
            children: [
              Expanded(
                child: TextButton(
                   style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: widget.onSkip,
                  child: const Text(
                    "Rate Later",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primaryYellow,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    widget.onSubmit(
                      homeProvider.confiremRideDetails?.ride.id.toString()??"id",
                      selectedRating.toString(),
                      feedbackCtrl.text,
                    );
                  },
                  child: const Text(
                    "Submit",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 20,)
        ],

      ),
    );
  }
}
