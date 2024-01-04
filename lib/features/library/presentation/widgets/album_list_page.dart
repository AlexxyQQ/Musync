import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:musync/core/common/album_query_widget.dart';
import 'package:musync/core/common/exports.dart';
import 'package:musync/features/home/domain/entity/album_entity.dart';
import 'package:musync/features/home/presentation/cubit/home_state.dart';
import 'package:musync/features/home/presentation/widgets/song_list_page.dart';

class AlbumListPage extends StatelessWidget {
  const AlbumListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QueryCubit, HomeState>(
      builder: (context, state) {
        if (state.albums.isEmpty) {
          return Center(
            child: Text(
              'No Albums Found',
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
              final album = state.albums[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SongsListPage(
                        songs: BlocProvider.of<QueryCubit>(context)
                                .state
                                .albums[index]
                                .songs ??
                            [],
                      ),
                    ),
                  );
                },
                child: AlbumListTile(
                  album: album,
                  trailing: false,
                  coverHeight: 68.h,
                  coverWidth: 60.w,
                  borderRadius: 8.r,
                ),
              );
            },
            itemCount: state.albums.length,
          ),
        );
      },
    );
  }
}

class AlbumListTile extends StatefulWidget {
  final AlbumEntity album;
  final bool trailing;
  final Function()? onTap;
  final double coverHeight;
  final double coverWidth;
  final double borderRadius;
  const AlbumListTile({
    super.key,
    required this.album,
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
        song: widget.album.songs!
            .firstWhere((element) => element.albumArt != null),
        height: widget.coverHeight,
        width: widget.coverWidth,
        borderRadius: widget.borderRadius,
      ),
      title: Text(
        widget.album.album,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        style: Theme.of(context).textTheme.mBM.copyWith(
              color: AppColors().onSurface,
            ),
      ),
      subtitle: Row(
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 110.w,
            ),
            child: Text(
              "${widget.album.artist}",
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: Theme.of(context).textTheme.lBS.copyWith(
                    color: AppColors().onSurfaceVariant,
                  ),
            ),
          ),
          SizedBox(
            width: 4.w,
          ),
          SizedBox(
            width: 80.w,
            child: Text(
              "${widget.album.songs!.length} ${widget.album.songs!.length > 1 ? 'Songs' : 'Song'}",
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: Theme.of(context).textTheme.lBS.copyWith(
                    color: AppColors().onSurfaceVariant,
                  ),
            ),
          ),
        ],
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
