import PageContainer from '../Components/PageContainer'
import hilog from '@ohos.hilog';
import router from '@ohos.router';

class routerParams {
  userName:string

  constructor(str:string) {
    this.userName = str
  }
}


@Entry
@Component
struct UserInfo {
  @State pageName: string = 'pages/Scenario_2/userInfo';
  @State userName: string = ''

  @Builder
  pageContent() {
    Column() {
      Text(`Hello ${this.userName}`)
        .fontSize(50)
    }
  }

  build() {
    Row() {
      PageContainer({
        pageName: this.pageName,
        description: `有一个登录页（Login）和一个个人中心页（Profile），希望从登录页成功登录后，跳转到个人中心页。同时，销毁登录页，在返回时直接退出应用。这种场景下，可以使用replaceUrl()方法，并且使用Standard实例模式（或者省略）。`,
        pageContent: () => {
          this.pageContent()
        }
      })
    }
  }

  // 只有被@Entry装饰的组件才可以调用页面的生命周期
  onPageShow() {
    hilog.info(0x0000, 'testTag', '%{public}s', this.pageName + ' OnPageShow');
    this.userName = (router.getParams() as routerParams).userName
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