import 'package:finews_module/configs/colors.dart';
import 'package:finews_module/configs/constants.dart';
import 'package:finews_module/data/entities/gold_model.dart';
import 'package:flutter/material.dart';

class GoldItemView extends StatelessWidget {
  const GoldItemView({Key? key, required this.item}) : super(key: key);

  final GoldModel item;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SIZED_BOX_W16,
        Container(
          padding: const EdgeInsets.all(1), // Border width
          decoration: const BoxDecoration(
              color: AppColors.color_000000_fade_8, shape: BoxShape.circle),
          child: ClipOval(
            child: Image.network(
              item.logo ?? "",
              fit: BoxFit.cover,
              width: 40,
              height: 40,
            ),
          ),
        ),
        SIZED_BOX_W08,
        SizedBox(
          width: 120,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${item.brand} ${item.company}",
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: AppColors.color_333333,
                  fontSize: 14,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              item.buy_change != null
                  ? RichText(
                      textAlign: TextAlign.end,
                      text: TextSpan(
                        children: [
                          const TextSpan(
                            text: "Mua ",
                            style: TextStyle(
                              color: AppColors.color_777E90,
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          TextSpan(
                            text: "${item.buy}",
                            style: const TextStyle(
                              color: AppColors.color_333333,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          WidgetSpan(
                            alignment: PlaceholderAlignment.bottom,
                            child: Container(
                              child: item.buy_change! > 0
                                  ? const Icon(
                                      Icons.arrow_drop_up,
                                      color: AppColors.color_00B14F,
                                    )
                                  : const Icon(
                                      Icons.arrow_drop_down,
                                      color: AppColors.color_FF3B30,
                                    ),
                            ),
                          )
                        ],
                      ),
                    )
                  : Container(),
              item.sell_change != null
                  ? RichText(
                      textAlign: TextAlign.left,
                      text: TextSpan(
                        children: [
                          const TextSpan(
                            text: "Bán  ",
                            style: TextStyle(
                              color: AppColors.color_777E90,
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          TextSpan(
                            text: "${item.sell}",
                            style: const TextStyle(
                              color: AppColors.color_333333,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          WidgetSpan(
                            child: item.sell_change! > 0
                                ? const Icon(
                                    Icons.arrow_drop_up,
                                    color: AppColors.color_00B14F,
                                  )
                                : const Icon(
                                    Icons.arrow_drop_down,
                                    color: AppColors.color_FF3B30,
                                  ),
                          )
                        ],
                      ),
                    )
                  : Container(),
            ],
          ),
        )
      ],
    );
  }
}
