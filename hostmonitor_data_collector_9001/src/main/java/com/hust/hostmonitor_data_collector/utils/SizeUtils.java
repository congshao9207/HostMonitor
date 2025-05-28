package com.hust.hostmonitor_data_collector.utils;

public class SizeUtils {

    /**
     * 将字节大小转换为 GB 或 TB，并保留两位小数
     * @param sizeInBytes 大小（单位：字节）
     * @return 转换后的大小，单位是 GB 或 TB，保留两位小数
     */
    public static double formatSizeToGBOrTB(double sizeInBytes) {
        double sizeInGB = sizeInBytes / (1024.0 * 1024.0 * 1024.0);

        if (sizeInGB >= 1024) {
            double sizeInTB = sizeInGB / 1024.0;
            return roundToTwoDecimalPlaces(sizeInTB);
        } else {
            return roundToTwoDecimalPlaces(sizeInGB);
        }
    }

    /**
     * 将字节大小转换为 GB（保留两位小数）
     * @param sizeInBytes 大小（单位：字节）
     * @return 转换为 GB 的值，保留两位小数
     */
    public static double convertToGB(double sizeInBytes) {
        return roundToTwoDecimalPlaces(sizeInBytes / (1024.0 * 1024.0 * 1024.0));
    }

    /**
     * 辅助方法：保留两位小数
     * @param value 原始数值
     * @return 四舍五入后保留两位小数的值
     */
    private static double roundToTwoDecimalPlaces(double value) {
        return Math.round(value * 100.0) / 100.0;
    }
}
