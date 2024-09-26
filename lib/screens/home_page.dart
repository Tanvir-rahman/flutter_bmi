import 'package:flutter/material.dart';
import '../widgets/styled_text.dart';
import '../widgets/gender_selection_card.dart';
import '../enums/gender.dart';
import '../widgets/button.dart';
import '../widgets/custom_app_bar.dart';
import 'selection_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  Gender selectedGender = Gender.male;

  void selectGender(Gender gender) {
    setState(() {
      selectedGender = gender;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              CustomAppBar(),
              const SizedBox(height: 80),
              StyledText(
                text: 'Choose your Gender',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 80),
              // const Spacer(),
              Row(
                children: [
                  Expanded(
                    child: GenderSelectionCard(
                      gender: Gender.male,
                      imagePath: 'images/male.png',
                      title: 'Male',
                      isSelected: selectedGender == Gender.male,
                      onTap: () => selectGender(Gender.male),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: GenderSelectionCard(
                      gender: Gender.female,
                      imagePath: 'images/female.png',
                      title: 'Female',
                      isSelected: selectedGender == Gender.female,
                      onTap: () => selectGender(Gender.female),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Button(
                  title: 'Continue',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            SelectionPage(selectedGender: selectedGender.name),
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
