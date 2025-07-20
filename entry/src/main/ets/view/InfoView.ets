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
            Text("hBrowser").fontSize('45px').fontWeight(FontWeight.Bold).margin({top:6})
          }
        }
        ArcListItem(){
          Column(){
            Text("开发者").fontSize('35px').fontWeight(FontWeight.Regular).margin({top:6})
            Text("@RegeditYC(华为)").fontSize('40px').fontWeight(FontWeight.Medium)
            Text("@LecAfyc(Github)").fontSize('40px').fontWeight(FontWeight.Medium).margin({bottom:6})
          }
          .shadow({ radius: 2, color: 'rgba(0, 0, 0, 0.55)', offsetX: 2, offsetY: 2 })
          .backgroundColor('rgba(31, 114, 255, 0.25)')
          .width('85%')
          .borderRadius({topLeft:14,topRight:14,bottomLeft:14,bottomRight:14})
        }
        ArcListItem(){
          Column(){
            Text("图标贡献").fontSize('35px').fontWeight(FontWeight.Regular).margin({top:6})
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
            Text("源码仓库").fontSize('35px').fontWeight(FontWeight.Regular).margin({top:6})
            Text("Github/hBrowser").fontSize('40px').fontWeight(FontWeight.Medium)
            Button("点击查看",{ type: ButtonType.Capsule, stateEffect: false })
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
            Text("支持我").fontSize('35px').fontWeight(FontWeight.Regular).margin({top:6})
            Text("给开发者买一杯咖啡！").fontSize('35px').fontWeight(FontWeight.Medium)
            Button("点击赞助",{ type: ButtonType.Capsule, stateEffect: false })
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