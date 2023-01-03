import 'package:e_book_app/common/app_data.dart';
import 'package:flutter/material.dart';

class BookItemCard extends StatelessWidget {
  const BookItemCard({
    super.key,
    required this.imgUrl,
    required this.title,
    required this.producer,
    required this.description,
    required this.isRRated,
  });

  final String imgUrl;
  final String title;
  final String producer;
  final String description;
  final bool isRRated;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 2 / 3,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: isRRated
                ? Banner(
                    location: BannerLocation.topEnd,
                    message: 'R-rated',
                    child: Image.network(
                      AppData.imagePath(posterPath: imgUrl),
                      fit: BoxFit.fitHeight,
                      cacheHeight: 100,
                    ),
                  )
                : Image.network(
                    AppData.imagePath(posterPath: imgUrl),
                    fit: BoxFit.fitHeight,
                    cacheHeight: 400,
                  ),
          ),
        ),
        const SizedBox(width: 20),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                title,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Image.network(
                    'https://upload.wikimedia.org/wikipedia/commons/thumb/6/69/IMDB_Logo_2016.svg/2560px-IMDB_Logo_2016.svg.png',
                    height: 20,
                    width: 50,
                    fit: BoxFit.cover,
                    cacheHeight: 100,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    producer.substring(0, 3),
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                  const SizedBox(width: 10),
                  const Icon(
                    Icons.thumb_up,
                    size: 15,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Expanded(
                child: Text(
                  description,
                  style: Theme.of(context).textTheme.bodySmall,
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              // const Spacer()
            ],
          ),
        )
      ],
    );
  }
}
