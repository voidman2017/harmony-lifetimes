import { PullToRefresh } from '@ohos/pulltorefresh'

export interface IproductInfo {
  title: string
  id: number
}

export type TproductList = IproductInfo[]


@Component
export struct CompProductCard {
  @Prop info: IproductInfo

  build() {
    Text(this.info.title)
  }
}

@Component
export struct CompProductList {
  @Prop list: TproductList
  onLoadMore?: () => Promise<string> = () => {
    return new Promise<string>((resolve, reject) => {
      resolve('');
    });
  };
  onRefresh?: () => Promise<string> = () => {
    return new Promise<string>((resolve, reject) => {
      resolve('');
    });
  };
  cardClick?: (item:IproductInfo) => Promise<string> = () => {
    return new Promise<string>((resolve, reject) => {
      resolve('');
    });
  };
  // 需绑定列表或宫格组件
  private scroller: Scroller = new Scroller();
  @State refreshText: string = '';
  private dataNumbers: string[] = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10'];
  private dataStrings: string[] = ['我的评论', '与我相关', '个人中心1', '个人中心2', '个人中心3', '我的发布', '设置', '退出登录'];
  @State data: string[] = this.dataStrings;

  // 需绑定列表或宫格组件
  build() {
    PullToRefresh({
      // 必传项，列表组件所绑定的数据
      data: $data,
      // 必传项，需绑定传入主体布局内的列表或宫格组件
      scroller: this.scroller,
      // 必传项，自定义主体布局，内部有列表或宫格组件
      customList: () => {
        // 一个用@Builder修饰过的UI方法
        this.getListView();
      },
      // 可选项，下拉刷新回调
      onRefresh: () => {
        return new Promise<string>(async (resolve, reject) => {
          this.onRefresh && await this.onRefresh();
          resolve('刷新成功');
        });
      },
      // 可选项，上拉加载更多回调
      onLoadMore: () => {
        return new Promise<string>(async (resolve, reject) => {
          this.onLoadMore && await  this.onLoadMore()
          resolve('');
        });
      },
      customLoad: null,
      customRefresh: null,
    })

  }

  @Builder
  private getListView() {
    List({ space: 20, scroller: this.scroller }) {
      ForEach(this.list, (item: IproductInfo,index:number) => {
        ListItem() {
          Text(item.title)
            .width('100%')
            .height(150)
            .fontSize(20)
            .textAlign(TextAlign.Center)
            .backgroundColor('#95efd2')
        }
        .onClick(()=>{
          this.cardClick && this.cardClick(item)
        })
      })
    }
    .backgroundColor('#eeeeee')
    .divider({ strokeWidth: 1, color: 0x222222 })
    .edgeEffect(EdgeEffect.None) // 必须设置列表为滑动到边缘无效果
  }
}