
import SwiftUI

struct DetailSwiftUIView: View {
    @State var character: Character
    
    var body: some View {
        VStack {
            // Ваш контент здесь
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(hex: "#040C1E"))
    }
}

struct DetailSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        DetailSwiftUIView(character: Character(id: 0, name: "", status: "", species: "", type: "", gender: "", origin: Location.init(name: "", url: ""), location: Location(name: "", url: ""), image: "", episode: [""], url: "", created: ""))
    }
}
