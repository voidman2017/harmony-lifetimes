import hilog from '@ohos.hilog';
import router from '@ohos.router';
import HttpCapath from './http-capath'
import CompCounter from './Counter'
import { route } from '../utils/router'

@Component
export default struct PageContainer {
  @Prop pageName: string = 'Component PageContainer';
  @Consume @Watch("onPageShow") _onPageShow?: number;
  @Consume @Watch("onPageHide") _onPageHide?: number;
  @Prop description: string = '';
  @BuilderParam pageContent?: () => void;
  @State value: number = 0
  @State routeLength: string = '0'

  updateRoutesLength() {
    const length: string = router.getLength()
    this.routeLength = length
  }

  build() {
    Column() {
      Column() {
        Row() {
          if (Number(this.routeLength) <= 1) {
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

        Text('the number of pages in the current stack： ' + this.routeLength).onClick(() => {
          const length: string = router.getLength()
          this.routeLength = length
        })
          .margin(5)
          .fontStyle(FontStyle.Italic)

        // HttpCapath()

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
    this.updateRoutesLength()
    hilog.info(0x0000, 'lifetimes-log', '%{public}s', "Component PageContainer in " + this.pageName + ' OnPageShow');
  }

  // 只有被@Entry装饰的组件才可以调用页面的生命周期
  onPageHide() {
    hilog.info(0x0000, 'lifetimes-log', '%{public}s', "Component PageContainer in " + this.pageName + ' OnPageHide');
  }

  // 只有被@Entry装饰的组件才可以调用页面的生命周期
  onBackPress() {
    hilog.info(0x0000, 'lifetimes-log', '%{public}s', "Component PageContainer in " + this.pageName + ' OnBackPress');
  }

  // 组件生命周期
  aboutToAppear() {
    hilog.info(0x0000, 'lifetimes-log', '%{public}s', "Component PageContainer in " + this.pageName + ' aboutToAppear');
    this.updateRoutesLength()
  }

  // 组件生命周期
  aboutToDisappear() {
    hilog.info(0x0000, 'lifetimes-log', '%{public}s', "Component PageContainer in " + this.pageName + ' aboutToDisappear');
  }
}