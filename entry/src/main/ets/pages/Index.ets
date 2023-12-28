import hilog from '@ohos.hilog';
import router from '@ohos.router';
import PageContainer from '../Components/PageContainer'
import { route } from '../utils/router'

@Entry
@Component
struct Index {
  @State pageName: string = 'pages/Index';
  @Provide _onPageShow: number = 0
  @Provide _onPageHide: number = 0
  @State pages: string[] = [
    "pages/pageSecond",
    "pages/Scenario_1/list",
    "pages/Scenario_2/login",
  ]

  @Builder
  private pageContent() {
    ForEach(this.pages, (item: string, index) => {
      Button(item).onClick(() => {
        route.pushUrl({
          url: item
        }, router.RouterMode.Single)
      }).margin(5)
    })
  }

  build() {
    Column() {
      PageContainer({
        pageName: 'page Index',
        description: '',
        pageContent: () => {
          this.pageContent()
        }
      })
    }
  }

  // 只有被@Entry装饰的组件才可以调用页面的生命周期
  onPageShow() {
    hilog.info(0x0000, 'lifetimes-log', '%{public}s', this.pageName + ' OnPageShow');
    this._onPageShow++
  }

  // 只有被@Entry装饰的组件才可以调用页面的生命周期
  onPageHide() {
    hilog.info(0x0000, 'lifetimes-log', '%{public}s', this.pageName + ' OnPageHide');
    this._onPageHide++
  }

  // 只有被@Entry装饰的组件才可以调用页面的生命周期
  onBackPress() {
    hilog.info(0x0000, 'lifetimes-log', '%{public}s', this.pageName + ' OnBackPress');
  }

  // 组件生命周期
  aboutToAppear() {
    hilog.info(0x0000, 'lifetimes-log', '%{public}s', this.pageName + ' aboutToAppear');
  }

  // 组件生命周期
  aboutToDisappear() {
    hilog.info(0x0000, 'lifetimes-log', '%{public}s', this.pageName + ' aboutToDisappear');
  }
}