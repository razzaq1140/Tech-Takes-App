import 'package:tech_takes_app/src/common/constants/app_images.dart';

class PredictionModel {
  final String image;
  final String title;
  final String subTitle;
  final String predictionText;
  PredictionModel({
    required this.image,
    required this.title,
    required this.subTitle,
    required this.predictionText,
  });
}

List<PredictionModel> predictionList = [
  PredictionModel(
    image: AppImages.bosImage,
    title: 'BOS+110',
    subTitle: 'BOS @ TOR . 4:00pm',
    predictionText: '4u',
  ),
  PredictionModel(
    image: AppImages.bufImage,
    title: 'BUF+250',
    subTitle: 'BUF @ TOR . 2:00pm',
    predictionText: '3u',
  ),
  PredictionModel(
    image: AppImages.bosImage,
    title: 'MUL+110',
    subTitle: 'MUL @ TOR . 3:00pm',
    predictionText: '2u',
  ),
  PredictionModel(
    image: AppImages.bufImage,
    title: 'BOS+110',
    subTitle: 'BOS @ TOR . 7:00pm',
    predictionText: '1u',
  ),
  PredictionModel(
    image: AppImages.bosImage,
    title: 'PHII+250',
    subTitle: 'PHI @ TOR . 8:00pm',
    predictionText: '4u',
  ),
  PredictionModel(
    image: AppImages.bosImage,
    title: 'MUL+250',
    subTitle: 'PHI @ TOR . 8:00pm',
    predictionText: '4u',
  ),
];
