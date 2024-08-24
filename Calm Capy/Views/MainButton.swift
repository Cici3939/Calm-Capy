import SwiftUI

struct MainButton<Destination: View>: View {
    let title: String
    let background: Color
    let textColor: Color
    let imageName: String
    let newView: Destination
    
    var body: some View {
        NavigationLink(destination: newView) {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(background)
                
                HStack {
                    Image(imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity, alignment: .leading)

                    Text(title)
                        .foregroundColor(textColor)
                        .font(.system(size: 25))
                        .bold()
                }
                .padding()
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    MainButton(
        title: "Value",
        background: Color("PrimaryColor"),
        textColor: .black,
        imageName: "ChatBot",
        newView: Text("MainView")
    )
}
