import 'package:flutter/material.dart';
import '../mainScreens/coiffeurDetails.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:provider/provider.dart';
import '../providers/moreScreenProvider.dart';
import '../widgets/generalAlertDialog.dart';

class FavouriteCard extends StatelessWidget {
  final int id;
  final int favId;
  final String title;
  final String image;
  final double rate;

  FavouriteCard({this.id,this.favId, this.title, this.image, this.rate});

  Future<void> _showConfirmDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return GeneralDialog(
            content: 'هل بالفعل تريد حذف هذا الحجز ؟',
            toDOFunction: () => _deleteFav(context),
          );
        });
  }

  void _deleteFav(BuildContext context) async {
    await Provider.of<More>(context, listen: false).deleteFav(favId);
    await Provider.of<More>(context,listen: false).fetchFavourite();
  }

  @override
  Widget build(BuildContext context) {
    void _showDetails() {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => CoiffeurDetailsScreen(
            id: id,
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: _showDetails,
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 5.0,
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 5.0,
          horizontal: 10.0,
        ),
        height: 90,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.grey[200],
        ),
        child: Row(
          children: <Widget>[
            Container(
              height: 70.0,
              width: 70.0,
              margin: const EdgeInsets.symmetric(
                vertical: 5.0,
                horizontal: 10.0,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white,
                image: DecorationImage(
                  image: NetworkImage('https://mashghllkw.com/cdn/' + image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    color: Color.fromRGBO(104, 57, 120, 10),
                    fontSize: 16.0,
                    fontFamily: 'beINNormal',
                  ),
                ),
                SmoothStarRating(
                  allowHalfRating: true,
                  starCount: 5,
                  rating: double.parse(rate.toString()),
                  size: 14.0,
                  color: Colors.yellow,
                  borderColor: Colors.yellow,
                  spacing: 0.0,
                ),
              ],
            ),
            Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.cancel,
                    size: 16.0,
                    color: Color.fromRGBO(104, 57, 120, 10),
                  ),
                  onPressed: () => _showConfirmDialog(context),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
