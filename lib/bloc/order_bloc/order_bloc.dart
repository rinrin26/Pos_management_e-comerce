import 'package:bloc/bloc.dart';
import 'package:final_project_application_pos/model/order_model.dart';
import 'package:final_project_application_pos/model/product_model.dart';
import 'package:final_project_application_pos/services/firestore_services.dart';
part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
    FirestoreServices firestoreServices = FirestoreServices();
  OrderBloc() : super(OrderInitial()) {

     on<GetOrders>((event, emit) async {
      try {
        final orders = await firestoreServices.getOrders();
        print('======== data order bloc get orders $orders');
        emit(OrderLoaded(orders));
      } catch (e) {
        emit(OrderError('Failed to fetch orders: $e'));
      }
    });

    on<SaveOrderToFirestore>((event, emit) async {
      await firestoreServices.saveCheckoutOrder(event.order);
    });

    
  }
}
