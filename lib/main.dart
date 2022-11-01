import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'title'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    final ProviderClass data = Get.put(ProviderClass());
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Obx(() {
              return Text(
                '${data._counter}',
                style: Theme.of(context).textTheme.headline4,
              );
            }),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'btn-1',
            onPressed: () {
              Get.to(() => const MyFavoriteFruit());
            },
            tooltip: 'Navigate',
            child: const Icon(Icons.navigate_next),
          ),
          const SizedBox(
            width: 5,
          ),
          FloatingActionButton(
            heroTag: 'btn-2',
            onPressed: data._incrementCounter,
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
          const SizedBox(
            width: 5,
          ),
          FloatingActionButton(
            heroTag: 'btn-3',
            onPressed: data._decrementCounter,
            tooltip: 'Decrement',
            child: const Icon(Icons.remove),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class ProviderClass extends GetxController {
  var _counter = 0.obs;
  var favFruit = 'Unknown'.obs;
  //var favFruit = ('Unknown').obs;
  static ProviderClass get to => Get.find();
  void _incrementCounter() {
    _counter++;
  }

  void selectedFruit(var selected) {
    favFruit.value = selected;
  }

  void _decrementCounter() {
    _counter--;
  }
}

class GetTester extends StatelessWidget {
  const GetTester({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProviderClass text = Get.find();
    return Scaffold(
      appBar: AppBar(
        title: Text('${text._counter}'),
      ),
    );
  }
}

class GetTester2 extends StatelessWidget {
  const GetTester2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter GetX State Management Demo"),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.teal,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ProviderClass.to._incrementCounter,
        tooltip: 'Increment',
        backgroundColor: Colors.cyan,
        child: const Icon(Icons.add),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Image.network(
              "https://images.unsplash.com/photo-1666978460851-2ecda573e389?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1887&q=80",
              width: 300,
              height: 250,
            ),
            const SizedBox(
              height: 50,
            ),
            const Text(
              'You have pushed the button this many times:',
            ),
            Obx(
              () => Text(
                '${ProviderClass.to._counter}',
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 18),
                  backgroundColor: Colors.teal,
                ),
                onPressed: () {
                  Get.snackbar('GetX Snackbar', 'Yay! Awesome GetX Snackbar',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.tealAccent);
                },
                child: const Text('Show Snackbar')),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 18),
                  backgroundColor: Colors.teal,
                ),
                onPressed: () {
                  Get.defaultDialog(
                      title: 'GetX Alert',
                      middleText: 'Simple GetX alert',
                      textConfirm: 'Okay',
                      confirmTextColor: Colors.white,
                      textCancel: 'Cancel');
                },
                child: const Text('Show AlertDialog')),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 20),
                  backgroundColor: Colors.teal,
                  minimumSize: const Size.fromHeight(40),
                ),
                child: Row(
                  children: const [
                    Spacer(),
                    Text("Go to next screen"),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                        child: Icon(
                      Icons.arrow_right_alt,
                      size: 40,
                    ))
                  ],
                ),
                onPressed: () {
                  Get.to(() => const GetTester());
                },
                onLongPress: () => Get.to(
                  () => const MyHomePage(title: 'Returned'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyFavoriteFruit extends StatelessWidget {
  const MyFavoriteFruit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() {
          return Text('My Fav Fruit is ${ProviderClass.to.favFruit}');
        }),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MaterialButton(
              color: Colors.black,
              onPressed: () {
                ProviderClass.to.selectedFruit('Apple');
              },
              child: const Text(
                'Apple',
                style: TextStyle(color: Colors.white),
              ),
            ),
            MaterialButton(
              onPressed: () {
                ProviderClass.to.selectedFruit('Orange');
              },
              color: Colors.black,
              padding: EdgeInsets.all(10),
              child: const Text(
                'Orange',
                style: TextStyle(color: Colors.white),
              ),
            ),
            MaterialButton(
              color: Colors.black,
              onPressed: () {
                ProviderClass.to.selectedFruit('Banana');
              },
              child: const Text(
                'Banana',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
