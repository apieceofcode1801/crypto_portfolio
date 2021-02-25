import 'package:flutter/material.dart';
import 'package:portfolio/app/datamodels/porfolio.dart';
import 'package:portfolio/app/ui/helpers/ui_helpers.dart';
import 'package:portfolio/app/ui/views/add_portfolio/add_portfolio_viewmodel.dart';
import 'package:portfolio/core/base_view.dart';

class AddPortfolioView extends StatelessWidget {
  final Portfolio portfolio;
  AddPortfolioView({this.portfolio});

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BaseView<AddPortfolioViewModel>(
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: portfolio != null
                ? Text('Update your portfolio')
                : Text('Add your portfolio'),
            actions: portfolio != null
                ? [
                    IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          showAlertDialog(
                              context: context,
                              title:
                                  'Are you sure you want to delete this portfolio?',
                              content: 'Press continue to perform',
                              onContinue: () async {
                                await model.deletePortfolio();
                                Navigator.pop(context);
                              });
                        })
                  ]
                : [],
          ),
          body: Padding(
            padding: EdgeInsets.all(8),
            child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    TextFormField(
                      controller: model.nameController,
                      decoration: InputDecoration(
                        hintText: 'Name',
                      ),
                      validator: (text) =>
                          text.isEmpty ? 'Name must not be empty' : null,
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    TextButton(
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            await model.submitPortfolio();
                            Navigator.pop(context);
                          }
                        },
                        child: Text('Submit'))
                  ],
                )),
          ),
        );
      },
      onModelReady: (model) {
        model.setPortfolio(portfolio);
      },
    );
  }
}
