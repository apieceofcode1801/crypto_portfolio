import 'package:portfolio/core/datamodels/porfolio.dart';
import 'package:portfolio/ui/views/base/base_viewmodel.dart';

class DashboardViewModel extends BaseViewModel {
  Portfolio _currentPortfolio;
  Portfolio get currentPortfolio => _currentPortfolio;
}
