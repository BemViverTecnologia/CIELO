package com.bemvivertecnologia.poppy;

import android.content.ContextWrapper;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.BatteryManager;
import android.os.Build.VERSION;
import android.os.Build.VERSION_CODES;

import androidx.annotation.NonNull;

import java.util.List;

import cielo.orders.domain.CheckoutRequest;
import cielo.orders.domain.Credentials;
import cielo.orders.domain.Item;
import cielo.orders.domain.Order;
import cielo.sdk.order.OrderManager;
import cielo.sdk.order.ServiceBindListener;
import cielo.sdk.order.payment.PaymentCode;
import cielo.sdk.order.payment.PaymentError;
import cielo.sdk.order.payment.PaymentListener;
import io.flutter.Log;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "samples.flutter.dev/battery";
    private OrderManager orderManager;

    public Order order;
    public String payment = "aguardando...";

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler(
                        (call, result) -> {
                            // Note: this method is invoked on the main thread.
                            if (call.method.equals("createOrder")) {

                                configSDK(call.argument("ref"));


                                result.success(true);
                            } else if (call.method.equals("getOrder")){
                                try {
                                    final String id = order.getId();

                                    result.success(id);

                                } catch (Exception e){
                                    result.error("500", "Ordem ainda não criada",null);
                                };
                            } else if (call.method.equals("addItem")) {
                                final String res = addItemToOrder();

                                result.success(res);
                            } else if(call.method.equals("closeOrder")) {
                                closeOrder();
                                result.success(true);
                            } else if(call.method.equals("requestPayment")){
                                requestPayment();
                                result.success(true);
                            } else if(call.method.equals("checkPayment")){
                                result.success(payment);
                            }
                            else {
                                result.notImplemented();
                            }
                        }
                );
    }



    protected void configSDK(final String ref) {
        Credentials credentials = new Credentials( "", "");
        orderManager = new OrderManager(credentials, this);

        ServiceBindListener serviceBindListener = new ServiceBindListener() {

            @Override public void onServiceBoundError(Throwable throwable) {
                //Ocorreu um erro ao tentar se conectar com o serviço OrderManager
            }

            @Override
            public void onServiceBound() {
                //Você deve garantir que sua aplicação se conectou com a LIO a partir desse listener
                //A partir desse momento você pode utilizar as funções do OrderManager, caso contrário uma exceção será lançada.

                order = orderManager.createDraftOrder(ref);

                Log.d("ServiceBind","ordem criada = id: " + order.getId() + "referencia: " + order.getReference());
            }

            @Override
            public void onServiceUnbound() {
                // O serviço foi desvinculado
            }
        };

        orderManager.bind(this, serviceBindListener);

    }

    private String addItemToOrder(){

        // Identificação do produto (Stock Keeping Unit)
        String sku = "2891820317391823";
        String name = "Coca-cola lata";

        // Preço unitário em centavos
        int unitPrice = 550;
        int quantity = 3;

        // Unidade de medida do produto String
        String unityOfMeasure = "UNIDADE";

        order.addItem(sku, name, unitPrice, quantity, unityOfMeasure);

        return order.getItems().toString();
    }

    private void closeOrder(){
        orderManager.placeOrder(order);
    }

    private void requestPayment() {
        payment = "aguardando...";
        PaymentListener paymentListener = new PaymentListener() {

            @Override
            public void onStart() {
                Log.d("Payment", "ON START");

            }

            @Override
            public void onPayment(Order order) {
                Log.d("Payment", "ON PAYMENT");
                Log.d("order",order.toString());

                payment = "Sucesso";
            }

            @Override
            public void onError(PaymentError paymentError) {
            payment = "Erro";
            }

            @Override
            public void onCancel() {
            payment = "Cancelado";
            }
        };

        CheckoutRequest request = new CheckoutRequest.Builder()
                .orderId(order.getId()) /* Obrigatório */
                .amount(123456789) /* Opcional */
                .email("teste@email.com") /* Opcional */
                .paymentCode(PaymentCode.CREDITO_AVISTA) /* Opcional */
                .build();


        orderManager.checkoutOrder(request, paymentListener);
    }
}
