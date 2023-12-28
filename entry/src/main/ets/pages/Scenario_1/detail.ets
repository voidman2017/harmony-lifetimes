import hilog from '@ohos.hilog';
import router from '@ohos.router';
import { TproductList, IproductInfo, CompProductList } from '../../Components/productList'
import { ProgressButton } from '@ohos.arkui.advanced.ProgressButton';
import PageContainer from '../../Components/PageContainer'
import { route } from '../../utils/router'

@Entry
@Component
struct Index {
  @State pageName: string = 'pages/Scenario_1/detail';
  @State description: string = '有一个主页（Home）和一个详情页（Detail），希望从主页点击一个商品，跳转到详情页。同时，需要保留主页在页面栈中，以便返回时恢复状态。这种场景下，可以使用pushUrl()方法，并且使用Standard实例模式（或者省略）。';
  @State info: IproductInfo = { title: '', id: 0 };
  @Provide _onPageShow: number = 0
  @Provide _onPageHide: number = 0

  @Builder
  private PageContent() {
    Text(this?.info?.title)
      .fontColor('red')
      .margin({
        top: 10
      })
      .fontSize(22)

    Button('重新选择商品').onClick((event: ClickEvent) => {
      route.pushUrl({
        url: 'pages/Scenario_1/list'
      }, router.RouterMode.Single)
    })
  }

  build() {
    Column() {
      PageContainer({
        pageName: this.pageName,
        description: this.description,
        pageContent: () => {
          this.PageContent()
        }
      })
    }
    .height('100%')
  }

  onPageShow() {
    hilog.info(0x0000, 'lifetimes-log', '%{public}s', this.pageName + ' OnPageShow');
    const params: Record<string, Object> = { 'info': router.getParams() }; // 获取传递过来的参数对象
    this.info = params['info'] as IproductInfo
    this._onPageShow = Date.now()
  }

  onPageHide() {
    hilog.info(0x0000, 'lifetimes-log', '%{public}s', this.pageName + ' OnPageHide');
    this._onPageHide = Date.now()
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