import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../models/drawing.dart';
import '../services/database_service.dart';
import 'drawing_screen.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Gallery'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: DrawingSearchDelegate(),
              );
            },
          ),
        ],
      ),
      body: Consumer<DatabaseService>(
        builder: (context, dbService, _) {
          final drawings = _searchQuery.isEmpty
              ? dbService.getAllDrawings()
              : dbService.searchDrawings(_searchQuery);

          if (drawings.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.photo_library_outlined,
                    size: 100,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'No drawings yet',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Start creating your first masterpiece!',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ],
              ),
            );
          }

          // Sort by modified date (newest first)
          drawings.sort((a, b) => b.modifiedAt.compareTo(a.modifiedAt));

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.8,
            ),
            itemCount: drawings.length,
            itemBuilder: (context, index) {
              final drawing = drawings[index];
              return _DrawingCard(
                drawing: drawing,
                onTap: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DrawingScreen(existingDrawing: drawing),
                    ),
                  );
                },
                onDelete: () => _deleteDrawing(context, drawing),
                onShare: () => _shareDrawing(drawing),
              );
            },
          );
        },
      ),
    );
  }

  Future<void> _deleteDrawing(BuildContext context, Drawing drawing) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Drawing'),
          content: Text('Are you sure you want to delete "${drawing.name}"?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (confirmed == true && context.mounted) {
      await context.read<DatabaseService>().deleteDrawing(drawing.id);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Drawing deleted')),
        );
      }
    }
  }

  void _shareDrawing(Drawing drawing) {
    // In production, export drawing as image first
    Share.share(
      'Check out my drawing: ${drawing.name}\nCreated with ArtJoy!',
      subject: 'My Drawing',
    );
  }
}

class _DrawingCard extends StatelessWidget {
  final Drawing drawing;
  final VoidCallback onTap;
  final VoidCallback onDelete;
  final VoidCallback onShare;

  const _DrawingCard({
    required this.drawing,
    required this.onTap,
    required this.onDelete,
    required this.onShare,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Drawing Preview
            Expanded(
              child: Container(
                color: Colors.grey.shade100,
                child: Center(
                  child: Icon(
                    Icons.image,
                    size: 64,
                    color: Colors.grey.shade400,
                  ),
                ),
              ),
            ),

            // Drawing Info
            Container(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    drawing.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _formatDate(drawing.modifiedAt),
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.share, size: 20),
                        onPressed: onShare,
                        tooltip: 'Share',
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, size: 20),
                        color: Colors.red,
                        onPressed: onDelete,
                        tooltip: 'Delete',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'Today';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}

class DrawingSearchDelegate extends SearchDelegate<Drawing?> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSearchResults(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildSearchResults(context);
  }

  Widget _buildSearchResults(BuildContext context) {
    final dbService = context.watch<DatabaseService>();
    final results = dbService.searchDrawings(query);

    if (results.isEmpty) {
      return const Center(
        child: Text('No drawings found'),
      );
    }

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final drawing = results[index];
        return ListTile(
          leading: const Icon(Icons.image),
          title: Text(drawing.name),
          subtitle: Text(
            'Modified: ${drawing.modifiedAt.day}/${drawing.modifiedAt.month}/${drawing.modifiedAt.year}',
          ),
          onTap: () {
            close(context, drawing);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => DrawingScreen(existingDrawing: drawing),
              ),
            );
          },
        );
      },
    );
  }
}
