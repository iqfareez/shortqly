import 'package:flutter/material.dart';

class CreatePage extends StatefulWidget {
  @override
  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  final TextEditingController _linkEditingController = TextEditingController();
  String _generatedFdl = '';
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Material(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(Icons.arrow_back_ios_new_rounded)),
                    SizedBox(width: 10),
                    Text(
                      'Create',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 35,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: TextField(
                    controller: _linkEditingController,
                    decoration: InputDecoration(hintText: 'Enter URL here'),
                    keyboardType: TextInputType.url,
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: _linkEditingController.text.isEmpty
                      ? null
                      : () {
                          setState(() {
                            _generatedFdl =
                                'https://${_linkEditingController.text}';
                          });

                          //TODO: Fdl here
                        },
                  child: Text('Shorten link'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _generatedFdl,
                        style: TextStyle(fontSize: 20),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(onPressed: () {}, icon: Icon(Icons.copy)),
                          IconButton(onPressed: () {}, icon: Icon(Icons.share)),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.open_in_browser)),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
