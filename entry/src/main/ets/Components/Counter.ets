@Component
export default struct CompCounter {
  @State counter: number = 1

  build() {
    Row() {
      Button('-').onClick((event: ClickEvent) => {
        this.counter--
      })

      Text(String(this.counter))
        .width('100px')
        .textAlign(TextAlign.Center)
        .border({ width: '1px', color: 'black' })

      Button('+').onClick((event: ClickEvent) => {
        this.counter++
      })
    }
  }
}