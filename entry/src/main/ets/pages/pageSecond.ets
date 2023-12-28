import hilog from '@ohos.hilog';
import router from '@ohos.router';
import PageContainer from './Components/PageContainer'
import { route } from './utils/router'

@Entry
@Component
struct Index {
  @State pageName: string = 'pages/pageSecond';
  @State description: string = '';

  @Builder
  private pageContent() {
    Button('to index').onClick(() => {
      route.pushUrl({
        url: 'pages/Index'
      })
    })
  }

  build() {
    Row() {
      PageContainer({
        pageName: this.pageName,
        description: this.description,
        pageContent: () => {
          this.pageContent()
        }
      })
    }
    .height('100%')
  }

  onPageShow() {
    hilog.info(0x0000, 'testTag', '%{public}s', this.pageName + ' OnPageShow');
  }

  onPageHide() {
    hilog.info(0x0000, 'testTag', '%{public}s', this.pageName + ' OnPageHide');
  }

  onBackPress() {
    hilog.info(0x0000, 'testTag', '%{public}s', this.pageName + ' OnBackPress');
  }

  aboutToAppear() {
    hilog.info(0x0000, 'testTag', '%{public}s', this.pageName + ' aboutToAppear');
  }

  aboutToDisappear() {
    hilog.info(0x0000, 'testTag', '%{public}s', this.pageName + ' aboutToDisappear');
  }
}