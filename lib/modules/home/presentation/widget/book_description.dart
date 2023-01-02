import 'package:e_book_app/index.dart';

class BookDescription extends StatefulWidget {
  const BookDescription(String description, {super.key}) : _description = description;

  final String _description;

  @override
  State<BookDescription> createState() => BookDescriptionState();
}

class BookDescriptionState extends State<BookDescription> {
  bool isShowMore = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 300),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            widget._description,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: AppColors.white.withOpacity(.6),
                ),
            maxLines: isShowMore ? null : 2,
            overflow: isShowMore ? null : TextOverflow.ellipsis,
          ),
          TextButton(
            onPressed: () {
              isShowMore = !isShowMore;
              setState(() {});
            },
            child: const Text('show more'),
          ),
        ],
      ),
    );
  }
}
