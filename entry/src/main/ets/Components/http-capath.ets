import { BusinessError } from '@ohos.base';
import fs from '@ohos.file.fs';
import http from '@ohos.net.http'
import hilog from '@ohos.hilog';
@Component
export default struct HttpCapath {
  @Consume @Watch("onPageShow") _onPageShow?: number;
  @Consume @Watch("onPageHide") _onPageHide?: number;
    build(){
      Button('http-capath').onClick((event: ClickEvent) => {
        // getContext(this).area = 0
        let context: Context = getContext(this);
        const keyPemConent = context.resourceManager.getRawFileContentSync('key.pem')
        let filesDir: string = context.filesDir
        let filePath = filesDir + "/aaa.pem";
        let file = fs.openSync(filePath, fs.OpenMode.READ_WRITE | fs.OpenMode.CREATE);
        fs.writeSync(file.fd, keyPemConent.buffer);
        fs.fsyncSync(file.fd);
        fs.closeSync(file);

        const httpRequest = http.createHttp();
        httpRequest.request(// 填写HTTP请求的URL地址，可以带参数也可以不带参数。URL地址需要开发者自定义。请求的参数可以在extraData中指定
          "https://10.188.27.102:2233/?id=http-request",
          {
            method: http.RequestMethod.GET,
            caPath: filePath,
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

  // 只有被@Entry装饰的组件才可以调用页面的生命周期
  onPageShow() {
    hilog.info(0x0000, 'lifetimes-log', '%{public}s', "Component Http-caPath" + ' OnPageShow');
  }

  // 只有被@Entry装饰的组件才可以调用页面的生命周期
  onPageHide() {
    hilog.info(0x0000, 'lifetimes-log', '%{public}s', "Component Http-caPath" + ' OnPageHide');
  }

  // 只有被@Entry装饰的组件才可以调用页面的生命周期
  onBackPress() {
    hilog.info(0x0000, 'lifetimes-log', '%{public}s', "Component Http-caPath" + ' OnBackPress');
  }

  // 组件生命周期
  aboutToAppear() {
    hilog.info(0x0000, 'lifetimes-log', '%{public}s', "Component Http-caPath" + ' aboutToAppear');
  }

  // 组件生命周期
  aboutToDisappear() {
    hilog.info(0x0000, 'lifetimes-log', '%{public}s', "Component Http-caPath" + ' aboutToDisappear');
  }
}