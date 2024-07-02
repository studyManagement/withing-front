import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modi/common/components/image/circle_image.dart';
import 'package:modi/common/components/tag/tag_list.dart';
import 'package:modi/common/theme/app/app_colors.dart';
import 'package:modi/common/theme/app/app_fonts.dart';

class StudyListViewParam {
  String title;
  Map<String, String>? extra;
  List<String>? tag;
  String link;
  String? imagePath;

  @override
  String toString() {
    return "StudyListViewParam(title=$title,link=$link,extra=$extra,tag=$tag,image:$imagePath)";
  }

  StudyListViewParam(this.title, this.link,
      {this.extra, this.tag, this.imagePath});
}

class StudyList extends StatelessWidget {
  StudyList(this.params, {super.key});

  List<StudyListViewParam> params;

  @override
  Widget build(BuildContext context) {
    Container grayContainer =
    Container(width: 38, height: 38, color: AppColors.gray150);

    return ListView.separated(
      itemCount: params.length,
      itemBuilder: (BuildContext context, int index) {
        StudyListViewParam param = params[index];
        List<Widget> extraWidgets = makeExtraToTextWidgets(param);

        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {}, // context.push(param.link),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleImage(size: 38,
                      image: (param.imagePath == null)
                          ? null
                          : Image.network(
                              param.imagePath!,
                              width: 38,
                              height: 38,
                              fit: BoxFit.cover,
                              errorBuilder: (BuildContext context,
                                  Object exception, StackTrace? stackTrace) {
                                return grayContainer;
                              },
                            )),
                  const SizedBox(width: 8),
                  Text(
                    param.title,
                    style: const TextStyle(
                      fontSize: AppFonts.fontSize16,
                      color: AppColors.gray800,
                      fontWeight: AppFonts.fontWeight600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ...extraWidgets,
              const SizedBox(height: 8),
              TagList(param.tag!),
            ],
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Divider(
            thickness: 1,
            color: AppColors.gray50,
          ),
        );
      },
    );
  }

  List<Widget> makeExtraToTextWidgets(StudyListViewParam param) {
    List<Widget> extraWidgets = [];

    param.extra?.forEach((key, value) {
      Text title = Text(
        key,
        style: const TextStyle(
          color: AppColors.gray400,
          fontWeight: AppFonts.fontWeight500,
          fontSize: 13,
        ),
      );
      Text content = Text(
        value,
        style: const TextStyle(
          color: AppColors.gray800,
          fontWeight: AppFonts.fontWeight500,
          fontSize: 13,
        ),
      );

      extraWidgets
          .add(Row(children: [title, const SizedBox(width: 6), content]));
      extraWidgets.add(const SizedBox(height: 4));
    });

    return extraWidgets;
  }
}
