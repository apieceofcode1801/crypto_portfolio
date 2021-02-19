import 'package:flutter/material.dart';
import 'package:portfolio/app/models/portfolio_model.dart';
import 'package:portfolio/core/base_view.dart';

class AddPortfolioView extends StatelessWidget {
  TextEditingController _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BaseView<PortfolioModel>(
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
                      controller: _nameController,
                      decoration: InputDecoration(
                        hintText: 'Name',
                      ),
                      validator: (text) =>
                          text.isEmpty ? 'Name must not be empty' : null,
                    ),
                    TextButton(
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            final result =
                                await model.addPortfolio(_nameController.text);
                            if (result) {
                              Navigator.pop(context);
                            }
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
