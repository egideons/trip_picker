import 'package:trip_picker/constants/assets.dart';
import 'package:trip_picker/models/onboard_model.dart';

class OnboardContent {
  List<OnboardModel> items = [
    OnboardModel(
      title: "The First",
      otherTitle: "Web 3",
      afterText: "ride-hailing app",
      description:
          "Discover seamless rides powered by cutting-edge blockchain technology, the first Web 3.0 ride-hailing app",
      image: Assets.onboard1Png,
      imageBackground: Assets.onboard1Svg,
    ),
    OnboardModel(
      title: "Ride with",
      otherTitle: "Ease",
      afterText: "",
      description:
          "Get a ride quickly and conveniently. Choose your destination, and we’ll get you there safely.",
      image: Assets.onboard2Png,
      imageBackground: Assets.onboard2Svg,
    ),
    OnboardModel(
      title: "We've got you",
      otherTitle: "covered",
      afterText: "",
      description:
          "Need to send a package? Fast and reliable logistics services at your fingertips!",
      image: Assets.onboard3Png,
      imageBackground: Assets.onboard3Svg,
    ),
    OnboardModel(
      title: "Join Us and",
      otherTitle: "start earning",
      afterText: "",
      description:
          "Drive with Trip Picker and benefit from flexible hours and extra earnings through our mining feature.",
      image: Assets.onboard4Png,
      imageBackground: Assets.onboard4Svg,
    ),
    OnboardModel(
      title: "Get started",
      otherTitle: "",
      afterText: "",
      description: "Ready to experience the future of transportation?",
      image: Assets.getStartedPng,
      imageBackground: Assets.getStartedSvg,
    ),
  ];
}
