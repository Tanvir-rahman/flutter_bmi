import 'package:flutter/material.dart';
import '../utils/bmi_calculator.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/button.dart';
import '../screens/home_page.dart';

class ResultPage extends StatelessWidget {
  final double bmi;
  final double height;
  final double weight;
  final String gender;

  const ResultPage({
    Key? key,
    required this.bmi,
    required this.height,
    required this.weight,
    required this.gender,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String category = BMICalculator.getBMICategory(bmi);
    Color categoryColor = BMICalculator.getBMICategoryColor(bmi);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CustomAppBar(showBackButton: true),
              const SizedBox(height: 20),
              Text(
                'Your BMI Result',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 40),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      gender == 'male'
                          ? 'images/male.png'
                          : 'images/female.png',
                      height: 200,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildMeasurementText('$height cm', 'Height'),
                        const SizedBox(width: 40),
                        _buildMeasurementText('$weight kg', 'Weight'),
                      ],
                    ),
                    const SizedBox(height: 40),
                    Text(
                      'Your BMI is $category',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: categoryColor,
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildBMIBar(),
                    const SizedBox(height: 10),
                    Text(
                      bmi.toStringAsFixed(1),
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: categoryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Button(
                title: 'Try Again',
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) =>
                            HomePage(title: 'BMI Calculator')),
                    (Route<dynamic> route) => false,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMeasurementText(String value, String label) {
    // Parse the value and round it
    double numericValue = double.parse(value.split(' ')[0]);
    int roundedValue = numericValue.round();
    String unit = value.split(' ')[1];

    return Column(
      children: [
        Text(
          '$roundedValue $unit',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildBMIBar() {
    return Container(
      width: double.infinity,
      height: 20,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: const LinearGradient(
          colors: [
            Colors.blue,
            Colors.green,
            Colors.yellow,
            Colors.orange,
            Colors.red,
          ],
        ),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              Positioned(
                left: (bmi / 40) * constraints.maxWidth - 5,
                child: const Icon(Icons.arrow_drop_down, color: Colors.black),
              ),
            ],
          );
        },
      ),
    );
  }
}
