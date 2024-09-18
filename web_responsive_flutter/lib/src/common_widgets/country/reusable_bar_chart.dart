import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:web_responsive_flutter/src/app_configs/app_colors.dart';
import 'package:web_responsive_flutter/src/common_widgets/country/no_graph_data_available.dart';

class ReusableBarChartView extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Map<String, dynamic>> data;
  final List<String> dropdownItems;
  final String dropdownValue;
  final ValueChanged<String> onDropdownChanged;
  final String yKey;
  final String unit;
  final String Function(double) formatData;
  final int selectedIndex;
  final bool isDataAvailable;

  const ReusableBarChartView({
    super.key,
    required this.title,
    required this.icon,
    required this.data,
    required this.dropdownItems,
    required this.dropdownValue,
    required this.onDropdownChanged,
    required this.yKey,
    required this.unit,
    required this.formatData,
    required this.selectedIndex,
    required this.isDataAvailable,
  });

  String formatDuration(seconds) {
    Duration duration = Duration(seconds: seconds);
    int hours = duration.inHours;
    int minutes = duration.inMinutes.remainder(60);
    String twoDigitHours = hours.toString().padLeft(2, '0');
    String twoDigitMinutes = minutes.toString().padLeft(2, '0');
    return '$twoDigitHours:$twoDigitMinutes';
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> sortedData = [];
    double maxY = 0.0;
    double interval = 0.0;
    String year = '';
    bool dataAvailable = isDataAvailable;

    try {
      sortedData = [...data]; // Make a copy of the data
      sortedData = sortedData
          .where((entry) => !_isInvalidValue(entry[yKey]))
          .toList(); // Filter out invalid values
      if (dropdownValue != 'Week') {
        sortedData.sort((a, b) {
          if (a['yearMonth'] == null || b['yearMonth'] == null) {
            return 0;
          }
          final dateA = DateTime.tryParse('${a['yearMonth']}-01');
          final dateB = DateTime.tryParse('${b['yearMonth']}-01');
          if (dateA == null || dateB == null) {
            return 0;
          }
          return dateA.compareTo(dateB); // Sort in descending order
        });
      }

      year = getYearFromData(sortedData);
      maxY = getMaxYValue(sortedData) + 10;
      interval = calculateInterval(maxY);

      // Print maxY and interval values for debugging
      if (kDebugMode) {
        print('Max Y Value: $maxY');
      }
      if (kDebugMode) {
        print('Interval: $interval');
      }
    } catch (e) {
      dataAvailable = false;
      if (kDebugMode) {
        print('Error processing data: $e');
      }
    }

    // Check if all values are zero
    final bool allValuesZero =
        sortedData.every((entry) => _getYValue(entry, yKey) == 0.0);

    if (allValuesZero) {
      dataAvailable = false;
    }

    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: DropdownButtonHideUnderline(
              child: Theme(
                data: Theme.of(context).copyWith(
                  canvasColor: Colors.white,
                ),
                child: DropdownButton<String>(
                  value: dropdownValue,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  isDense: true,
                  iconSize: 24,
                  elevation: 16,
                  style: const TextStyle(color: AppColors.primaryTextColor),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      onDropdownChanged(newValue);
                    }
                  },
                  items: dropdownItems
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
          if (dataAvailable) ...[
            const SizedBox(height: 16),
            // Chart container
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header with icon and title
                  Row(
                    children: [
                      Icon(icon, color: AppColors.primaryTextColor),
                      const SizedBox(width: 8),
                      Text(
                        title,
                        style: const TextStyle(
                          color: AppColors.primaryTextColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  // Bar chart
                  AspectRatio(
                    aspectRatio: 1.3,
                    child: BarChart(
                      BarChartData(
                        maxY: maxY,
                        barTouchData: BarTouchData(
                          touchTooltipData: BarTouchTooltipData(
                            getTooltipItem: (group, groupIndex, rod, rodIndex) {
                              String tooltipText = '';
                              if (dropdownValue == 'Week') {
                                if (sortedData[group.x.toInt()]['localDate'] !=
                                    null) {
                                  tooltipText = DateFormat('EEE').format(
                                      DateTime.parse(sortedData[group.x.toInt()]
                                          ['localDate']));
                                }
                              } else {
                                if (sortedData[group.x.toInt()]['yearMonth'] !=
                                    null) {
                                  tooltipText = DateFormat('MMM').format(
                                      DateTime.parse(
                                          '${sortedData[group.x.toInt()]['yearMonth']}-01'));
                                }
                              }
                              var time = "0";
                              if (unit == "hh:mm") {
                                int myInt = rod.toY.toInt();
                                time = formatDuration(myInt);
                              } else {
                                time = (double.tryParse(
                                            rod.toY.toStringAsFixed(2)) ??
                                        0)
                                    .toString();
                              }
                              return BarTooltipItem(
                                '$tooltipText\n',
                                const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: time,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        titlesData: FlTitlesData(
                          show: true,
                          rightTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          topTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, meta) {
                                int index = value.toInt();
                                if (index < 0 || index >= sortedData.length) {
                                  return Container();
                                }
                                String title = '';
                                if (dropdownValue == 'Week') {
                                  if (sortedData[index]['localDate'] != null) {
                                    DateTime date = DateTime.parse(
                                        sortedData[index]['localDate']);
                                    title = DateFormat('EEE').format(date);
                                  }
                                } else {
                                  if (sortedData[index]['yearMonth'] != null) {
                                    DateTime? date = DateTime.tryParse(
                                        '${sortedData[index]['yearMonth']}-01');
                                    if (date != null) {
                                      title = DateFormat('MMM').format(date);
                                    }
                                  }
                                }

                                return SideTitleWidget(
                                  axisSide: meta.axisSide,
                                  space: 16,
                                  child: Text(title,
                                      style: const TextStyle(
                                          color: AppColors.primaryTextColor,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 10)),
                                );
                              },
                              reservedSize: 36,
                            ),
                          ),
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              interval: interval, // Update this
                              getTitlesWidget: (value, meta) {
                                if (meta.axisPosition == 0) return Container();
                                const style = TextStyle(
                                  color: AppColors.primaryTextColor,
                                  fontSize: 10,
                                );
                                // Print y-axis values for debugging
                                var valuetext = "0.0";
                                if (unit == "hh:mm") {
                                  int myInt = value.toInt();
                                  valuetext = formatDuration(myInt);
                                } else {
                                  valuetext = value.toString();
                                }
                                return SideTitleWidget(
                                  axisSide: meta.axisSide,
                                  space: 8,
                                  child: Text(
                                    valuetext,

                                    /// Show full value
                                    style: style,
                                  ),
                                );
                                //  if (value % 20 == 0) {
                                //   const style = TextStyle(
                                //     color: AppColors.primaryTextColor,
                                //     fontSize: 10,
                                //   );
                                //   // Print y-axis values for debugging
                                //   var valuetext = "0.0";
                                //   if (unit == "hh:mm") {
                                //     int myInt = value.toInt();
                                //     valuetext = formatDuration(myInt);
                                //   } else {
                                //     valuetext = value.toString();
                                //   }
                                //   return Text(
                                //     valuetext.toString(),
                                //     style: style,
                                //   );
                                // }
                                // return Container(); // Return an empty container for other values

                                // const style = TextStyle(
                                //   color: AppColors.primaryTextColor,
                                //   fontSize: 10,
                                // );
                                // // Print y-axis values for debugging
                                // var valuetext = "0.0";
                                // if (unit == "hh:mm") {
                                //   int myInt = value.toInt();
                                //   valuetext = formatDuration(myInt);
                                // } else {
                                //   valuetext = value.toString();
                                // }
                                // return SideTitleWidget(
                                //   axisSide: meta.axisSide,
                                //   space: 8,
                                //   child: Text(
                                //     valuetext, // Show full value
                                //     style: style,
                                //   ),
                                // );
                              },
                              reservedSize:
                                  60, // Increased reserved size for full value display
                            ),
                          ),
                        ),
                        borderData: FlBorderData(
                          show: true,
                          border: const Border(
                            bottom: BorderSide(color: Colors.grey, width: 0.5),
                            top: BorderSide(color: Colors.grey, width: 0.5),
                          ),
                        ),
                        barGroups: sortedData.asMap().entries.map((entry) {
                          final index = entry.key;
                          final dataEntry = entry.value;
                          double yValue = _getYValue(dataEntry, yKey);
                          // Print y-axis values for each bar for debugging
                          return BarChartGroupData(
                            x: index,
                            barRods: [
                              BarChartRodData(
                                toY: yValue,
                                color: _getBarColor(index),
                                width: 22,
                                backDrawRodData: BackgroundBarChartRodData(
                                  show: true,
                                  toY: maxY,
                                  color: Colors.transparent,
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                        gridData: FlGridData(
                          show: true,
                          drawHorizontalLine: true,
                          drawVerticalLine: false,
                          horizontalInterval: interval,
                          // Update this
                          getDrawingHorizontalLine: (value) {
                            return FlLine(
                              color: Colors.grey,
                              strokeWidth: 0.5,
                              dashArray: value == 0 ? [] : [5, 5],
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Bottom year display
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      year, // Dynamically updated year
                      style: const TextStyle(
                        color: AppColors.primaryTextColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ] else ...[
            const NoGraphDataAvailable()
          ],
        ],
      ),
    );
  }

  bool _isInvalidValue(dynamic value) {
    if (value == null) return true;
    if (value is String && value.toLowerCase() == 'nan') return true;
    if (value is num && (value.isNaN || value.isInfinite)) return true;
    return false;
  }

  double _getYValue(Map<String, dynamic> dataEntry, String key) {
    var value = dataEntry[key];
    if (value is String) {
      value = double.tryParse(value) ?? 0.0;
    }
    return (value as num?)?.toDouble() ?? 0.0;
  }

  Color _getBarColor(int index) {
    switch (index % 7) {
      case 0:
        return AppColors.color1;
      case 1:
        return AppColors.color2;
      case 2:
        return AppColors.color3;
      case 3:
        return AppColors.color4;
      case 4:
        return AppColors.color5;
      case 5:
        return AppColors.color6;
      case 6:
        return AppColors.color7;
      default:
        return AppColors.color1;
    }
  }

  String getYearFromData(List<Map<String, dynamic>> sortedData) {
    if (sortedData.isNotEmpty) {
      if (sortedData.first.containsKey('localDate') &&
          sortedData.first['localDate'] != null) {
        DateTime firstDate = DateTime.parse(sortedData.first['localDate']);
        return DateFormat('yyyy').format(firstDate);
      } else if (sortedData.first.containsKey('yearMonth') &&
          sortedData.first['yearMonth'] != null) {
        String yearMonth = sortedData.first['yearMonth'];
        return yearMonth.split('-')[0];
      }
    }
    return '';
  }

  double getMaxYValue(List<Map<String, dynamic>> sortedData) {
    double maxY = 0.0;
    for (var entry in sortedData) {
      double yValue = _getYValue(entry, yKey);
      if (yValue > maxY) {
        maxY = yValue;
      }
    }

    // Adjust maxY to nearest higher multiple for cleaner intervals
    return maxY <= 0
        ? 100.0 // Default value if no data
        : maxY <= 50
            ? 50
            : (maxY + 10) - (maxY + 10) % 10;
  }

  double calculateInterval(double maxY) {
    double interval = (maxY / 10).ceilToDouble();
    if (interval > 10) {
      interval = (interval / 10).ceilToDouble() * 10;
    }
    return interval <= 0 ? 10 : interval;
  }

  String convertMinutesToHHMM(totalMinutes) {
    int hours = totalMinutes ~/ 60; // Integer division to get the hours
    int minutes = totalMinutes % 60; // Remainder to get the minutes

    // Format the hours and minutes to always have two digits
    String formattedTime =
        '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}';

    return formattedTime;
  }
}
