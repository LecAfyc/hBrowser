import { webview } from '@kit.ArkWeb';
import { promptAction } from '@kit.ArkUI';
import { batteryInfo } from '@kit.BasicServicesKit';

function ScaleZoom(control: webview.WebviewController, targetFactor: number, pageFactor: number):void{
  let factor = targetFactor / pageFactor;
  control.zoom(factor);
}

@Component
export struct WebView{
  controller: webview.WebviewController = new webview.WebviewController();
  @Consume('pageInfo') pageInfo: NavPathStack;
  @State isToolBarOpen: boolean = false;
  @State batterySOCInfo: number = batteryInfo.batterySOC;

  onAlert: boolean = false;
  pathStack: NavPathStack | undefined = undefined;
  pageParam: string = '';
  zoom: number = 100;
  factor: number = 100;
  uiContext: UIContext = this.getUIContext();
  build() {
    NavDestination() {
      Web({ src: this.pageParam, controller: this.controller })
        .backgroundColor(Color.Gray)
        .height('100%')
        .width('100%')
        .focusable(true)
        .focusOnTouch(true)
        .defaultFocus(true)
        .onDigitalCrown((event: CrownEvent) => {
          if(event.angularVelocity >= 85) this.isToolBarOpen = true
        })
        .width('100%')
        .height('100%')
        .position({x:0, y:0})
        .onScaleChange((event) => {
          this.zoom = event.newScale;
        })
        .onErrorReceive((event) => {
          if (event.error.getErrorCode() != -2 && !this.onAlert){
            this.onAlert = true;
            this.uiContext.showAlertDialog({
              title: event.request.getRequestUrl(),
              message: "发生错误\n" + event.error.getErrorInfo() + "\n点击确定返回",
              confirm: {
                value: "确定",
                action: () => {
                  this.onAlert = false;
                  if(this.controller.accessBackward()) this.controller.backward();
                  else this.pageInfo.pop();
                }
              },
              backgroundBlurStyle: BlurStyle.COMPONENT_ULTRA_THICK,
              onWillDismiss: () => {
                this.onAlert = false;
              }
            })
          }
        })
        .onHttpErrorReceive((event) => {
          if (!this.onAlert){
            this.onAlert = true;
            this.uiContext.showAlertDialog({
              title: event.request.getRequestUrl(),
              message: "发生错误\n" + event.response.getReasonMessage() + "\n点击确定返回",
              confirm: {
                value: "确定",
                action: () => {
                  this.onAlert = false;
                  if(this.controller.accessBackward()) this.controller.backward();
                  else this.pageInfo.pop();
                }
              },
              backgroundBlurStyle: BlurStyle.COMPONENT_ULTRA_THICK,
              onWillDismiss: () => {
                this.onAlert = false;
              }
            })
          }
        })
      //ToolBar
      Swiper(){
        Column(){
          Row(){
            Button({ type: ButtonType.Circle, stateEffect: false }){
              Row() {
                SymbolGlyph($r('sys.symbol.plus_magnifyingglass'))
                  .fontSize('18fp')
                  .fontColor([Color.White])
                  .fontWeight(FontWeight.Medium)
              }.alignItems(VerticalAlign.Center)
            }
            .shadow({ radius: 2, color: 'rgba(0, 0, 0, 0.55)', offsetX: 2, offsetY: 2 })
            .width(40)
            .height(40)
            .backgroundColor('rgba(31, 114, 255, 0.75)')
            .onClick(() => {
              if(this.factor >= 280){
                this.getUIContext().getPromptAction().showToast({
                  message: '不能再大惹ヽ(*。>Д<)o゜',
                  duration: 1000,
                  showMode: promptAction.ToastShowMode.DEFAULT,
                  bottom: 80
                });
              }else{
                this.factor += 20;
                ScaleZoom(this.controller, this.factor, this.zoom);
                this.getUIContext().getPromptAction().showToast({
                  message: `缩放大小设置为${this.factor}%`,
                  duration: 1000,
                  showMode: promptAction.ToastShowMode.DEFAULT,
                  bottom: 80
                });
              }
            })
            Button({ type: ButtonType.Circle, stateEffect: false }){
              Row() {
                SymbolGlyph($r('sys.symbol.minus_magnifyingglass'))
                  .fontSize('18fp')
                  .fontColor([Color.White])
                  .fontWeight(FontWeight.Medium)
              }.alignItems(VerticalAlign.Center)
            }
            .shadow({ radius: 2, color: 'rgba(0, 0, 0, 0.55)', offsetX: 2, offsetY: 2 })
            .margin({left: 10})
            .width(40)
            .height(40)
            .backgroundColor('rgba(31, 114, 255, 0.75)')
            .onClick(() => {
              if(this.factor <= 20){
                this.getUIContext().getPromptAction().showToast({
                  message: '不能再小惹ヽ(*。>Д<)o゜',
                  duration: 1000,
                  showMode: promptAction.ToastShowMode.DEFAULT,
                  bottom: 80
                });
              }else{
                this.factor -= 20;
                ScaleZoom(this.controller, this.factor, this.zoom);
                this.getUIContext().getPromptAction().showToast({
                  message: `缩放大小设置为${this.factor}%`,
                  duration: 1000,
                  showMode: promptAction.ToastShowMode.DEFAULT,
                  bottom: 80
                });
              }
            })
          }
          .width('100%')
          .justifyContent(FlexAlign.Center)
          Row(){
            Button({ type: ButtonType.Circle, stateEffect: false }){
              Row() {
                SymbolGlyph($r('sys.symbol.arrow_left'))
                  .fontSize('18fp')
                  .fontColor([Color.White])
                  .fontWeight(FontWeight.Medium)
              }.alignItems(VerticalAlign.Center)
            }
            .shadow({ radius: 2, color: 'rgba(0, 0, 0, 0.55)', offsetX: 2, offsetY: 2 })
            .width(40)
            .height(40)
            .backgroundColor('rgba(31, 114, 255, 0.75)')
            .onClick(() => {
              this.controller.backward();
            })
            Button({ type: ButtonType.Circle, stateEffect: false }){
              Row() {
                SymbolGlyph($r('sys.symbol.arrow_counterclockwise'))
                  .fontSize('18fp')
                  .fontColor([Color.White])
                  .fontWeight(FontWeight.Medium)
              }.alignItems(VerticalAlign.Center)
            }
            .shadow({ radius: 2, color: 'rgba(0, 0, 0, 0.55)', offsetX: 2, offsetY: 2 })
            .margin({left: 10})
            .width(40)
            .height(40)
            .backgroundColor('rgba(31, 114, 255, 0.75)')
            .onClick(() => {
              this.controller.refresh();
            })
            Button({ type: ButtonType.Circle, stateEffect: false }){
              Row() {
                SymbolGlyph($r('sys.symbol.arrow_right'))
                  .fontSize('18fp')
                  .fontColor([Color.White])
                  .fontWeight(FontWeight.Medium)
              }.alignItems(VerticalAlign.Center)
            }
            .shadow({ radius: 2, color: 'rgba(0, 0, 0, 0.55)', offsetX: 2, offsetY: 2 })
            .margin({left: 10})
            .width(40)
            .height(40)
            .backgroundColor('rgba(31, 114, 255, 0.75)')
            .onClick(() => {
              this.controller.forward();
            })
          }
          .margin({top: 20})
          .width('100%')
          .justifyContent(FlexAlign.Center)
          Row(){
            Button({ type: ButtonType.Circle, stateEffect: false }){
              Row() {
                Image($r("app.media.qrcode")).width(24).height(24)
              }.alignItems(VerticalAlign.Center)
            }
            .shadow({ radius: 2, color: 'rgba(0, 0, 0, 0.55)', offsetX: 2, offsetY: 2 })
            .width(40)
            .height(40)
            .backgroundColor('rgba(31, 114, 255, 0.75)')
            .onClick(() => {
              this.pageInfo.pushPath({name: "QRCodeView", param: this.controller.getUrl()})
            })
            Button({ type: ButtonType.Circle, stateEffect: false }){
              Row() {
                SymbolGlyph($r('sys.symbol.xmark'))
                  .fontSize('18fp')
                  .fontColor([Color.White])
                  .fontWeight(FontWeight.Medium)
              }.alignItems(VerticalAlign.Center)
            }
            .shadow({ radius: 2, color: 'rgba(0, 0, 0, 0.55)', offsetX: 2, offsetY: 2 })
            .margin({left: 10})
            .width(40)
            .height(40)
            .backgroundColor('rgba(31, 114, 255, 0.75)')
            .onClick(() => {
              this.isToolBarOpen = false;
            })
          }
          .margin({top: 20})
          .width('100%')
          .justifyContent(FlexAlign.Center)
        }
        .justifyContent(FlexAlign.Center)
        .height('100%')
        .width('100%')
        Column(){
          TextClock({ timeZoneOffset: -8})
            .format('HH:mm')
            .fontColor(Color.Black)
            .fontWeight(FontWeight.Bold)
            .fontSize('38px')
          Progress({ value: this.batterySOCInfo, total: 100, type: ProgressType.Capsule }).width('55%').height('15%')
            .style({
              content: `电量 ${this.batterySOCInfo}%`,
              font: {size: '20px',weight: FontWeight.Medium},
              fontColor: Color.Black,
              enableScanEffect: false
            })
            .color(this.batterySOCInfo < 15 ? Color.Red : Color.Green)
            .margin({top: 10})
          Toggle({ type: ToggleType.Button, isOn: true }) {
            Text('电脑模式')
              .fontColor(Color.Black)
              .fontSize(12)
          }
          .width(80)
          .onChange((isOn: boolean) => {
            if (isOn) this.controller.setCustomUserAgent('Mozilla/5.0 (Wearable;OpenHarmony 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36  ArkWeb/4.1.6.1')
            else this.controller.setCustomUserAgent('Mozilla/5.0 (Phone; OpenHarmony 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36  ArkWeb/4.1.6.1 Mobile')
            this.controller.refresh();
          })
          .margin({top:10})
          .shadow({ radius: 2, color: 'rgba(0, 0, 0, 0.55)', offsetX: 2, offsetY: 2 })
          Toggle({ type: ToggleType.Button, isOn: false }) {
            Text('隐私模式')
              .fontColor(Color.Black)
              .fontSize(12)
          }
          .width(80)
          .onChange((isOn: boolean) => {
            this.controller.enableSafeBrowsing(isOn);
            this.controller.refresh();
          })
          .margin({top:10})
          .shadow({ radius: 2, color: 'rgba(0, 0, 0, 0.55)', offsetX: 2, offsetY: 2 })
        }
        .justifyContent(FlexAlign.Center)
        .height('100%')
        .width('100%')
      }
      .vertical(true)
      .indicator(true)
      .height('100%')
      .width('100%')
      .scale({
        x: this.isToolBarOpen ? 1 : 0.15,
        y: this.isToolBarOpen ? 1 : 0.15
      })
      .backgroundColor('rgba(255,255,255,0.55')
      .backdropBlur(12)
      .visibility(this.isToolBarOpen ? Visibility.Visible : Visibility.Hidden)
      .position({x:0, y:this.isToolBarOpen ? 0 : -233})
      .focusable(false)
      .focusOnTouch(false)
      .defaultFocus(false)
      .loop(false)
      .animation({
        duration: 600,
        curve: Curve.Rhythm,
        playMode: PlayMode.Alternate,
      })
    }
    .height('100%')
    .width('100%')
    .title("WebView")
    .hideBackButton(true)
    .hideTitleBar(true)
    .backdropBlur(14)
    .onReady((context: NavDestinationContext) => {
      this.pathStack = context.pathStack;
      this.pageParam = context.pathInfo.param as string;
    })
  }
}