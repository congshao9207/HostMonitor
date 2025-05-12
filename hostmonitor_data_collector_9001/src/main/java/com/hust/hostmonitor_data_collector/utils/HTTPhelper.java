package com.hust.hostmonitor_data_collector.utils;


import com.alibaba.fastjson.JSONObject;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.util.Base64;

public class HTTPhelper {
    public static void main(String[] args) throws Exception {
        /* connection对象 */
        HttpURLConnection connection = null;
        try {
            /* 请求URL */
            URL url = new URL("http://172.29.3.7/gate/rpc.php");
            /* 获取connection对象 */
            connection = (HttpURLConnection) url.openConnection();
            /* POST请求必须开启输入输出流 */
            connection.setDoInput(true);
            connection.setDoOutput(true);
            /* 请求方式 */
            connection.setRequestMethod("POST");
            /* 是否使用缓存 */
            connection.setUseCaches(false);
            /* 设置请求头 */
            connection.setRequestProperty("Content-Type", "application/json");
            connection.setRequestProperty("Authorization","Basic "+ Base64.getUrlEncoder().encode(("admin"+":"+"123456").getBytes()));
//            connection.setRequestProperty("Service", "tldpm");
//            connection.setRequestProperty("Method", "tldpm_getmonitor_msg");
            /* 创建链接：此时并不会传输数据，可以不调用该防范 */
            connection.connect();
            /* 获取输出流 */
            OutputStream os = connection.getOutputStream();
            /* body参数 */
            String body1 = "{\"service\":\"Session\",\"method\":\"login\",\"params\":{\"username\":\"admin\",\"password\":\"123456\",\"randcode\":\"D9C0A\"}}";

            String body2 = "{\"service\":\"tldpm\",\"method\":\"tldpm_getmonitor_msg\",\"params\":{\"username\":\"admin\",\"password\":\"123456\"}}";
            /* 将参数输出到连接 */
            os.write(body1.getBytes(StandardCharsets.UTF_8));

            /* 刷新输出流 */
            os.flush();
            /* 关闭输出流 */
            os.close();
            /* 获取输入流 */
            BufferedReader bf = new BufferedReader(new InputStreamReader(connection.getInputStream(), StandardCharsets.UTF_8));
            /* 读取流临时变量 */
            String line;
            /* 用来存储响应数据 */
            StringBuilder sb = new StringBuilder();
            /* 循环读取流 */
            while ((line = bf.readLine()) != null) {
                sb.append(line);
            }
            System.out.println(sb.toString());
            /* 关闭流 */
            bf.close();
        } catch (Exception e) {
            throw e;
        } finally {
            /* 关闭连接 */
            if (connection != null) {
                connection.disconnect();
            }
        }
    }
}