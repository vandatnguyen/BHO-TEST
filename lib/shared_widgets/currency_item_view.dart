import 'package:finews_module/configs/colors.dart';
import 'package:finews_module/configs/constants.dart';
import 'package:finews_module/data/entities/currency_model.dart';
import 'package:flutter/material.dart';

class CurrencyItemView extends StatelessWidget {
  const CurrencyItemView({Key? key, required this.item}) : super(key: key);

  final CurrencyModel item;

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
            // child: Image.network(
            //   "https://raw.githubusercontent.com/transferwise/currency-flags/master/src/flags/${item.code?.toLowerCase()}.png",
            //   fit: BoxFit.cover,
            //   width: 40,
            //   height: 40,
            // ),
            child: Image.asset(
              "assets/images/flag/ic_${item.code?.toLowerCase()}.png", package: 'finews_module',
              fit: BoxFit.cover,
              width: 40,
              height: 40,
            ),
          ),
        ),
        SIZED_BOX_W08,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${item.code}",
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: AppColors.color_333333,
                fontSize: 14,
              ),
            ),
            item.buy_change != null
                ? RichText(
                    textAlign: TextAlign.left,
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
                          child: item.buy_change! > 0
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
        )
      ],
    );
  }
}
