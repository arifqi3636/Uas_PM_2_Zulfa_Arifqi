import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Laporan'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Laporan Produksi',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: BarChart(
                BarChartData(
                  barGroups: [
                    BarChartGroupData(x: 0, barRods: [BarChartRodData(toY: 10, color: Colors.blue)]),
                    BarChartGroupData(x: 1, barRods: [BarChartRodData(toY: 15, color: Colors.blue)]),
                    BarChartGroupData(x: 2, barRods: [BarChartRodData(toY: 12, color: Colors.blue)]),
                  ],
                  titlesData: FlTitlesData(show: false),
                  borderData: FlBorderData(show: false),
                ),
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              'Laporan Panen',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildHarvestTable(),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                // Export report
              },
              child: const Text('Ekspor Laporan'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHarvestTable() {
    return DataTable(
      columns: const [
        DataColumn(label: Text('Tanggal')),
        DataColumn(label: Text('Jumlah (kg)')),
        DataColumn(label: Text('Harga (Rp)')),
      ],
      rows: const [
        DataRow(cells: [
          DataCell(Text('2023-10-01')),
          DataCell(Text('50')),
          DataCell(Text('50000')),
        ]),
        DataRow(cells: [
          DataCell(Text('2023-10-15')),
          DataCell(Text('60')),
          DataCell(Text('60000')),
        ]),
      ],
    );
  }
}