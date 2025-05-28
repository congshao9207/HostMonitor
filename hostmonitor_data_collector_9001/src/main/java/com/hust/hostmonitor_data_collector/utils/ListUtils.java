package com.hust.hostmonitor_data_collector.utils;

import java.util.List;
import org.slf4j.Logger;

public class ListUtils {

    /**
     * 安全移除列表第一个元素，并打印带有指定消息的日志（如果列表为空），同时返回更新后的列表。
     *
     * @param list 要操作的列表
     * @param logger 日志记录器
     * @param ip 当前主机 IP，用于日志输出
     * @param errorMessage 当列表为空或无法移除元素时使用的错误消息
     * @return 更新后的列表；如果列表为空或null，则返回原列表（可能为null）
     */
    public static <T> List<T> safeRemoveFirst(List<T> list, Logger logger, String ip, String errorMessage) {
        if (list != null && !list.isEmpty()) {
            list.remove(0);
            return list;
        } else {
            if (logger != null) {
                logger.info("{}: {}/IP {}", errorMessage, list, ip);
            }
            // 返回原始列表，即使它可能是null或空。
            return list;
        }
    }
}