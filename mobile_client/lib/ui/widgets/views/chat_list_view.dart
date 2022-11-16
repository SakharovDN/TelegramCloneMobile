import 'package:flutter/material.dart';
import 'package:telegram_clone/domain/data_providers/storage_data_provider.dart';
import 'package:telegram_clone/ui/routes/app_router.dart';
import 'package:telegram_clone/ui/widgets/main/scroll_behavior.dart';

class ChatListView extends StatefulWidget {
  const ChatListView({Key? key}) : super(key: key);

  @override
  ChatListViewState createState() => ChatListViewState();
}

class ChatListViewState extends State<ChatListView> {
  final _storageDataProvider = StorageDataProvider();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Telegram'),
        backgroundColor: theme.primaryColor,
      ),
      body: StretchingOverscrollIndicator(
        axisDirection: AxisDirection.down,
        child: ScrollConfiguration(
          behavior: AppScrollBehavior(),
          child: ListView.builder(
            itemBuilder: ((context, index) {
              return const _ChatItem();
            }),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: theme.primaryColor,
        onPressed: () {
          _storageDataProvider.setToken(null);
          Navigator.pushReplacementNamed(context, RouteNames.welcomeView);
        },
        child: const Icon(Icons.exit_to_app),
      ),
    );
  }
}

class _ChatItem extends StatelessWidget {
  const _ChatItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              radius: 28,
              child: Text(
                'R',
                style: theme.textTheme.titleLarge?.copyWith(color: Colors.white),
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey[350]!, width: 0.5),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'ZumBot',
                        style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w500),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text(
                          '01:29',
                          style: theme.textTheme.labelMedium?.copyWith(color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          'Давно выяснено, что при  дизайна и композиции читаемый текст мешает сосредоточиться. Lorem Ipsum используют потому, ',
                          style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: CircleAvatar(
                          radius: 12,
                          backgroundColor: Colors.grey[400],
                          child: Text(
                            '3',
                            style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
