import 'package:flutter/material.dart';

import '../app_configs/app_images.dart';
import '../models/data_table_model.dart';


class DataTableWidget extends StatefulWidget {
  const DataTableWidget({super.key});

  @override
  DataTableWidgetState createState() => DataTableWidgetState();
}

class DataTableWidgetState extends State<DataTableWidget> {
  int _rowsPerPage = 10;
  final Set<int> _expandedRows = Set<int>();
  final List<DataTableModel> _requests = List.generate(
    30,
        (index) => DataTableModel(
      date: "20 Jun 2024",
      requestNo: "LRIB${index.toString().padLeft(5, '0')}",
      type: "Inbound",
      modeOfTransportation: "Land - Part",
      status: "Pending Request",
    ),
  );

  void _toggleRowExpansion(int index) {
    setState(() {
      if (_expandedRows.contains(index)) {
        _expandedRows.remove(index);
      } else {
        _expandedRows.add(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: List.generate(
            _requests.length,
                (index) {
              final request = _requests[index];
              final isExpanded = _expandedRows.contains(index);

              return Column(
                children: [
                  DataRowWidget(
                    index: index,
                    request: request,
                    isExpanded: isExpanded,
                    onTap: () => _toggleRowExpansion(index),
                  ),
                  if (isExpanded)
                    Container(
                      width: double.maxFinite,
                      padding: const EdgeInsets.all(16),
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Additional details for ${request.date}"),
                          Text("Additional details for ${request.requestNo}"),
                          Text(
                              "Additional details for ${request.modeOfTransportation}"),
                          Text("Additional details for ${request.status}"),
                          Text("Additional details for ${request.type}"),
                          Text("Additional details for ${request.requestNo}"),
                          Text("Additional details for ${request.requestNo}"),
                          // Add more detailed information here
                        ],
                      ),
                    ),
                  // Divider between rows
                  Divider(
                    thickness: 1,
                    height: 1,
                    color: Colors.grey[300],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class DataRowWidget extends StatelessWidget {
  final int index;
  final DataTableModel request;
  final bool isExpanded;
  final VoidCallback onTap;

  const DataRowWidget({
    super.key,
    required this.index,
    required this.request,
    required this.isExpanded,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: isExpanded ? Colors.blueGrey[50] : Colors.white,
        child: Row(
          children: [
            Expanded(child: Text("${index + 1}")),
            Expanded(child: Text(request.date)),
            Expanded(child: Text(request.requestNo)),
            Expanded(child: Text(request.type)),
            Expanded(child: Text(request.modeOfTransportation)),
            Expanded(child: Text(request.status)),
            Container(
              padding: const EdgeInsets.all(8),
              child:  Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: GestureDetector(
                      onTap: onTap,
                      child: Image.asset(
                        AppImages.downArrowTable,
                        height: 20,
                        width: 20,
                        color: isExpanded ? Colors.red : null,
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Icon(Icons.edit),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
