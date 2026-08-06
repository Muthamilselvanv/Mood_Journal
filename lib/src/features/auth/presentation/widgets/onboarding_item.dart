import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mood_journal_app/src/features/auth/presentation/models/onboarding_model.dart';

class OnboardingItem extends StatelessWidget {
  final OnboardingModel page;

  const OnboardingItem({super.key, required this.page});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: Column(
        children: [
          const Spacer(),

          /// Illustration Area
          Container(
            width: size.width * .78,
            height: size.width * .78,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: isDark
                  ? const Color(0xff1F2937).withOpacity(.85)
                  : Colors.white.withOpacity(.45),

              border: Border.all(
                color: isDark
                    ? Colors.white.withOpacity(.08)
                    : Colors.white.withOpacity(.55),
              ),

              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(isDark ? .25 : .05),
                  blurRadius: 30,
                  offset: const Offset(0, 15),
                ),
              ],
            ),

            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  top: 35,
                  right: 35,
                  child: Container(
                    width: 26,
                    height: 26,
                    decoration: BoxDecoration(
                      color: isDark
                          ? const Color(0xff7C4DFF).withOpacity(.30)
                          : const Color(0xff7C4DFF).withOpacity(.15),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),

                Positioned(
                  bottom: 40,
                  left: 35,
                  child: Container(
                    width: 18,
                    height: 18,
                    decoration: BoxDecoration(
                      color: isDark
    ? const Color(0xff5AA9FF).withOpacity(.28)
    : const Color(0xff5AA9FF).withOpacity(.18),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),

                /// Replace this later with Image.asset(...)
                Image.asset(page.image, fit: BoxFit.contain),
                // Text(
                //   page.emoji,
                //   style: TextStyle(fontSize: size.width * .26),
                // ),
              ],
            ),
          ),

          SizedBox(height: size.height * .06),

          Text(
            page.title,
            key: ValueKey(page.title),
            textAlign: TextAlign.center,
            style: theme.textTheme.headlineMedium?.copyWith(
              color: theme.colorScheme.onSurface,
              fontFamily: GoogleFonts.poppins().fontFamily,
              letterSpacing: -.5,
              height: 1.2,
            ),
          ),

          const SizedBox(height: 18),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Text(
              page.subtitle,
              key: ValueKey(page.subtitle),
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(.7),
                height: 1.7,
                fontSize: 16,
              ),
            ),
          ),

          const Spacer(),
        ],
      ),
    );
  }
}
