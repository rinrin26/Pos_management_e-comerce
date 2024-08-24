import 'package:final_project_application_pos/UI/widget/button_widget.dart';
import 'package:flutter/material.dart';

class AlertDialogWidget extends StatelessWidget {
  final String title;
  final String content;
  final String confirmButtonText;
  final VoidCallback onConfirm;

  const AlertDialogWidget({
    Key? key,
    required this.title,
    required this.content,
    required this.confirmButtonText,
    required this.onConfirm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          width: 300, // Adjust the width as needed
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                title,
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                content,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ButtonWidget(
                  buttonColor: Colors.amber.shade900,
                  btnWidth: 144,
                  btnHeight: 44,
                  onPressed: () {
                    onConfirm();
                    Navigator.of(context).pop();
                  },
                  text: confirmButtonText,
                  textColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void showCustomAlertDialog(
  BuildContext context,
  String title,
  String content,
  String confirmButtonText,
  VoidCallback onConfirm,
) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialogWidget(
        title: title,
        content: content,
        confirmButtonText: confirmButtonText,
        onConfirm: onConfirm,
      );
    },
  );
}
