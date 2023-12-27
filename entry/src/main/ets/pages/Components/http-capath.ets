import { BusinessError } from '@ohos.base';
import fs from '@ohos.file.fs';
import http from '@ohos.net.http'

@Component
export default struct HttpCapath {
    build(){
      Button('http-capath').onClick((event: ClickEvent) => {
        // getContext(this).area = 0
        const path = getContext(this).resourceManager.getRawFdSync('key.pem')
        const caPath = getContext(this).filesDir + '/ccc.pem'
        fs.copyFileSync(path.fd, caPath)
        let httpRequest = http.createHttp();
        httpRequest.request(// 填写HTTP请求的URL地址，可以带参数也可以不带参数。URL地址需要开发者自定义。请求的参数可以在extraData中指定
          "https://10.188.27.102:2233/?id=http-request",
          {
            method: http.RequestMethod.GET,
            caPath: caPath,
          },
          (err: BusinessError, data: http.HttpResponse) => {
            if (!err) {
              // data.result为HTTP响应内容，可根据业务需要进行解析
              console.info('Result:' + JSON.stringify(data.result));
              console.info('code:' + JSON.stringify(data.responseCode));
              // data.header为HTTP响应头，可根据业务需要进行解析
              console.info('header:' + JSON.stringify(data.header));
              console.info('cookies:' + JSON.stringify(data.cookies)); // 8+
              // 当该请求使用完毕时，调用destroy方法主动销毁
              httpRequest.destroy();
            }
            else {
              console.error('error:' + JSON.stringify(err));
              // 当该请求使用完毕时，调用destroy方法主动销毁
              httpRequest.destroy();
            }
          }
        );
      })
    }
}