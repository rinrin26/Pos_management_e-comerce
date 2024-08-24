import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:final_project_application_pos/model/invoice_model.dart';

Future<Uint8List> makePdf(
    InvoiceModel invoice, String paymentMethodName) async {
  final pdf = pw.Document();
  final imageLogo = pw.MemoryImage(
      (await rootBundle.load('assets/images/shop.png')).buffer.asUint8List());

  pdf.addPage(pw.Page(build: (pw.Context context) {
    return pw
        .Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
      pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                "Dear : ${invoice.customer}",
                style: const pw.TextStyle(fontSize: 18),
              ),
              pw.Text(
                invoice.address,
                style: const pw.TextStyle(fontSize: 16),
              ),
            ],
          ),
          pw.SizedBox(
            height: 150,
            width: 150,
            child: pw.Image(imageLogo),
          )
        ],
      ),
      pw.Padding(
        child: pw.Text(
          "Thank you for your purchase! Your payment has been successfully processed. Below are the details of your order:",
          style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
        ),
        padding: const pw.EdgeInsets.all(10),
      ),
      pw.Table(
        border: pw.TableBorder.all(color: PdfColors.black),
        children: [
          pw.TableRow(
            children: [
              pw.Padding(
                child: pw.Text(
                  'ORDER DETAILS',
                  style: pw.TextStyle(
                      fontSize: 18, fontWeight: pw.FontWeight.bold),
                  textAlign: pw.TextAlign.center,
                ),
                padding: const pw.EdgeInsets.all(20),
              ),
            ],
          ),
          ...invoice.items.map(
            (e) => pw.TableRow(
              children: [
                pw.Expanded(
                  child: pw.Padding(
                    padding: const pw.EdgeInsets.all(10),
                    child: pw.Text('${e.productName ?? ''} - ${e.quantity}',
                        textAlign: pw.TextAlign.left),
                  ),
                  flex: 2,
                ),
                pw.Expanded(
                  child: pw.Padding(
                    padding: const pw.EdgeInsets.all(10),
                    child: pw.Text("\$${e.price?.toStringAsFixed(2) ?? ''}",
                        textAlign: pw.TextAlign.right),
                  ),
                  flex: 1,
                ),
              ],
            ),
          ),
          pw.TableRow(
            children: [
              pw.Padding(
                child: pw.Text('TAX', textAlign: pw.TextAlign.right),
                padding: const pw.EdgeInsets.all(10),
              ),
              pw.Padding(
                child: pw.Text(
                    '\$${(invoice.totalCost() * 0.1).toStringAsFixed(2)}'),
                padding: const pw.EdgeInsets.all(10),
              ),
            ],
          ),
          pw.TableRow(
            children: [
              pw.Padding(
                child:
                    pw.Text('TOTAL AMOUNT PAID', textAlign: pw.TextAlign.right),
                padding: const pw.EdgeInsets.all(10),
              ),
              pw.Padding(
                child: pw.Text("\$${invoice.totalCost().toStringAsFixed(2)}"),
                padding: const pw.EdgeInsets.all(10),
              ),
            ],
          ),
          pw.TableRow(
            children: [
              pw.Padding(
                child: pw.Text(
                  'PAYMENT METHOD',
                  style: pw.TextStyle(
                      fontSize: 18, fontWeight: pw.FontWeight.bold),
                  textAlign: pw.TextAlign.center,
                ),
                padding: const pw.EdgeInsets.all(10),
              ),
            ],
          ),
          pw.TableRow(
            children: [
              pw.Padding(
                child: pw.Text('Method  - ${paymentMethodName}',
                    textAlign: pw.TextAlign.right),
                padding: const pw.EdgeInsets.all(10),
              ),
              pw.Padding(
                child: pw.Text('TransactionId : ${invoice.transactionId}'),
                padding: const pw.EdgeInsets.all(10),
              ),
            ],
          ),
        ],
      ),
      pw.Padding(
        child: pw.Text(
          "Your order is now being processed and will be dispatched soon. Well notify you as soon as your items are on their way.",
          style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
        ),
        padding: const pw.EdgeInsets.all(20),
      ),
      pw.Text(
        "If you have any questions or need further assistance, please don't hesitate to contact our support team.",
      ),
       pw.Text(
        "Thank you for shopping with us!",
      ),
       pw.Text(
        "Best regards,",
      ),

       pw.Text(
        "Rinrin Bilionery Company,",
      ),
      
      pw.Divider(
        height: 1,
        borderStyle: pw.BorderStyle.dashed,
      ),
      pw.SizedBox(height: 50),
    ]);
  }));

  return pdf.save();
}
