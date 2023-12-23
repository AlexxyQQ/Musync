import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:musync/config/constants/colors/app_colors.dart';
import 'package:musync/core/common/album_query_widget.dart';
import 'package:musync/core/common/exports.dart';
import 'package:musync/core/utils/extensions/app_text_theme_extension.dart';
import 'package:musync/features/home/domain/entity/artist_entity.dart';
import 'package:musync/features/home/presentation/cubit/home_state.dart';
import 'package:musync/features/home/presentation/cubit/query_cubit.dart';
import 'package:musync/features/home/presentation/widgets/song_list_page.dart';

class ArtistListPage extends StatelessWidget {
  const ArtistListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QueryCubit, HomeState>(
      builder: (context, state) {
        if (state.artists.isEmpty) {
          return Center(
            child: Text(
              'No Artists Found',
              style: Theme.of(context).textTheme.mBM.copyWith(
                    color: AppColors().onSurface,
                  ),
            ),
          );
        }
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height - 50.h,
          child: ListView.builder(
            itemBuilder: (context, index) {
              final artist = state.artists[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SongsListPage(
                        songs: BlocProvider.of<QueryCubit>(context)
                                .state
                                .artists[index]
                                .songs ??
                            [],
                      ),
                    ),
                  );
                },
                child: AlbumListTile(
                  artist: artist,
                  trailing: false,
                  coverHeight: 68.h,
                  coverWidth: 60.w,
                  borderRadius: 8.r,
                ),
              );
            },
            itemCount: state.artists.length,
          ),
        );
      },
    );
  }
}

class AlbumListTile extends StatefulWidget {
  final ArtistEntity artist;
  final bool trailing;
  final Function()? onTap;
  final double coverHeight;
  final double coverWidth;
  final double borderRadius;
  const AlbumListTile({
    super.key,
    required this.artist,
    this.trailing = false,
    this.onTap,
    this.coverHeight = 50,
    this.coverWidth = 50,
    this.borderRadius = 500,
  });

  @override
  State<AlbumListTile> createState() => _AlbumListTileState();
}

class _AlbumListTileState extends State<AlbumListTile> {
  bool isNetworkImage = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minLeadingWidth: 0,
      leading: SongArtWork(
        song: widget.artist.songs!
            .firstWhere((element) => element.albumArt != null),
        height: widget.coverHeight,
        width: widget.coverWidth,
        borderRadius: widget.borderRadius,
      ),
      title: Text(
        widget.artist.artist,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        style: Theme.of(context).textTheme.mBM.copyWith(
              color: AppColors().onSurface,
            ),
      ),
      subtitle: Text(
        "${widget.artist.songs!.length} ${widget.artist.songs!.length > 1 ? 'Songs' : 'Song'}",
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        style: Theme.of(context).textTheme.lBS.copyWith(
              color: AppColors().onSurfaceVariant,
            ),
      ),
      trailing: widget.trailing
          ? IconButton(
              icon: Icon(
                Icons.more_vert,
                color: AppColors().onSurfaceVariant,
              ),
              onPressed: widget.onTap,
            )
          : null,
    );
  }
}
