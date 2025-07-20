import {
  ArcSwiper,
  ArcSwiperAttribute,
  ArcDotIndicator,
  ArcDirection,
  ArcSwiperController
} from '@kit.ArkUI';
PersistentStorage.persistProp('WallPaper', 'WallPaper1');

@Component
export struct IntroduceView{
  @Consume('pageInfo') pageInfo: NavPathStack;
  @StorageLink('WallPaper') WallPaper: string = 'WallPaper1';
  pathStack: NavPathStack | undefined = undefined;
  pageParam: string = '';

  build() {
    NavDestination(){
      ArcSwiper(){
        Image($r("app.media.intro1"))
          .width('100%')
          .height('100%')

        Image($r("app.media.intro2"))
          .width('100%')
          .height('100%')

        Image($r("app.media.intro3"))
          .width('100%')
          .height('100%')

        Column(){
          Image($r("app.media.foreground")).width('20%').height('20%')
          Text("hBrowser").fontSize('45px').fontWeight(FontWeight.Bold).margin({top:6})
          Button($r('app.string.start'),{ type: ButtonType.Capsule, stateEffect: false })
            .fontSize('27px')
            .fontWeight(FontWeight.Bold)
            .margin({top:6})
            .shadow({ radius: 2, color: 'rgba(0, 0, 0, 0.55)', offsetX: 2, offsetY: 2 })
            .backgroundColor('rgba(31, 114, 255, 0.75)')
            .onClick(() => {
              this.pageInfo.clear();
              return true
            })
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
      }
    }
    .height('100%')
    .width('100%')
    .title("IntroduceView")
    .hideBackButton(true)
    .hideTitleBar(true)
    .backgroundImage(`WallPapers/${this.WallPaper}.png`)
    .backdropBlur(7)
    .onBackPressed(() => {
      this.pageInfo.pop()
      return true
    })
  }
}