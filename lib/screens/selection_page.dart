import 'package:flutter/material.dart';
import '../widgets/styled_text.dart';
import '../widgets/button.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/measurement_slider.dart';
import '../utils/bmi_calculator.dart';
import 'result_page.dart';

class SelectionPage extends StatefulWidget {
  final String selectedGender;

  const SelectionPage({super.key, required this.selectedGender});

  @override
  _SelectionPageState createState() => _SelectionPageState();
}

class _SelectionPageState extends State<SelectionPage> {
  double height = 165;
  double weight = 55;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const CustomAppBar(showBackButton: true),
              const SizedBox(height: 40),
              StyledText(
                text: 'Choose your Height & Weight',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 40),
              MeasurementSlider(
                title: 'Height',
                unit: 'cm',
                value: height,
                minimum: 100,
                maximum: 220,
                onChanged: (value) {
                  setState(() {
                    height = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              MeasurementSlider(
                title: 'Weight',
                unit: 'kg',
                value: weight,
                minimum: 30,
                maximum: 150,
                onChanged: (value) {
                  setState(() {
                    weight = value;
                  });
                },
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Button(
                  title: 'Calculate BMI',
                  onPressed: () {
                    double bmi = BMICalculator.calculateBMI(weight, height);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ResultPage(
                          bmi: bmi,
                          height: height,
                          weight: weight,
                          gender: widget.selectedGender,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
