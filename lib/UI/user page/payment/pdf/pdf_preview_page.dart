import 'package:final_project_application_pos/UI/user%20page/payment/pdf/pdf.dart';
import 'package:final_project_application_pos/model/invoice_model.dart';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';


class PdfPreviewPage extends StatelessWidget {
  final InvoiceModel invoice;
  final String   paymentMethodName;
  const PdfPreviewPage({Key? key, required this.invoice, required this.paymentMethodName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Preview'),
      ),
      body: PdfPreview(
        build: (context) => makePdf(invoice,paymentMethodName),
      ),
    );
  }
}
