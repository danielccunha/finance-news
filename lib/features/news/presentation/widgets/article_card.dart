import 'package:cached_network_image/cached_network_image.dart';
import 'package:finance_news/core/widgets/loading.dart';
import 'package:finance_news/features/news/domain/entities/article.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticleCard extends StatelessWidget {
  static final _format = DateFormat("dd/MM/yyyy às HH:mm");
  final Article article;

  const ArticleCard({
    Key key,
    @required this.article,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      elevation: 2,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(4),
        ),
      ),
      child: InkWell(
        onTap: launchArticle,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 100.0,
              width: 100.0,
              margin: const EdgeInsets.all(10.0),
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(3.0)),
                color: Colors.white.withAlpha(25),
              ),
              child: CachedNetworkImage(
                imageUrl: article.image,
                fit: BoxFit.cover,
                placeholder: (ctx, url) => const Loading(),
              ),
            ),
            Expanded(
              child: SizedBox(
                height: 100.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      article.title,
                      style: theme.textTheme.headline3,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      _format.format(article.publishedAt),
                      style: theme.textTheme.subtitle1,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 8.0),
          ],
        ),
      ),
    );
  }

  Future launchArticle() async {
    if (await canLaunch(article.link)) {
      await launch(article.link);
    }
  }
}
