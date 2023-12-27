import hilog from '@ohos.hilog';
import router from '@ohos.router';
import HttpCapath from './http-capath'
import CompCounter from './Counter'
import { route } from '../utils/router'
@Component
export default struct PageContainer {
  @Prop pageName: string = 'page index';
  @Prop description: string = '';
  @BuilderParam pageContent?: () => void;
  @State value: number = 0

  build() {
    Column() {
      Column() {
        Row() {
          if (Number(router.getLength()) <= 1) {
            Text()
          } else {
            Image($r("app.media.backIcon")).onClick(() => {
              route.back()
            }).width(20)
          }
          Text(this.pageName)
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
          Text()
        }
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
        .width('100%')
        .padding(20)

        Text(this.description)
        Counter() {
          Text(this.value.toString())
        }.onInc(() => {
          this.value++
        })
        .onDec(() => {
          this.value--
        })
      }

      Column() {
        if (this.pageContent !== undefined) {
          this.pageContent()
        }
      }.layoutWeight(1)
    }
    .alignItems(HorizontalAlign.Center)
    .width('100%')
    .height('100%')
  }

  // 只有被@Entry装饰的组件才可以调用页面的生命周期
  onPageShow() {
    hilog.info(0x0000, 'testTag', '%{public}s', this.pageName + ' pageContainer OnPageShow');
  }

  // 只有被@Entry装饰的组件才可以调用页面的生命周期
  onPageHide() {
    hilog.info(0x0000, 'testTag', '%{public}s', this.pageName + ' pageContainer OnPageHide');
  }

  // 只有被@Entry装饰的组件才可以调用页面的生命周期
  onBackPress() {
    hilog.info(0x0000, 'testTag', '%{public}s', this.pageName + ' pageContainer OnBackPress');
  }

  // 组件生命周期
  aboutToAppear() {
    hilog.info(0x0000, 'testTag', '%{public}s', this.pageName + 'pageContainer aboutToAppear');
  }

  // 组件生命周期
  aboutToDisappear() {
    hilog.info(0x0000, 'testTag', '%{public}s', this.pageName + 'pageContainer aboutToDisappear');
  }
}