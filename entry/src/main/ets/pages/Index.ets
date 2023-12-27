import hilog from '@ohos.hilog';
import router from '@ohos.router';
import HttpCapath from './Components/http-capath'
import CompCounter from './Components/Counter'
import PageContainer from './Components/PageContainer'
import List from '@ohos.util.List';
import { route } from './utils/router'

@Entry
@Component
struct Index {
  @State pageName: string = 'page index';
  @State pages: string[] = [
    "pages/pageSecond",
    "pages/Scenario_1/index",
  ]

  @Builder
  private pageContent() {
    ForEach(this.pages, (item: string, index) => {
      Button(item).onClick(() => {
        route.pushUrl({
          url: item
        })
      })
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
    hilog.info(0x0000, 'testTag', '%{public}s', this.pageName + ' OnPageShow');
  }

  // 只有被@Entry装饰的组件才可以调用页面的生命周期
  onPageHide() {
    hilog.info(0x0000, 'testTag', '%{public}s', this.pageName + ' OnPageHide');
  }

  // 只有被@Entry装饰的组件才可以调用页面的生命周期
  onBackPress() {
    hilog.info(0x0000, 'testTag', '%{public}s', this.pageName + ' OnBackPress');
  }

  // 组件生命周期
  aboutToAppear() {
    hilog.info(0x0000, 'testTag', '%{public}s', this.pageName + ' aboutToAppear');
  }

  // 组件生命周期
  aboutToDisappear() {
    hilog.info(0x0000, 'testTag', '%{public}s', this.pageName + ' aboutToDisappear');
  }
}