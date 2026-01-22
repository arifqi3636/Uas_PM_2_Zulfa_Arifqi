import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/feeding_provider.dart';
import '../providers/pond_provider.dart';
import '../providers/feed_provider.dart';
import '../models/feeding.dart';
import '../models/pond.dart';
import '../models/feed.dart';

class FeedingDataScreen extends StatefulWidget {
  const FeedingDataScreen({super.key});

  @override
  State<FeedingDataScreen> createState() => _FeedingDataScreenState();
}

class _FeedingDataScreenState extends State<FeedingDataScreen> {
  String _filterPond = 'all';
  String _filterFeed = 'all';
  DateTime? _filterDate;
  bool _showSchedule = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<FeedingProvider>(context, listen: false).loadFeedings();
      Provider.of<PondProvider>(context, listen: false).loadPonds();
      Provider.of<FeedProvider>(context, listen: false).loadFeeds();
    });
  }

  @override
  Widget build(BuildContext context) {
    final feedingProvider = Provider.of<FeedingProvider>(context);
    final pondProvider = Provider.of<PondProvider>(context);
    final feedProvider = Provider.of<FeedProvider>(context);
    final feedings = feedingProvider.feedings;
    final ponds = pondProvider.ponds;
    final feeds = feedProvider.feeds;

    // Apply filtering
    var filteredFeedings = feedings.where((feeding) {
      bool pondMatch = _filterPond == 'all' || feeding.pondId == _filterPond;
      bool feedMatch = _filterFeed == 'all' || feeds.firstWhere((f) => f.id == feeding.feedId, orElse: () => Feed(id: '', name: '', type: '', quantity: 0, unit: '', price: 0, date: DateTime.now().toString())).type == _filterFeed;
      bool dateMatch = _filterDate == null || DateFormat('yyyy-MM-dd').format(feeding.date) == DateFormat('yyyy-MM-dd').format(_filterDate!);
      return pondMatch && feedMatch && dateMatch;
    }).toList();

    // Calculate feeding statistics
    double totalFeedGiven = filteredFeedings.fold(0.0, (sum, f) => sum + f.quantity);
    int totalFeedingSessions = filteredFeedings.length;
    double averageFeedPerSession = totalFeedingSessions > 0 ? totalFeedGiven / totalFeedingSessions : 0;

    // Check for feeding schedule reminders
    List<String> reminders = _generateFeedingReminders(ponds, feedings);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Pemberian Pakan'),
        backgroundColor: Colors.orange,
        actions: [
          IconButton(
            icon: Icon(_showSchedule ? Icons.list : Icons.schedule),
            onPressed: () => setState(() => _showSchedule = !_showSchedule),
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _showFilterDialog(context, ponds, feeds),
          ),
        ],
      ),
      body: feedingProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // Reminders
                if (reminders.isNotEmpty)
                  Container(
                    color: Colors.orange.shade100,
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: [
                        const Icon(Icons.access_time, color: Colors.orange),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            reminders.join('. '),
                            style: const TextStyle(color: Colors.orange),
                          ),
                        ),
                      ],
                    ),
                  ),

                // Summary cards
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: _buildSummaryCard('Total Pakan', '${totalFeedGiven.toStringAsFixed(1)}kg', Icons.restaurant_menu, Colors.orange),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildSummaryCard('Sesi Pemberian', totalFeedingSessions.toString(), Icons.schedule, Colors.blue),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: _buildSummaryCard('Rata-rata/Sesi', '${averageFeedPerSession.toStringAsFixed(1)}kg', Icons.analytics, Colors.green),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildSummaryCard('Kolam Terlayani', ponds.length.toString(), Icons.pool, Colors.teal),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: _showSchedule ? _buildFeedingSchedule(ponds, feeds) : _buildFeedingList(filteredFeedings, ponds, feeds),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddFeedingDialog(context, feedingProvider, ponds, feeds);
        },
        backgroundColor: Colors.orange,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildFeedingSchedule(List<Pond> ponds, List<Feed> feeds) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      children: [
        const Center(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Jadwal Pemberian Pakan',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        // TODO: Implement feeding schedule view
        const Center(
          child: Text('Fitur jadwal pemberian pakan akan segera hadir'),
        ),
      ],
    );
  }

  void _showAddFeedingDialog(BuildContext context, FeedingProvider feedingProvider, List<Pond> ponds, List<Feed> feeds) {
    final formKey = GlobalKey<FormState>();
    String selectedPondId = ponds.isNotEmpty ? ponds.first.id : '';
    String selectedFeedId = feeds.isNotEmpty ? feeds.first.id : '';
    double quantity = 0;
    String unit = 'kg';
    DateTime selectedDate = DateTime.now();
    String notes = '';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Tambah Data Pemberian Pakan'),
        content: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField<String>(
                  initialValue: selectedPondId,
                  items: ponds.map((pond) => DropdownMenuItem(value: pond.id, child: Text(pond.name))).toList(),
                  onChanged: (value) => selectedPondId = value!,
                  decoration: const InputDecoration(labelText: 'Kolam'),
                ),
                DropdownButtonFormField<String>(
                  initialValue: selectedFeedId,
                  items: feeds.map((feed) => DropdownMenuItem(value: feed.id, child: Text(feed.name))).toList(),
                  onChanged: (value) => selectedFeedId = value!,
                  decoration: const InputDecoration(labelText: 'Pakan'),
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Jumlah'),
                  keyboardType: TextInputType.number,
                  validator: (value) => value!.isEmpty ? 'Jumlah harus diisi' : null,
                  onSaved: (value) => quantity = double.parse(value!),
                ),
                TextFormField(
                  initialValue: unit,
                  onSaved: (value) => unit = value!,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Catatan'),
                  onSaved: (value) => notes = value!,
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Batal')),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                formKey.currentState!.save();
                final feeding = Feeding(
                  id: '',
                  pondId: selectedPondId,
                  feedId: selectedFeedId,
                  quantity: quantity,
                  unit: unit,
                  date: selectedDate,
                  notes: notes,
                );
                feedingProvider.addFeeding(feeding);
                Navigator.pop(context);
              }
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, IconData icon, Color color) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            colors: [color.withValues(alpha: 0.7), color],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            Icon(icon, size: 32, color: Colors.white),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            Text(
              title,
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeedingList(List feedings, List ponds, List feeds) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: feedings.length,
      itemBuilder: (context, index) {
        final feeding = feedings[index];
        final pond = ponds.firstWhere((p) => p.id == feeding.pondId, orElse: () => Pond(id: '', name: 'Unknown', length: 0, width: 0, depth: 0, status: '', imageUrl: ''));
        final feed = feeds.firstWhere((f) => f.name == feeding.feedType, orElse: () => Feed(id: '', name: 'Unknown', type: '', quantity: 0, unit: '', price: 0, date: ''));

        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          margin: const EdgeInsets.only(bottom: 16),
          child: Card(
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              leading: CircleAvatar(
                backgroundColor: Colors.orange.shade100,
                child: const Icon(Icons.restaurant_menu, color: Colors.orange),
              ),
              title: Text('${feeding.feedType} - ${feeding.quantity}kg'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Kolam: ${pond.name}'),
                  Text('Tanggal: ${feeding.date}'),
                  Text('Waktu: ${feeding.time}'),
                ],
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  Provider.of<FeedingProvider>(context, listen: false).deleteFeeding(feeding.id);
                },
              ),
            ),
          ),
        );
      },
    );
  }

  List<String> _generateFeedingReminders(List ponds, List feedings) {
    List<String> reminders = [];
    DateTime now = DateTime.now();
    String today = DateFormat('yyyy-MM-dd').format(now);

    for (var pond in ponds) {
      var todayFeedings = feedings.where((f) => f.pondId == pond.id && f.date == today).toList();
      if (todayFeedings.isEmpty) {
        reminders.add('Kolam ${pond.name} belum diberi pakan hari ini');
      } else if (todayFeedings.length < 2) {
        reminders.add('Kolam ${pond.name} hanya diberi pakan ${todayFeedings.length}x hari ini');
      }
    }

    return reminders;
  }

  void _showFilterDialog(BuildContext context, List ponds, List feeds) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Filter Pemberian Pakan'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<String>(
              value: _filterPond,
              decoration: const InputDecoration(labelText: 'Kolam'),
              items: [
                const DropdownMenuItem(value: 'all', child: Text('Semua Kolam')),
                ...ponds.map((pond) => DropdownMenuItem(
                      value: pond.id,
                      child: Text(pond.name),
                    )),
              ],
              onChanged: (value) => setState(() => _filterPond = value ?? 'all'),
            ),
            DropdownButtonFormField<String>(
              value: _filterFeed,
              decoration: const InputDecoration(labelText: 'Tipe Pakan'),
              items: [
                const DropdownMenuItem(value: 'all', child: Text('Semua Tipe')),
                ...feeds.map((feed) => DropdownMenuItem(
                      value: feed.name,
                      child: Text(feed.name),
                    )),
              ],
              onChanged: (value) => setState(() => _filterFeed = value ?? 'all'),
            ),
            ListTile(
              title: const Text('Tanggal'),
              subtitle: Text(_filterDate != null ? DateFormat('yyyy-MM-dd').format(_filterDate!) : 'Semua tanggal'),
              trailing: IconButton(
                icon: const Icon(Icons.calendar_today),
                onPressed: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: _filterDate ?? DateTime.now(),
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2030),
                  );
                  if (date != null) {
                    setState(() => _filterDate = date);
                  }
                },
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => setState(() {
              _filterPond = 'all';
              _filterFeed = 'all';
              _filterDate = null;
              Navigator.pop(context);
            }),
            child: const Text('Reset'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }

  void _scheduleFeedingForPond(Pond pond, BuildContext context) {
    // This would integrate with a scheduling system
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Jadwal pemberian pakan untuk ${pond.name} telah diatur')),
    );
  }
}