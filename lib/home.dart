import 'package:data_app_motiva/providers/registration_privider.dart';
import 'package:data_app_motiva/registration_screen.dart';
import 'package:data_app_motiva/widgets/home_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  Future<void> _ascRefreshProducts(BuildContext context, int isAsc) async {
    await Provider.of<Registrations>(context, listen: false)
        .sortProducts(isAsc);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text(
          'Home',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: GestureDetector(
              onTap: () async {
                await showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('Sorted by age:'),
                    actionsAlignment: MainAxisAlignment.center,
                    actions: [
                      ElevatedButton(
                        onPressed: () {
                          _ascRefreshProducts(context, 1).then((value) {
                            Navigator.of(context).pop();
                          });
                        },
                        child: const Text('ascending'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _ascRefreshProducts(context, 2).then((value) {
                            Navigator.of(context).pop();
                          });
                        },
                        child: const Text('descending'),
                      ),
                    ],
                  ),
                );
              },
              child: const Icon(
                Icons.sort,
              ),
            ),
          )
        ],
      ),
      body: FutureBuilder(
        future: _ascRefreshProducts(context, 0),
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : RefreshIndicator(
                onRefresh: () => _ascRefreshProducts(context, 0),
                child: Consumer<Registrations>(
                  builder: (ctx, productsData, _) => Padding(
                    padding: const EdgeInsets.all(8),
                    child: productsData.reservations.length == 0
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Card(
                                  color: Colors.orange,
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'No Data!',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16),
                                    ),
                                  ),
                                ),
                                Card(
                                    color: Colors.orange,
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        'Please add data by yourself!',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16),
                                      ),
                                    ))
                              ],
                            ),
                          )
                        : ListView.builder(
                            itemCount: productsData.reservations.length,
                            itemBuilder: (_, i) => Column(
                              children: [
                                HomeCard(
                                  name: productsData.reservations[i].name,
                                  surname: productsData.reservations[i].surname,
                                  age: productsData.reservations[i].age,
                                ),
                              ],
                            ),
                          ),
                  ),
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        splashColor: Colors.deepOrangeAccent,
        backgroundColor: Colors.orange,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SignUp(),
            ),
          );
        },
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
    );
  }
}
