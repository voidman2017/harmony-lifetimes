import hilog from '@ohos.hilog';
import router from '@ohos.router';
import { TproductList, IproductInfo, CompProductList } from '../Components/productList'
import PageContainer from '../Components/PageContainer'

@Entry
@Component
struct Index {
  @State pageName: string = "pages/Scenario_1/index";
  @State description: string = `
  【场景1: pushUrl[Standard]】
  有一个主页（Home）和一个详情页（Detail），希望从主页点击一个商品，跳转到详情页。同时，需要保留主页在页面栈中，以便返回时恢复状态。这种场景下，可以使用pushUrl()方法，并且使用Standard实例模式（或者省略）。
  `;
  @State productList: TproductList = []
  @State @Watch('onListChange') listLength: number = 0

  onListChange() {
    this.productList = new Array(this.listLength).fill('').map((_item: string, index): IproductInfo => {
      return {
        title: '商品' + index,
        id: index
      }
    })
  }

  @Builder
  private pageContent() {
    CompProductList({
      list: this.productList,
      onLoadMore: () => {
        return new Promise<string>((resolve, reject) => {
          // 模拟网络请求操作，请求网络2秒后得到数据，通知组件，变更列表数据
          setTimeout(() => {
            resolve('');
            this.listLength += 10
            // this.data.push("增加的条目" + this.data.length);
          }, 2000);
        });
      },
      onRefresh: () => {
        return new Promise<string>((resolve, reject) => {
          // 模拟网络请求操作，请求网络2秒后得到数据，通知组件，变更列表数据
          setTimeout(() => {
            resolve('');
            this.listLength = 10
            // this.data.push("增加的条目" + this.data.length);
          }, 2000);
        });
      },
      cardClick: (product) => {
        return new Promise<string>((resovle, reject) => {
          router.pushUrl({
            url: 'pages/Scenario_1/detail',
            params: product
          }, router.RouterMode.Single)
          resovle('')
        })
      }
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

  init() {
    this.listLength = 10
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
    this.init()
    hilog.info(0x0000, 'testTag', '%{public}s', this.pageName + ' aboutToAppear');
  }

  // 组件生命周期
  aboutToDisappear() {
    hilog.info(0x0000, 'testTag', '%{public}s', this.pageName + ' aboutToDisappear');
  }
}