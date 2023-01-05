import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keptua/Controllers/Cubits/AudioPlayerCubits/search_list_cubit.dart';
import 'package:keptua/Controllers/Repositories/repository.dart';
import 'package:keptua/Views/Utils/Data/app_colors.dart';
import 'package:keptua/Views/Utils/Data/app_icons.dart';
import 'package:keptua/Views/Utils/Data/app_strings.dart';

class AudioPlayerCustomSearchField extends StatefulWidget {
  final bool? theme;
  final AsyncSnapshot? songItems;

  const AudioPlayerCustomSearchField({
    super.key,
    required this.theme,
    required this.songItems,
  });

  @override
  State<AudioPlayerCustomSearchField> createState() =>
      _AudioPlayerCustomSearchFieldState();
}

class _AudioPlayerCustomSearchFieldState
    extends State<AudioPlayerCustomSearchField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45.sp,
      padding: EdgeInsets.symmetric(horizontal: 30.sp),
      child: Card(
        color: widget.theme! ? AppColors.whiteTwo : AppColors.themeBlack,
        elevation: 3.sp,
        shadowColor: AppColors.grey,
        child: TextField(
          textAlign: TextAlign.left,
          style: GoogleFonts.poppins(
            fontSize: 14.sp,
            color: widget.theme! ? AppColors.themeBlack : AppColors.white,
          ),
          controller: Repository.audioPlayerSearchTextFieldController,
          cursorColor: widget.theme! ? AppColors.themeBlack : AppColors.white,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(top: 5.sp, left: 25.sp),
            suffixIcon: Padding(
              padding: EdgeInsets.only(right: 22.sp),
              child: Icon(
                AppIcons.search,
                color: AppColors.greyTwo,
                size: 18.sp,
              ),
            ),
            border: OutlineInputBorder(
              borderSide: widget.theme!
                  ? BorderSide.none
                  : BorderSide(
                      color: AppColors.greyTwo,
                      width: 1.sp,
                    ),
              borderRadius: BorderRadius.circular(5.sp),
            ),
            focusedBorder: widget.theme!
                ? OutlineInputBorder(
                    borderSide:
                        BorderSide(color: AppColors.greyTwo, width: 0.sp),
                    borderRadius: BorderRadius.circular(5.sp),
                  )
                : OutlineInputBorder(
                    borderSide:
                        BorderSide(color: AppColors.greyTwo, width: 1.sp),
                    borderRadius: BorderRadius.circular(
                      5.sp,
                    ),
                  ),
            enabledBorder: widget.theme!
                ? OutlineInputBorder(
                    borderSide:
                        BorderSide(color: AppColors.greyTwo, width: 0.sp),
                    borderRadius: BorderRadius.circular(5.sp),
                  )
                : OutlineInputBorder(
                    borderSide:
                        BorderSide(color: AppColors.greyTwo, width: 1.1.sp),
                    borderRadius: BorderRadius.circular(5.sp),
                  ),
            hintText: AppStrings.audioPlayerSearchHintText,
            hintStyle: GoogleFonts.poppins(
              fontSize: 12.0.sp,
              color: AppColors.greyTwo,
            ),
          ),
          onChanged: (searchQuery) {
            Repository.songsList!.contains(searchQuery);
            final suggestions = Repository.songsList!.where((song) {
              final songTitle = song.title.toLowerCase();
              final searchInput = searchQuery.toLowerCase();
              return songTitle.contains(searchInput);
            }).toList();
            context.read<SearchListCubit>().songsList(suggestions);
          },
        ),
      ),
    );
  }
}
