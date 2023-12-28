import router from '@ohos.router';
import hilog from '@ohos.hilog';

// 使用类型别名来简化函数类型的定义
type PushUrlFunction = (option: router.RouterOptions, mode?: router.RouterMode) => void;
type BackFunction = (option?: router.RouterOptions) => void
type replaceUrlFunction = (option: router.RouterOptions, mode?: router.RouterMode) => void;

interface IRoute {
  pushUrl: PushUrlFunction
  back: BackFunction
  replaceUrl: replaceUrlFunction
}

export const route: IRoute = {
  pushUrl: (option: router.RouterOptions, mode: router.RouterMode = router.RouterMode.Standard) => {
    const routerState: router.RouterState = router.getState()
    // 将枚举的值转换为对应的键
    const modeKey = Object.keys(router.RouterMode)[Object.values(router.RouterMode).indexOf(mode)];
    hilog.info(0x0000, 'lifetimes-log', '%{public}s', `${routerState.path}${routerState.name} ------pushUrl-------> ${option.url}  [${modeKey}]`);
    router.pushUrl(option, mode)
  },
  back: (option?: router.RouterOptions) => {
    const routerState: router.RouterState = router.getState()
    hilog.info(0x0000, 'lifetimes-log', '%{public}s', `${option?.url ? option.url : ''} <------back------- ${routerState.path}${routerState.name}`);
    router.back(option)
  },
  replaceUrl: (option: router.RouterOptions, mode: router.RouterMode = router.RouterMode.Standard) => {
    const routerState: router.RouterState = router.getState()
    // 将枚举的值转换为对应的键
    const modeKey = Object.keys(router.RouterMode)[Object.values(router.RouterMode).indexOf(mode)];
    hilog.info(0x0000, 'lifetimes-log', '%{public}s', `${routerState.path}${routerState.name} ------replaceUrl-------> ${option.url}  [${modeKey}]`);
    router.replaceUrl(option, mode)
  },
}