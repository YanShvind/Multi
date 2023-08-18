
import SwiftUI

struct DetailSwiftUIView: View {
    @State var character: Character
    @State var location: Location
    @State var episodeData: [Episode]
    
    var body: some View {
        ScrollView {
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
                        .padding(.bottom, 10)
                    
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
                
                VStack(alignment: .leading) {
                    Text("Origin")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(.init(top: 10, leading: 0, bottom: 10, trailing: 0))
                    
                    HStack {
                        ZStack {
                            Color(hex: "#191C2A").frame(width: 64, height: 64)
                            Image("Planet")
                                .resizable()
                                .frame(width: 22, height: 22)
                        }
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(10)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text(location.name)
                                .font(.system(size: 17, weight: .bold))
                                .foregroundColor(.white)
                            Text(location.type)
                                .font(.system(size: 13))
                                .foregroundColor(.green)
                        }
                        .padding(.leading, 9)
                        .foregroundColor(.white)
                        Spacer()
                    }
                    .padding(8)
                    .frame(maxWidth: .infinity)
                    .background(Color(hex: "#262A38"))
                    .cornerRadius(16)
                }
                
                VStack(alignment: .leading) {
                    Text("Episodes")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(.init(top: 10, leading: 0, bottom: 10, trailing: 0))
                    
                    ForEach(character.episode.indices, id: \.self) { index in
                        VStack(alignment: .leading) {
                            Text(episodeData[index].name)
                                .font(.system(size: 17))
                                .foregroundColor(.white)
                            
                            HStack() {
                                Text(formatCode(episodeData[index].episodeCode))
                                    .font(.system(size: 13))
                                    .foregroundColor(.green)
                                Spacer()
                                Text(episodeData[index].airDate)
                                    .font(.system(size: 13))
                                    .foregroundColor(Color(hex: "#93989C"))
                            }
                            .padding(.init(top: 9, leading: 0, bottom: 3, trailing: 0))
                            .foregroundColor(.white)
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(hex: "#262A38"))
                        .cornerRadius(16)
                    }
                }
                Spacer()
            }
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(hex: "#040C1E"))
    }
    
    private func formatCode(_ code: String) -> String {
        let components = code.components(separatedBy: "E")
        let episode = components[1]
        let trimmedEpisode = episode.trimmingCharacters(in: CharacterSet(charactersIn: "0"))
        let season = components[0].replacingOccurrences(of: "S", with: "")
        let trimmedSeason = season.trimmingCharacters(in: CharacterSet(charactersIn: "0"))
        return "Episode: \(trimmedEpisode), Season: \(trimmedSeason)"
    }
}

struct DetailSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        DetailSwiftUIView(character: Character(id: 0, name: "", status: "", species: "", type: "", gender: "", origin: Origin.init(name: "", url: ""), location: Origin(name: "", url: ""), image: "", episode: [""], url: "", created: ""), location: Location(id: 1, name: "", type: "", dimension: "", residents: [""]), episodeData: [Episode(id: 1, name: "", airDate: "", episodeCode: "", characters: [""], url: "", created: "")])
    }
}
