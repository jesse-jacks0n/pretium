import 'package:flutter/material.dart';

class OnboardingModel {
  final String title;
  final String description;
  final Widget icon;
  final bool isLastPage;
  final String buttonText;

  OnboardingModel({
    required this.title,
    required this.description,
    required this.icon,
    this.isLastPage = false,
    this.buttonText = 'Next',
  });
} 