import SwiftUI

let exampleText = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin ac nunc consequat, sodales libero in, tempor erat. Suspendisse varius, tortor vel varius ullamcorper, odio orci sagittis odio, eu aliquam est turpis eget lacus. Aenean eu mauris tincidunt, vulputate orci iaculis, suscipit diam. Fusce accumsan, tellus eget imperdiet hendrerit, est nunc tristique enim, a vulputate velit ante et libero. In vehicula, lacus eget tempor euismod, erat justo ullamcorper arcu, id finibus leo augue aliquam nisl. Fusce tempor justo magna, vitae blandit metus sagittis eu. In rhoncus mauris eu nibh fringilla semper. Maecenas a laoreet magna. In vel orci vel quam tempus semper eget id nibh. Pellentesque sem dolor, euismod at arcu convallis, egestas auctor est. Praesent faucibus malesuada diam. Aenean bibendum dolor eros, id accumsan orci congue eget. Cras vulputate nulla lorem. Vivamus at massa vitae nisi dictum suscipit. \n Donec consectetur quam nec ligula cursus laoreet. Nulla sed neque suscipit turpis pellentesque semper. In ut eros tincidunt, sagittis diam eu, finibus purus. Mauris at magna at est porta tincidunt in at leo. Sed ultricies et turpis at semper. Nam lobortis, ipsum sit amet pulvinar suscipit, purus massa ornare diam, dignissim finibus quam metus vitae nunc. Fusce sit amet pharetra enim. Duis gravida volutpat risus ut facilisis. Nullam vel lectus eget velit accumsan scelerisque at non lacus. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Mauris dignissim neque sed tellus ultrices convallis. Maecenas et fermentum augue, id tempor diam. Etiam sit amet pretium augue. Proin in metus at mauris tempus lobortis eu sed odio. Fusce augue orci, gravida eget sodales tincidunt, consectetur sed lectus."


struct ContentView: View {
    // The current height of the view
    @State var selectedWord: String = ""
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            TappableText(selectedWord: $selectedWord, text: exampleText)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .font(.system(size: 22))
            .padding()
            .edgesIgnoringSafeArea(.bottom)
    }
}
