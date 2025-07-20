PersistentStorage.persistProp('WallPaper', 'WallPaper1');

@Component
export struct QRCodeView{
  @Consume('pageInfo') pageInfo: NavPathStack;
  @StorageLink('WallPaper') WallPaper: string = 'WallPaper1';
  pathStack: NavPathStack | undefined = undefined;
  pageParam: string = '';

  build() {
    NavDestination(){
      List(){
        ListItem(){
          Text(this.pageParam).fontSize('25px').margin({top:30}).width('60%')
        }
        ListItem(){
          QRCode(this.pageParam).width('65%').height('65%').backgroundColor('rgba(255,255,255,0.75)').margin({top:4,bottom:30})
        }
      }
      .backgroundColor('rgba(255, 255, 255, 0.15)')
      .height('100%')
      .width('100%')
      .focusable(true)
      .focusOnTouch(true)
      .defaultFocus(true)
      .alignListItem(ListItemAlign.Center)
    }
    .height('100%')
    .width('100%')
    .backgroundImage(`WallPapers/${this.WallPaper}.png`)
    .title("QRCodeView")
    .hideBackButton(true)
    .hideTitleBar(true)
    .backdropBlur(7)
    .onBackPressed(() => {
      this.pageInfo.pop()
      return true
    })
    .onReady((context: NavDestinationContext) => {
      this.pathStack = context.pathStack;
      this.pageParam = context.pathInfo.param as string;
    })
  }
}