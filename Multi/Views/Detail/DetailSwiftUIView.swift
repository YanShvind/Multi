
import SwiftUI

struct DetailSwiftUIView: View {
    @State var character: Character

    var body: some View {
        VStack(alignment: .center) {
            AsyncImage(url: URL(string: character.image)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
                    .cornerRadius(16)
            } placeholder: {
                ProgressView()
                    .frame(width: 200, height: 200)
                    .cornerRadius(16)
            }

            Text(character.name)
                .font(.title)
                .foregroundColor(.white)
                .padding(.top, 10)

            Text(character.status)
                .font(.headline)
                .foregroundColor(.green)
                .padding(.bottom)
                .padding(.top, -10)
            
            VStack(alignment: .leading) {
                Text("Info")
                    .font(.headline)
                    .foregroundColor(.white)

                HStack {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Species:")
                        Text("Type:")
                        Text("Gender:")
                    }
                    .foregroundColor(Color(hex: "#C4C9CE"))
                    Spacer()
                    VStack(alignment: .leading, spacing: 16) {
                        Text(character.species != "" ? character.species : "None")
                        Text(character.type != "" ? character.type : "None")
                        Text(character.gender != "" ? character.gender : "None")
                    }
                    .foregroundColor(.white)
                }
                .padding()
                .background(Color(hex: "#262A38"))
                .cornerRadius(16)
            }
            .padding()
            Spacer()
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
