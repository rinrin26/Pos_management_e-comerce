import 'package:final_project_application_pos/UI/user%20page/payment/pdf/pdf_preview_page.dart';
import 'package:final_project_application_pos/model/invoice_model.dart';
import 'package:final_project_application_pos/router/route_names.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class StatusOrderPaymentScreen extends StatefulWidget {
  final String paymentMethodName;

  const StatusOrderPaymentScreen({super.key, required this.paymentMethodName});

  @override
  State<StatusOrderPaymentScreen> createState() =>
      _StatusOrderPaymentScreenState();
}

class _StatusOrderPaymentScreenState extends State<StatusOrderPaymentScreen> {
  InvoiceModel invoices = 
    InvoiceModel(
      'Rinrin Karmila',
      '123 Elm Street, Springfield',
      [
        OrderItem(
          orderId: 'ORD001',
          productId: 101,
          productName: 'Mens Casual Slim Fit',
          quantity: 1,
          price: 1200.00,
          total: 1200.00,
        ),
        OrderItem(
          orderId: 'ORD002',
          productId: 102,
          productName: 'Mens Cotton Jacket',
          quantity: 2,
          price: 25.00,
          total: 50.00,
        ),
        OrderItem(
          orderId: 'ORD003',
          productId: 103,
          productName: 'jumpsuit white cozy',
          quantity: 1,
          price: 75.00,
          total: 75.00,
        ),
        OrderItem(
          orderId: 'ORD004',
          productId: 104,
          productName: 'Classic Heather Gray Hoodie',
          quantity: 1,
          price: 300.00,
          total: 300.00,
        ),
      ],
      'TRXID123444',
    );
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Success'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          PdfPreviewPage(invoice: invoices ,paymentMethodName:  widget.paymentMethodName),
                    ),
                  );
                },
                icon: Icon(
                  Icons.picture_as_pdf,
                  color: Colors.blue.shade800,
                  size: 40,
                )),
          )
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 100,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Payment Successful!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Thank you for your purchase.',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 20),
                const Divider(),
                // _cardNameWidget(),
                _itemOrder(invoices),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 20),
                  child:  _buildDetailRow(
                      'Payment Method:', widget.paymentMethodName),
                ),
                const Divider(),
                const SizedBox(height: 100),
                ElevatedButton(
                  onPressed: () {
                    context.push(RouteNames.beranda);
                  },
                  child: const Text('Back to Home'),
                ),
              ],
            ),
          ),
 

        ],
            ),
    );
  }

  Widget _buildOrderDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDetailRow('Order ID:', '2sjdjdkkdkm'),
        _buildDetailRow('Payment Method:', widget.paymentMethodName),
        _buildDetailRow('Total Amount:', 'Rp.123.243.44')
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 10),
          Text(value,
            style: const TextStyle(
              fontSize: 16,
             
            ),
          ),
        ],
      ),
    );
  }

  Padding _cardNameWidget() => Padding(
        padding: const EdgeInsets.all(15.0),
        child: Card(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'Customer',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              Expanded(
                child: Text(
                  'invoice.customer',
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      );
  Padding _itemOrder(InvoiceModel invoice) => Padding(
        padding: const EdgeInsets.all(5.0),
        child: Card(
          child: Column(
            children: [
              Text(
                'Order Items',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              ...invoice.items
                  .map(
                    (e) => ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16.0),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                           'OrderId: ${e.orderId}',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16.0),
                          ),
                          const SizedBox(height: 4.0),
                          Text(
                            'Produk: ${e.productName}' ?? 'No Name',
                            style: TextStyle(
                                fontSize: 14.0, color: Colors.grey[700]),
                          ),
                          const SizedBox(height: 4.0),
                          Text(
                            'Quantity: ${e.quantity}',
                            style: TextStyle(
                                fontSize: 14.0, color: Colors.grey[600]),
                          ),
                        ],
                      ),
                      trailing: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Price: \$${e.price!.toStringAsFixed(2)}',
                            style: TextStyle(
                                fontSize: 14.0, color: Colors.green[700]),
                          ),
                          const SizedBox(height: 4.0),
                          Text(
                            'Total: \$${e.total!.toStringAsFixed(2)}',
                            style: const TextStyle(
                                fontSize: 14.0, color: Colors.black87),
                          ),
                        ],
                      ),
                    ),
                  ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        "Total Amount",
                        textAlign: TextAlign.left,
                        style:
                            Theme.of(context).textTheme.headlineMedium!.copyWith(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        invoice.totalCost().toStringAsFixed(2),
                        textAlign: TextAlign.right,
                        style:
                            Theme.of(context).textTheme.headlineMedium!.copyWith(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                    ),
                  
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
