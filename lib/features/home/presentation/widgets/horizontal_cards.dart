import 'package:flutter/material.dart';
import 'package:musync/core/common/album_query_widget.dart';
import 'package:musync/core/common/shimmers.dart';
import 'package:musync/config/constants/constants.dart';
import 'package:on_audio_query/on_audio_query.dart';

class HomeOtherSection extends StatelessWidget {
  const HomeOtherSection({
    Key? key,
    required this.isDark,
    required this.sectionTitle,
    required this.cardRoundness,
    required this.mqSize,
    this.cardHeight = 240,
    this.cardWidth = 200,
    required this.isCircular,
    required this.isLoading,
    required this.othersData,
  }) : super(key: key);

  final bool isDark;
  final String sectionTitle;
  final bool isCircular;
  final double cardRoundness;
  final double cardHeight;
  final double cardWidth;
  final Size mqSize;
  final bool isLoading;
  final Map<String, List<dynamic>> othersData;

  @override
  Widget build(BuildContext context) {
    final List<MapEntry<String, List<dynamic>>> shuffledData =
        othersData.entries.toList()..shuffle();
    return Column(
      children: [
        // Albums Title
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Text(
                sectionTitle,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const Spacer(),
              // Arrow Button
              IconButton(
                icon: const Icon(
                  Icons.arrow_forward_rounded,
                  size: 25,
                ),
                color: isDark ? Colors.white : Colors.black,
                onPressed: () {},
              ),
            ],
          ),
        ),
        // Horizontal List View of Albums
        isLoading
            ? SizedBox(
                height: cardHeight,
                child: HomeAlbumsShimmerEffect(
                  cardRoundness: 500,
                  cardHeight: 215,
                  cardWidth: 180,
                  mqSize: mqSize,
                  isCircular: true,
                ),
              )
            : SizedBox(
                height: cardHeight,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount:
                      shuffledData.length >= 10 ? 10 : shuffledData.length,
                  itemBuilder: (context, index) {
                    final dataEntry = shuffledData[index];
                    final dataValue = dataEntry.value;
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Card
                        isCircular
                            ? Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 5,
                                ),
                                child: CircleAvatar(
                                  radius: cardWidth / 2,
                                  backgroundColor: KColors.transparentColor,
                                  child: dataValue[0].albumArtUrl == null
                                      ? QueryArtworkWidget(
                                          artworkHeight: cardHeight,
                                          artworkWidth: cardWidth,
                                          artworkBorder:
                                              BorderRadius.circular(500),
                                          id: dataValue[0].id,
                                          nullArtworkWidget: const Icon(
                                            Icons.music_note_rounded,
                                            color: KColors.accentColor,
                                          ),
                                          type: ArtworkType.AUDIO,
                                          errorBuilder: (p0, p1, p2) {
                                            return const Icon(
                                              Icons.music_note_rounded,
                                              color: KColors.accentColor,
                                            );
                                          },
                                        )
                                      : QueryArtworkFromApi(
                                          index: 0,
                                          height: cardHeight,
                                          width: cardWidth,
                                          borderRadius:
                                              BorderRadius.circular(500),
                                          data: dataValue,
                                        ),
                                ),
                              )
                            : Container(
                                margin: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: KColors.transparentColor,
                                  borderRadius:
                                      BorderRadius.circular(cardRoundness),
                                ),
                                width: cardWidth,
                                height: cardHeight - 50,
                                child: dataValue[0].albumArtUrl == null
                                    ? QueryArtworkWidget(
                                        artworkHeight: cardHeight,
                                        artworkWidth: cardWidth,
                                        nullArtworkWidget: const Icon(
                                          Icons.music_note_rounded,
                                          color: KColors.accentColor,
                                        ),
                                        artworkBorder: BorderRadius.circular(
                                          cardRoundness,
                                        ),
                                        id: dataValue[0].id,
                                        type: ArtworkType.AUDIO,
                                        errorBuilder: (p0, p1, p2) {
                                          return const Icon(
                                            Icons.music_note_rounded,
                                            color: KColors.accentColor,
                                          );
                                        },
                                      )
                                    : QueryArtworkFromApi(
                                        index: 0,
                                        data: dataValue,
                                        borderRadius: BorderRadius.circular(
                                          cardRoundness,
                                        ),
                                        height: cardHeight,
                                        width: cardWidth,
                                      ),
                              ),
                        // Card Subtitle
                        SizedBox(
                          width: cardWidth,
                          child: Center(
                            child: Text(
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              isCircular
                                  ? dataValue[0].artist.toString()
                                  : dataValue[0].album.toString(),
                              style: GlobalConstants.textStyle(
                                color: isDark ? Colors.white : Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
      ],
    );
  }
}
