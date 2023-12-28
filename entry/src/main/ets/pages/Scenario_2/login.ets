import PageContainer from '../../Components/PageContainer'
import hilog from '@ohos.hilog';
import { route } from '../../utils/router'


@Entry
@Component
struct Login {
  @Provide _onPageShow: number = 0
  @Provide _onPageHide: number = 0
  @State pageName: string = 'pages/Scenario_2/login';
  @State userName: string = ''
  @State password: string = ''
  controller: TextInputController = new TextInputController()
  @Builder
  pageContent() {
    Column() {
      TextInput({
        placeholder: '用户名',
        text: $$this.userName,
        controller: this.controller
      })
      TextInput({
        placeholder: '密码',
        text: $$this.password
      }).type(InputType.Password)

      Button('登录').onClick((event: ClickEvent) => {
        route.replaceUrl({
          url: 'pages/Scenario_2/userInfo',
          params: {
            userName: this.userName
          }
        })
      })
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
    hilog.info(0x0000, 'lifetimes-log', '%{public}s', this.pageName + ' OnPageShow');
    this._onPageShow = Date.now()
  }

  // 只有被@Entry装饰的组件才可以调用页面的生命周期
  onPageHide() {
    hilog.info(0x0000, 'lifetimes-log', '%{public}s', this.pageName + ' OnPageHide');
    this._onPageHide = Date.now()
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