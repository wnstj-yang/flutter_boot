import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // type이...
  final Map<String, Map<String, dynamic>> description = {
    'bolt': {
      'title': "Preminum features",
      'content':
          "Plus subscribers have access to FlutterBoot+ and out latest beta features",
      'icon': const Icon(
        Icons.bolt,
        size: 36,
      ),
    },
    'whatshot': {
      'title': "Priority access",
      'content': "you'll be able to use FlutterBoot+ even when demand is high",
      'icon': const Icon(
        Icons.whatshot,
        size: 36,
      ),
    },
    'speed': {
      'title': "Ultra-fast",
      'content': "Enjoy even faster response speeds when using FlutterBoot",
      'icon': const Icon(
        Icons.speed,
        size: 36,
      ),
    },
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Spacer(),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                'FlutterBoot Plus',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 36,
                ),
              ),
            ),
            DescriptionCard(
              description: description['bolt'],
              icon: description['bolt']?['icon'],
            ),
            DescriptionCard(
              description: description['whatshot'],
              icon: description['whatshot']?['icon'],
            ),
            DescriptionCard(
              description: description['speed'],
              icon: description['speed']?['icon'],
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Restore subscription",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Auto-renews for \$25/month until canceled",
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                            ),
                            child: const Text(
                              'Subscribe',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
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

class DescriptionCard extends StatefulWidget {
  const DescriptionCard({super.key, this.description, required Icon icon});

  final dynamic description;

  @override
  State<DescriptionCard> createState() => _DescriptionCardState();
}

class _DescriptionCardState extends State<DescriptionCard> {
  // final title = this.descr
  @override
  Widget build(BuildContext context) {
    return ListTile(
      // Column - Icon상단에 위치시키기 위함
      leading: Column(
        children: [
          widget.description['icon'],
        ],
      ),
      title: Text(
        widget.description['title'],
      ),
      subtitle: Text(
        widget.description['content'],
      ),
    );
  }
}
