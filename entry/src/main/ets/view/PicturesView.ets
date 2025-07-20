import { promptAction } from "@kit.ArkUI";
PersistentStorage.persistProp('WallPaper', 'WallPaper1');

@Component
export struct PicturesView{
  @Consume('pageInfo') pageInfo: NavPathStack;
  @StorageLink('WallPaper') WallPaper: string = 'WallPaper1';
  pathStack: NavPathStack | undefined = undefined;
  pageParam: string = '';
  names: string[] = ['WallPaper1', 'WallPaper2', 'WallPaper3','WallPaper4','WallPaper5','WallPaper6','WallPaper7']

  build() {
    NavDestination(){
      List(){
        ListItem(){
          Column(){
            Text($r('app.string.click_to_chose')).fontSize('45px').fontWeight(FontWeight.Bold).margin({top:17})
            Text($r('app.string.wallpaper_description')).fontSize('35px').fontWeight(FontWeight.Bold).margin({top:7})
          }
        }
        ForEach(this.names, (item: string, index: number) => {
          ListItem(){
            Button({ type: ButtonType.ROUNDED_RECTANGLE, stateEffect: false }){
              Row() {
                Image(`WallPapers/${item}.png`)
                  .width(130)
                  .height(130)
              }.alignItems(VerticalAlign.Center)
            }
            .shadow({ radius: 2, color: 'rgba(0, 0, 0, 0.55)', offsetX: 2, offsetY: 2 })
            .margin({top:30})
            .width(150)
            .height(150)
            .backgroundColor('rgba(31, 114, 255, 0.75)')
            .onClick(() => {
              this.WallPaper = item;
              this.getUIContext().getPromptAction().showToast({
                message: $r('app.string.wallpaper_tip') + item,
                duration: 1500,
                showMode: promptAction.ToastShowMode.DEFAULT,
                bottom: 80
              });
            })
            }
        })
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
    .title("PicturesView")
    .hideBackButton(true)
    .hideTitleBar(true)
    .backdropBlur(7)
    .onBackPressed(() => {
      this.pageInfo.pop()
      return true
    })
  }
}