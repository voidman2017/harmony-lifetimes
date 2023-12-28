import hilog from '@ohos.hilog';
import router from '@ohos.router';
import PageContainer from '../Components/PageContainer'
import { route } from '../utils/router'

@Entry
@Component
struct Index {
  @State pageName: string = 'pages/pageSecond';
  @State description: string = '';
  @Provide _onPageShow: number = 0
  @Provide _onPageHide: number = 0

  @Builder
  private pageContent() {
    Button('to index').onClick(() => {
      route.pushUrl({
        url: 'pages/Index'
      },router.RouterMode.Single)
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
    hilog.info(0x0000, 'lifetimes-log', '%{public}s', this.pageName + ' OnPageShow');
    this._onPageShow++
  }

  onPageHide() {
    hilog.info(0x0000, 'lifetimes-log', '%{public}s', this.pageName + ' OnPageHide');
    this._onPageHide++
  }

  onBackPress() {
    hilog.info(0x0000, 'lifetimes-log', '%{public}s', this.pageName + ' OnBackPress');
  }

  aboutToAppear() {
    hilog.info(0x0000, 'lifetimes-log', '%{public}s', this.pageName + ' aboutToAppear');
  }

  aboutToDisappear() {
    hilog.info(0x0000, 'lifetimes-log', '%{public}s', this.pageName + ' aboutToDisappear');
  }
}