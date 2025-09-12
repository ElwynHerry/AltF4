import SwiftUI

struct CreditsView: View {
    var body: some View {
        VStack {
            Text("Crédits")
                .font(.largeTitle)
                .padding()
            Text("HERRY Elwyn")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .padding(.bottom, 20)
                .padding(.top, 200)
            Text("HERRY Mattéo")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .padding(.bottom, 20)
            Text("ALVARIZA Felipe")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .padding(.bottom, 20)
            
            Spacer()
        }
        .navigationTitle("Crédits")
    }
}
