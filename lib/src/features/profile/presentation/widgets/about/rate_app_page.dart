import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RateAppPage extends StatelessWidget {
  const RateAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Rate App")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Icon(Icons.star, size: 80, color: Colors.amber),

            const SizedBox(height: 20),

            Text(
              "Enjoying Mood Journal?",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontFamily: GoogleFonts.poppins().fontFamily,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "Your feedback helps us improve.",
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 30),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                5,
                (index) => const Padding(
                  padding: EdgeInsets.all(4),
                  child: Icon(Icons.star_border, size: 42),
                ),
              ),
            ),

            const SizedBox(height: 30),

            FilledButton(onPressed: () {}, child: const Text("Submit Review")),
          ],
        ),
      ),
    );
  }
}
