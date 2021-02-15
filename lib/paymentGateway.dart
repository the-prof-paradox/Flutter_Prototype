import 'package:flutter/material.dart';
import 'package:upi_pay/upi_pay.dart';
import 'dart:math';

class Payments extends StatefulWidget {
  @override
  _PaymentsState createState() => _PaymentsState();
}

class _PaymentsState extends State<Payments> {
  String _upiAddrError;

  final _upiAddressController = TextEditingController();
  final _amountController = TextEditingController();

  bool _isUpiEditable = false;
  Future<List<ApplicationMeta>> _appsFuture;

  @override
  void initState() {
    super.initState();

    _amountController.text = 'Select a plan';
    _appsFuture = UpiPay.getInstalledUpiApplications();
  }

  @override
  void dispose() {
    _amountController.dispose();
    _upiAddressController.dispose();
    super.dispose();
  }

  void _generateAmount() {
    String plan = 'Select a plan';
    showDialog(
      context: context,
      barrierDismissible: false,
      child: AlertDialog(
        title: Text('Subsciption Plan'),
        scrollable: true,
        actions: [
          FlatButton(
            onPressed: (){
              setState(() {
                _amountController.text = 'Select a plan';
              });
              Navigator.pop(context);
            },
            child: Text('Cancel'),
          ),
          FlatButton(
            onPressed: (){
              Navigator.pop(context);
            },
            child: Text('Ok'),
          ),
        ],
        content: Column(
          children: [
            RadioListTile(
              title: Text('Monthly: INR 200'),
              value: '200.00',
              groupValue: plan,
              activeColor: Colors.blueAccent,
              
              onChanged: (val){
                setState(() {
              
                  plan=val;
                  _amountController.text = plan;
                });
              }
            ),
            RadioListTile(
              title: Text('Quaterly: INR 500'),
              value: '500.00',
              groupValue: plan,
              activeColor: Colors.blueAccent,
              
              onChanged: (val){
                setState(() {
              
                  plan=val;
                  _amountController.text = plan;
                });
              }
            ),
            RadioListTile(
              title: Text('Annually: INR 2000'),
              value: '2000.00',
              groupValue: plan,
              activeColor: Colors.blueAccent,
              
              onChanged: (val){
                setState(() {
                  
                  plan=val;
                  _amountController.text = plan;
                });
              }
            ),
          ],
        ),
      ),
      );
  }

  Future<void> _onTap(ApplicationMeta app) async {
    final err = _validateUpiAddress(_upiAddressController.text);
    if (err != null) {
      setState(() {
        _upiAddrError = err;
      });
      return;
    }
    setState(() {
      _upiAddrError = null;
    });

    final transactionRef = Random.secure().nextInt(1 << 32).toString();
    print("Starting transaction with id $transactionRef");

    final a = await UpiPay.initiateTransaction(
      amount: _amountController.text,
      app: app.upiApplication,
      receiverName: 'Sharad',
      receiverUpiAddress: _upiAddressController.text,
      transactionRef: transactionRef,
      merchantCode: '7372',
    );

    print(a);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select your plan'),
      ),
          body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 32),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      controller: _upiAddressController,
                      enabled: _isUpiEditable,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'address@upi',
                        labelText: 'Receiving UPI Address',
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 8),
                    child: IconButton(
                      icon: Icon(
                        _isUpiEditable ? Icons.check : Icons.edit,
                      ),
                      onPressed: () {
                        setState(() {
                          _isUpiEditable = !_isUpiEditable;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            if (_upiAddrError != null)
              Container(
                margin: EdgeInsets.only(top: 4, left: 12),
                child: Text(
                  _upiAddrError,
                  style: TextStyle(color: Colors.red),
                ),
              ),
            Container(
              margin: EdgeInsets.only(top: 32),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: _amountController,
                      readOnly: true,
                      enabled: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Amount',
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 8),
                    child: IconButton(
                      icon: Icon(Icons.arrow_drop_down),
                      onPressed: _generateAmount,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 128, bottom: 32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 12),
                    child: Text(
                      'Pay Using',
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ),
                  FutureBuilder<List<ApplicationMeta>>(
                    future: _appsFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState != ConnectionState.done) {
                        return Container();
                      }

                      return GridView.count(
                        crossAxisCount: 2,
                        shrinkWrap: true,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        childAspectRatio: 1.6,
                        physics: NeverScrollableScrollPhysics(),
                        children: snapshot.data
                            .map((it) => Material(
                                  key: ObjectKey(it.upiApplication),
                                  color: Colors.grey[200],
                                  child: InkWell(
                                    onTap: () => _onTap(it),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Image.memory(
                                          it.icon,
                                          width: 64,
                                          height: 64,
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 4),
                                          child: Text(
                                            it.upiApplication.getAppName(),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ))
                            .toList(),
                      );
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

String _validateUpiAddress(String value) {
  if (value.isEmpty) {
    return 'UPI Address is required.';
  }

  if (!UpiPay.checkIfUpiAddressIsValid(value)) {
    return 'UPI Address is invalid.';
  }

  return null;
}