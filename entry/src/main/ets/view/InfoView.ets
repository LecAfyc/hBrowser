import { ArcList, ArcListItem, ArcListAttribute, ArcListItemAttribute, LengthMetrics } from '@kit.ArkUI';
PersistentStorage.persistProp('WallPaper', 'WallPaper1');

@Component
export struct InfoView{
  @Consume('pageInfo') pageInfo: NavPathStack;
  @StorageLink('WallPaper') WallPaper: string = 'WallPaper1';

  build() {
    NavDestination(){

      ArcList(){
        ArcListItem(){
          Column(){
            Image($r("app.media.foreground")).width('20%').height('20%')
            Text($r('app.string.EntryAbility_label')).fontSize('45px').fontWeight(FontWeight.Bold).margin({top:6})
          }
        }
        ArcListItem(){
          Column(){
            Text($r('app.string.author')).fontSize('35px').fontWeight(FontWeight.Regular).margin({top:6})
            Text("@RegeditYC(HW)").fontSize('40px').fontWeight(FontWeight.Medium)
            Text("@LecAfyc(Github)").fontSize('40px').fontWeight(FontWeight.Medium).margin({bottom:6})
          }
          .shadow({ radius: 2, color: 'rgba(0, 0, 0, 0.55)', offsetX: 2, offsetY: 2 })
          .backgroundColor('rgba(31, 114, 255, 0.25)')
          .width('85%')
          .borderRadius({topLeft:14,topRight:14,bottomLeft:14,bottomRight:14})
        }
        ArcListItem(){
          Column(){
            Text($r('app.string.icon_author')).fontSize('35px').fontWeight(FontWeight.Regular).margin({top:6})
            Text("@EXE(QQ)").fontSize('40px').fontWeight(FontWeight.Medium)
            Text("@2961564671(QQ)").fontSize('40px').fontWeight(FontWeight.Medium).margin({bottom:6})
          }
          .shadow({ radius: 2, color: 'rgba(0, 0, 0, 0.55)', offsetX: 2, offsetY: 2 })
          .backgroundColor('rgba(31, 114, 255, 0.25)')
          .width('85%')
          .borderRadius({topLeft:14,topRight:14,bottomLeft:14,bottomRight:14})
        }
        ArcListItem(){
          Column(){
            Text($r('app.string.github')).fontSize('35px').fontWeight(FontWeight.Regular).margin({top:6})
            Text("Github/hBrowser").fontSize('40px').fontWeight(FontWeight.Medium)
            Button($r('app.string.click_to_open'),{ type: ButtonType.Capsule, stateEffect: false })
              .fontSize('40px')
              .fontWeight(FontWeight.Medium)
              .margin({bottom:6})
              .onClick(() => {
                this.pageInfo.pushPath({name: "QRCodeView", param: "https://github.com/LecAfyc/hBrowser"})
              })
          }
          .shadow({ radius: 2, color: 'rgba(0, 0, 0, 0.55)', offsetX: 2, offsetY: 2 })
          .backgroundColor('rgba(31, 114, 255, 0.25)')
          .width('85%')
          .borderRadius({topLeft:14,topRight:14,bottomLeft:14,bottomRight:14})
        }
        ArcListItem(){
          Column(){
            Text($r('app.string.donate')).fontSize('35px').fontWeight(FontWeight.Regular).margin({top:6})
            Text($r('app.string.donate_description')).fontSize('35px').fontWeight(FontWeight.Medium)
            Button($r('app.string.search'),{ type: ButtonType.Capsule, stateEffect: false })
              .fontSize('40px')
              .fontWeight(FontWeight.Medium)
              .margin({bottom:6})
              .onClick(() => {
                this.pageInfo.pushPath({name: "QRCodeView", param: "https://qr.alipay.com/fkx140839d698sf1rk7b122"})
              })
          }
          .shadow({ radius: 2, color: 'rgba(0, 0, 0, 0.55)', offsetX: 2, offsetY: 2 })
          .backgroundColor('rgba(31, 114, 255, 0.25)')
          .width('85%')
          .borderRadius({topLeft:14,topRight:14,bottomLeft:14,bottomRight:14})
        }
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
    .title("InfoView")
    .hideBackButton(true)
    .hideTitleBar(true)
    .backdropBlur(7)
    .onBackPressed(() => {
      this.pageInfo.pop()
      return true
    })
  }
}