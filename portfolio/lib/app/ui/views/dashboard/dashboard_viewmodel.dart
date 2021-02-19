import 'package:portfolio/app/datamodels/porfolio.dart';
import 'package:portfolio/core/base_viewmodel.dart';

class DashboardViewModel extends BaseViewModel {
  Portfolio _currentPortfolio;
  Portfolio get currentPortfolio => _currentPortfolio;
}
