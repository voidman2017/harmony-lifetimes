const https = require("https");
const fs = require("fs");
const express = require("express");
const cors = require("cors");

// 创建Express应用
const app = express();
// 启用 CORS
app.use(cors());

// 中间件，用于检查请求是否携带了证书
app.use((req, res, next) => {
    console.log('接受请求')
    // 检查客户端证书
    const cert = req.socket.getPeerCertificate();
    console.log('===debug=== cert: ', cert);

    // 如果请求没有携带证书或证书无效
    if (!cert || !Object.keys(cert).length) {
        // 记录日志
        console.error("No certificate provided or certificate is invalid", {
            timestamp: new Date(),
            method: req.method,
            url: req.url,
        });
    }

    // 继续处理请求
    next();
});

// 定义一个简单的路由
app.get("/", (req, res) => {
    res.send("Hello, HTTPS world!");
});

// 读取SSL证书
const options = {
    // key: fs.readFileSync("key.pem"),
    cert: fs.readFileSync("cert.pem"),
};

// 创建HTTPS服务器
https.createServer(options, app).listen(2233, () => {
    console.log("HTTPS server running on port 2233");
});
