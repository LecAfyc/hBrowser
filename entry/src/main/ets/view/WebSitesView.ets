import { ArcList, ArcListItem, ArcListAttribute, ArcListItemAttribute, LengthMetrics } from '@kit.ArkUI';


PersistentStorage.persistProp('WallPaper', 'WallPaper1');

@Component
export struct WebSitesView{
  @Consume('pageInfo') pageInfo: NavPathStack;
  @StorageLink('WallPaper') WallPaper: string = 'WallPaper1';
  content = ["哔哩哔哩", "必应翻译", "知乎", "GitHub", "华为"]
  url = ["https://www.bilibili.com", "https://cn.bing.com/translator", "https://www.zhihu.com", "https://github.com", "https://www.huawei.com"]

  build() {
    NavDestination(){
      ArcList(){
        ForEach(this.content, (item: string, index: number) => {
          ArcListItem(){
            Button({ type: ButtonType.ROUNDED_RECTANGLE, stateEffect: false }){
              Column() {
                Text(item).fontSize('18fp').fontColor(Color.White).fontWeight(FontWeight.Medium)
                Text(this.url[index]).fontSize('12fp').fontColor(Color.White)
              }.justifyContent(FlexAlign.Center)
            }
            .shadow({ radius: 2, color: 'rgba(0, 0, 0, 0.55)', offsetX: 2, offsetY: 2 })
            .margin({left: 10})
            .width(190)
            .height(40)
            .backgroundColor('rgba(255, 255, 255, 0.15)')
            .margin({top: 10})
            .onClick(() => {
              this.pageInfo.pushPath({name: "WebView", param: this.url[index]})
            })
          }
        })
      }
      .backgroundColor('rgba(255, 255, 255, 0.15)')
      .height('100%')
      .width('100%')
      .space(LengthMetrics.px(12))
      .focusable(true)
      .focusOnTouch(true)
      .defaultFocus(true)
    }
    .height('100%')
    .width('100%')
    .backgroundImage(`WallPapers/${this.WallPaper}.png`)
    .title("WebSitesView")
    .hideBackButton(true)
    .hideTitleBar(true)
    .backdropBlur(7)
    .onBackPressed(() => {
      this.pageInfo.pop()
      return true
    })
  }
}