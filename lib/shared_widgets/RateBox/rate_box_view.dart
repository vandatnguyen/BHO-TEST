import 'dart:math';

import 'package:finews_module/configs/colors.dart';
import 'package:finews_module/configs/constants.dart';
import 'package:finews_module/cores/services/news_api_service.dart';
import 'package:finews_module/data/entities/BankRankResponse.dart';
import 'package:finews_module/finews_module.dart';
import 'package:finews_module/shared_widgets/ListNoDataBackground.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class BankRateView extends StatefulWidget {
  const BankRateView({Key? key}) : super(key: key);

  @override
  State<BankRateView> createState() {
    FiNewsModule.initNewsRouteAndBinding();
    return _BankRateViewState();
  }
}

const TextStyle text1 = TextStyle(
    fontWeight: FontWeight.w500, fontSize: 18, color: AppColors.color_333333);

const TextStyle text2 = TextStyle(
    fontWeight: FontWeight.w400, fontSize: 12, color: AppColors.color_858585);

const TextStyle text3 = TextStyle(
    fontWeight: FontWeight.w500, fontSize: 14, color: AppColors.color_333333);

const TextStyle text4 = TextStyle(
    fontWeight: FontWeight.w500, fontSize: 12, color: AppColors.color_858689);

class _BankRateViewState extends State<BankRateView> {
  final newServices = Get.find<NewsService>();
  bool _isLoading = true;
  BankRateResponse? _res;

  getBankRate() async {
    try {
      setState(() {
        _isLoading = true;
      });
      var res = await newServices.getBankRate();
      setState(() {
        _res = res;
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getBankRate();
  }

  @override
  Widget build(BuildContext context) {
    final message = _res?.message;
    final listBankRate = _res?.data ?? [];
    double maxNoRate = 0;
    double maxRate1 = 0;
    double maxRate3 = 0;
    if (listBankRate.isNotEmpty){
      maxNoRate = [...listBankRate.map((rate) => rate.noRate)]
          .whereType<double>()
          .reduce(max);
      maxRate1 = [...listBankRate.map((rate) => rate.rate1)]
          .whereType<double>()
          .reduce(max);
      maxRate3 = [...listBankRate.map((rate) => rate.rate3)]
          .whereType<double>()
          .reduce(max);
    }

    TextStyle getStyle(double? rate, double maxRate) {
      return text4.merge(TextStyle(
          color: rate == maxRate
              ? AppColors.color_primary
              : AppColors.color_858689));
    }

    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 0),
            child: Text(
              "So sánh lợi nhuận",
              style: text1,
            ),
          ),
          Column(
            children: [
              Row(children: const [
                Expanded(
                    flex: 3,
                    child: Text(
                      "Ngân hàng/Ứng dụng",
                      style: text2,
                    )),
                Expanded(
                    flex: 2,
                    child: Text(
                      "Không kỳ hạn",
                      style: text2,
                      textAlign: TextAlign.end,
                    )),
                Expanded(
                    flex: 1,
                    child: Text(
                      "1 tháng",
                      style: text2,
                      textAlign: TextAlign.end,
                    )),
                Expanded(
                    flex: 1,
                    child: Text(
                      "3 tháng",
                      style: text2,
                      textAlign: TextAlign.end,
                    )),
              ]),
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: !_isLoading
                      ? listBankRate.isNotEmpty
                      ? Column(
                    children: [
                      ...listBankRate.map((bankRate) {
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16),
                              child: Row(children: [
                                Expanded(
                                    flex: 3,
                                    child: Row(
                                      children: [
                                        Text(
                                          bankRate.bank ?? "",
                                          style: text3,
                                        ),
                                        bankRate.isApp == 1
                                            ? const Icon(
                                          Icons
                                              .phone_iphone_outlined,
                                          size: 16,
                                          color: AppColors
                                              .color_858585,
                                        )
                                            : Container()
                                      ],
                                    )),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    bankRate.noRate != 0
                                        ? "${bankRate.noRate}%"
                                        : "_",
                                    textAlign: TextAlign.end,
                                    style: getStyle(
                                        bankRate.noRate, maxNoRate),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    bankRate.rate1 != 0
                                        ? "${bankRate.rate1}%"
                                        : "_",
                                    textAlign: TextAlign.end,
                                    style: getStyle(
                                        bankRate.rate1, maxRate1),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    bankRate.rate3 != 0
                                        ? "${bankRate.rate3}%"
                                        : "_",
                                    textAlign: TextAlign.end,
                                    style: getStyle(
                                        bankRate.rate3, maxRate3),
                                  ),
                                ),
                              ]),
                            ),
                            const Divider(),
                          ],
                        );
                      })
                    ],
                  )
                      : Center(
                    child: ListNoDataBackground(
                      padding: PAD_SYM_H40,
                      showIconButton: true,
                      btnTitle: "Thử lại",
                      pngPath: "assets/images/ic_no_data.png",
                      desc: "Có lỗi xảy ra, vui lòng thử lại",
                      onPressed: () => getBankRate(),
                    ),
                  )
                      : ListNoDataBackground(
                    padding: PAD_SYM_H40,
                    pngPath: "assets/images/ic_no_data.png",
                    title: "",
                    desc: "Đang tải dữ liệu...",
                    showIconButton: true,
                    isLoading: true,
                    onPressed: () => getBankRate(),
                  )),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      message ?? "",
                      style: const TextStyle(
                          color: Color(0xFF9AA0A5),
                          fontSize: 12,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _launchURL("https://news.tikop.vn/lai-suat?period=1");
                    },
                    child: Row(
                      children: const [
                        Text("Xem thêm", style: text3),
                        Icon(
                          Icons.arrow_forward_ios_sharp,
                          size: 12,
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  _launchURL(String urlNews) async {
    final Uri url = Uri.parse(urlNews);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }
}
