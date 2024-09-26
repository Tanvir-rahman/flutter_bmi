import 'package:flutter/material.dart';
import 'styled_text.dart';

class CustomAppBar extends StatelessWidget {
  final bool showBackButton;

  const CustomAppBar({Key? key, this.showBackButton = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kToolbarHeight, // Standard height for app bars
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Centered title
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: StyledText(
                text: 'BMI Calculator',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: Theme.of(context).primaryColor),
              ),
            ),
          ),
          // Back button (if shown)
          if (showBackButton)
            Positioned(
              left: -20,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Icon(Icons.arrow_back),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
