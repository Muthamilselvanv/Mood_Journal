import 'package:flutter/material.dart';
import 'package:mood_journal_app/src/core/constants/app_colors.dart';
import 'package:mood_journal_app/src/core/constants/app_spacing.dart';
import 'package:mood_journal_app/src/features/home/presentation/widgets/greeting.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.of(context).size.width;
    return Scaffold(
      //Appbar
      appBar: AppBar(
        //automaticallyImplyLeading: false,
        //centerTitle: false,
        titleSpacing: AppSpacing.space20,
        toolbarHeight: AppSpacing.toolBarhight, // 70
        // backgroundColor: AppColors.appBackground,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    formattedDate(),
                    style: Theme.of(
                      context,
                    ).textTheme.titleSmall?.copyWith(color: Colors.grey),
                  ),
                  const SizedBox(height: AppSpacing.space4),
                  Text(
                    greeting(),
                    style: Theme.of(
                      context,
                    ).textTheme.titleSmall?.copyWith(fontSize: 20),
                  ),
                ],
              ),
            ),

            Stack(
              clipBehavior: Clip.none,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.notifications_none_rounded),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: AppSpacing.space8),
            GestureDetector(
              onTap: () {},
              child: CircleAvatar(
                radius: 18,
                backgroundColor: AppColors.primary.withOpacity(0.15),
                child: const Icon(
                  Icons.person_outline_rounded,
                  size: AppIconSizes.medium,
                  color: AppColors.primary,
                ),
              ),
            ),
          ],
        ),
      ),

      //body
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppSpacing.screen,
          child: Column(children: [buildMoodCard(context)]),
        ),
      ),
    );
  }
}

Widget buildMoodCard(BuildContext context) {
  final width = MediaQuery.sizeOf(context).width;

  final cardHeight = (width * 0.48).clamp(
    180.0,
    220.0,
  ); //clamp -> means, a method used to restrict a number to a specific range

  final bigCircle = (width * 0.32).clamp(120.0, 150.0);
  final smallCircle = (width * 0.11).clamp(40.0, 50.0);

  return Container(
    width: double.infinity,
    height: cardHeight,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(28),
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xffEEF1FF), Color(0xffDDF8F1)],
      ),
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(28),
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          // Top Right Big Circle
          Positioned(
            top: -bigCircle * 0.20,
            right: -bigCircle * 0.15,
            child: Container(
              width: bigCircle,
              height: bigCircle,
              decoration: BoxDecoration(
                color: Colors.purple.withOpacity(0.10),
                shape: BoxShape.circle,
              ),
            ),
          ),

          // Small Green Circle
          Positioned(
            top: cardHeight * 0.10,
            right: bigCircle * 0.75,
            child: Container(
              width: smallCircle,
              height: smallCircle,
              decoration: BoxDecoration(
                color: Colors.teal.withOpacity(0.25),
                shape: BoxShape.circle,
              ),
            ),
          ),

          // Bottom Blue Circle
          Positioned(
            bottom: -bigCircle * 0.20,
            right: -bigCircle * 0.10,
            child: Container(
              width: bigCircle,
              height: bigCircle,
              decoration: BoxDecoration(
                color: Colors.lightBlue.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
            ),
          ),

          // Flower Emoji
          Positioned(
            bottom: 18,
            right: 18,
            child: Text("🌸", style: TextStyle(fontSize: bigCircle * 0.45)),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "DAILY CHECK-IN",
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: const Color(0xff7B61FF),
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.5,
                  ),
                ),

                const SizedBox(height: 12),

                Text(
                  "How are you\nfeeling today?",
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const Spacer(),

                Row(
                  children: List.generate(
                    5,
                    (index) => Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(.08),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            ["😊", "😌", "😐", "😔", "😡"][index],
                            style: const TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
