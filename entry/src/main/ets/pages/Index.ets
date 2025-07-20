import { InfoView } from '../view/InfoView';
import { PicturesView } from '../view/PicturesView';
import { QRCodeView } from '../view/QRCodeView';
import { WebView } from '../view/WebView';
import { WebSitesView } from '../view/WebSitesView';
import { IntroduceView } from '../view/IntroduceView';


PersistentStorage.persistProp('WallPaper', 'WallPaper1');
PersistentStorage.persistProp('IsFirst', true);


@Entry
@Component
struct Index {
  @Provide('pageInfo') pageInfo: NavPathStack = new NavPathStack();
  @StorageLink('WallPaper') WallPaper: string = 'WallPaper1';
  @StorageLink('IsFirst') IsFirst: boolean = true;
  input: string = "";

  @Builder
  PageMap(name: string,param: string){
    if(name === "InfoView") InfoView();
    else if (name === "HistoryView") InfoView();//HistoryView()
    else if (name === "PicturesView") PicturesView();//PicturesView()
    else if (name === "WebView") WebView();//WebView()
    else if(name === "QRCodeView") QRCodeView();
    else if(name === "WebSitesView") WebSitesView();
    else if(name === "IntroduceView") IntroduceView();
  }

  build() {
    Navigation(this.pageInfo) {
      Swiper(){
        Column(){
          TextInput({ placeholder: $r('app.string.search') })
            .textAlign(TextAlign.Center)
            .type(InputType.Normal)
            .margin({ top: 30})
            .fontSize('17fp')
            .width(175)
            .shadow({ radius: 2, color: 'rgba(0, 0, 0, 0.55)', offsetX: 2, offsetY: 2 })
            .onChange(value => {
              this.input = value;
            })
          Row(){
            Button({ type: ButtonType.Capsule, stateEffect: false }){
              Row() {
                SymbolGlyph($r('sys.symbol.magnifyingglass'))
                  .fontSize('18fp')
                  .fontColor([Color.White])
                  .fontWeight(FontWeight.Medium)
                Text($r('app.string.baidu')).fontSize('18fp').fontColor(Color.White).fontWeight(FontWeight.Medium)
              }.alignItems(VerticalAlign.Center)
            }
            .shadow({ radius: 2, color: 'rgba(0, 0, 0, 0.55)', offsetX: 2, offsetY: 2 })
            .width(100)
            .height(40)
            .backgroundColor('rgba(31, 114, 255, 0.75)')
            .onClick(() => {
              this.pageInfo.pushPath({name: "WebView", param: `https://www.baidu.com/s?wd=${this.input}`})
            })
            Button({ type: ButtonType.Capsule, stateEffect: false }){
              Row() {
                SymbolGlyph($r('sys.symbol.magnifyingglass'))
                  .fontSize('18fp')
                  .fontColor([Color.White])
                  .fontWeight(FontWeight.Medium)
                Text($r('app.string.bing')).fontSize('18fp').fontColor(Color.White).fontWeight(FontWeight.Medium)
              }.alignItems(VerticalAlign.Center)
            }
            .shadow({ radius: 2, color: 'rgba(0, 0, 0, 0.55)', offsetX: 2, offsetY: 2 })
            .margin({left: 10})
            .width(100)
            .height(40)
            .backgroundColor('rgba(31, 114, 255, 0.75)')
            .onClick(() => {
              this.pageInfo.pushPath({name: "WebView", param: `https://cn.bing.com/search?q=${this.input}`})
            })
          }
          .margin({top: 10})
          .width('100%')
          .justifyContent(FlexAlign.Center)
          Button({ type: ButtonType.Capsule, stateEffect: false }){
            Row() {
              SymbolGlyph($r('sys.symbol.paperclip'))
                .fontSize('18fp')
                .fontColor([Color.White])
                .fontWeight(FontWeight.Medium)
              Text($r('app.string.openurl')).fontSize('18fp').fontColor(Color.White).fontWeight(FontWeight.Medium)
            }.alignItems(VerticalAlign.Center)
          }
          .shadow({ radius: 2, color: 'rgba(0, 0, 0, 0.55)', offsetX: 2, offsetY: 2 })
          .margin({left: 10})
          .width(190)
          .height(40)
          .backgroundColor('rgba(31, 114, 255, 0.75)')
          .margin({top: 10})
          .onClick(() => {
            this.pageInfo.pushPath({name: "WebView", param: this.input})
          })
          Text($r('app.string.down'))
            .margin({top:12})
            .fontSize('15fp')
            .width('50%')
            .height('10%')
            .shadow({ radius: 2, color: 'rgba(0, 0, 0, 0.55)', offsetX: 2, offsetY: 2 })
            .borderRadius(10)
            .backgroundColor('rgba(255, 255, 255, 0.1)')
        }
        .height('100%')
        .width('100%')
        .backgroundColor('rgba(255, 255, 255, 0.15)')
        Column(){
          Button({ type: ButtonType.Capsule, stateEffect: false }){
            Row() {
              SymbolGlyph($r('sys.symbol.info_circle'))
                .fontSize('18fp')
                .fontColor([Color.White])
                .fontWeight(FontWeight.Medium)
              Text($r('app.string.about')).fontSize('18fp').fontColor(Color.White).fontWeight(FontWeight.Medium)
            }.alignItems(VerticalAlign.Center)
          }
          .shadow({ radius: 2, color: 'rgba(0, 0, 0, 0.55)', offsetX: 2, offsetY: 2 })
          .margin({top:30})
          .width(150)
          .height(40)
          .backgroundColor('rgba(31, 114, 255, 0.75)')
          .onClick(() => {
            this.pageInfo.pushPath({name: "InfoView", param: ""})
          })
          Button({ type: ButtonType.Capsule, stateEffect: false }){
            Row() {
              SymbolGlyph($r('sys.symbol.star'))
                .fontSize('18fp')
                .fontColor([Color.White])
                .fontWeight(FontWeight.Medium)
              Text($r('app.string.websites')).fontSize('18fp').fontColor(Color.White).fontWeight(FontWeight.Medium)
            }.alignItems(VerticalAlign.Center)
          }
          .shadow({ radius: 2, color: 'rgba(0, 0, 0, 0.55)', offsetX: 2, offsetY: 2 })
          .margin({top:30})
          .width(150)
          .height(40)
          .backgroundColor('rgba(31, 114, 255, 0.75)')
          .onClick(() => {
            this.pageInfo.pushPath({name: "WebSitesView", param: ""})
          })
          Button({ type: ButtonType.Capsule, stateEffect: false }){
            Row() {
              SymbolGlyph($r('sys.symbol.more'))
                .fontSize('18fp')
                .fontColor([Color.White])
                .fontWeight(FontWeight.Medium)
              Text($r('app.string.wallpaper')).fontSize('18fp').fontColor(Color.White).fontWeight(FontWeight.Medium)
            }.alignItems(VerticalAlign.Center)
          }
          .shadow({ radius: 2, color: 'rgba(0, 0, 0, 0.55)', offsetX: 2, offsetY: 2 })
          .margin({top:30})
          .width(150)
          .height(40)
          .backgroundColor('rgba(31, 114, 255, 0.75)')
          .onClick(() => {
            this.pageInfo.pushPath({name: "PicturesView", param: ""})
          })
        }
        .height('100%')
        .width('100%')
        .backgroundColor('rgba(255, 255, 255, 0.15)')
      }
      .height('100%')
      .width('100%')
      .loop(false)
      .vertical(true)
      .indicator(false)
    }
    .height('100%')
    .width('100%')
    .backgroundImage(`WallPapers/${this.WallPaper}.png`)
    .backdropBlur(7)
    .hideTitleBar(true)
    .hideToolBar(true)
    .hideBackButton(true)
    .navDestination(this.PageMap)
    .onAppear(() => {
      if(this.IsFirst){
        this.IsFirst = false;
        this.pageInfo.pushPath({name: "IntroduceView", param: ""})
      }
    })
  }
}

