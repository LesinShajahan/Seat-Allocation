import 'package:flutter/material.dart';

class ViewSeatAllocation extends StatelessWidget {
  final List<String> allocatedSeats;

  const ViewSeatAllocation({Key? key, required this.allocatedSeats})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Allocated Seats"),
      ),
      body: ListView.builder(
        itemCount: allocatedSeats.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(allocatedSeats[index]),
          );
        },
      ),
    );
  }
}
