import 'package:flutter/material.dart';
import 'package:portfolio/app/datamodels/asset.dart';
import 'package:portfolio/app/ui/views/alert/alert_view_model.dart';
import 'package:portfolio/core/base_view.dart';

class AlertView extends StatelessWidget {
  final String portfolioId;
  final Asset asset;
  const AlertView({@required this.portfolioId, @required this.asset});
  @override
  Widget build(BuildContext context) {
    return BaseView<AlertViewModel>(
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text('${asset.coinSymbol}\'s alerts'),
          actions: [
            IconButton(
                icon: Icon(Icons.add),
                onPressed: () async {
                  if (!await _showAlertDialog(context, model)) {
                    model.getAlerts(
                        portfolioId: portfolioId, coinId: asset.coinId);
                  }
                })
          ],
        ),
        body: Column(
          children: [
            Container(
              height: 44,
              child: Row(
                children: [
                  Expanded(
                    child: Text('Label'),
                    flex: 4,
                  ),
                  Expanded(
                    child: Text('Price'),
                    flex: 1,
                  )
                ],
              ),
            ),
            Expanded(
                child: ListView.separated(
              itemBuilder: (_, index) {
                final alert = model.alerts[index];
                return ListTile(
                  title: Row(
                    children: [
                      Expanded(
                        child: Text(alert.label),
                        flex: 4,
                      ),
                      Expanded(
                        child: Text('${alert.price}'),
                        flex: 1,
                      )
                    ],
                  ),
                );
              },
              itemCount: model.alerts.length,
              separatorBuilder: (context, index) => Divider(
                height: 1,
                color: Colors.grey[300],
              ),
            ))
          ],
        ),
      ),
      onModelReady: (model) {
        model.getAlerts(portfolioId: portfolioId, coinId: asset.coinId);
      },
    );
  }

  Future<bool> _showAlertDialog(BuildContext context, AlertViewModel model,
      {int alertIndex}) async {
    model.resetController();
    bool cancelled = true;
    await showDialog(
      context: context,
      builder: (context) => Scaffold(
          appBar: AppBar(
            title: Text(alertIndex != null ? 'Edit alert' : 'Add new alert'),
          ),
          body: Form(
              key: model.formKey,
              child: Wrap(
                children: [
                  TextFormField(
                    controller: model.labelController,
                    decoration: InputDecoration(hintText: 'Enter label'),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: model.priceController,
                    decoration: InputDecoration(hintText: 'Enter price'),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Row(
                    children: [
                      TextButton(
                          onPressed: () {
                            cancelled = true;
                            Navigator.pop(context);
                          },
                          child: Text('Cancel')),
                      const SizedBox(
                        width: 8,
                      ),
                      TextButton(
                          onPressed: () async {
                            if (alertIndex != null) {
                              await model.editAlert(index: alertIndex);
                            } else {
                              await model.addAlert(portfolioId, asset.coinId);
                            }
                            cancelled = false;
                            Navigator.pop(context);
                          },
                          child: Text('Submit'))
                    ],
                  )
                ],
              ))),
    );
    return cancelled;
  }
}
