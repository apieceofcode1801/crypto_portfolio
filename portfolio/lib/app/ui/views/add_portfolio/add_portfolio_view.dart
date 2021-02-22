import 'package:flutter/material.dart';
import 'package:portfolio/app/ui/views/add_portfolio/add_portfolio_viewmodel.dart';
import 'package:portfolio/core/base_view.dart';

class AddPortfolioView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BaseView<AddPortfolioViewModel>(
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Add your portfolio'),
          ),
          body: Container(
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
                    TextButton(
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            await model.addPortfolio();
                            Navigator.pop(context);
                          }
                        },
                        child: const Text('Submit'))
                  ],
                )),
          ),
        );
      },
    );
  }
}
