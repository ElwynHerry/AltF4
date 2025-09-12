//
//  ContentView.swift
//  Alt+F4
//
//  Created by admin on 12/09/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            // 1. Logo en haut de la page
            Image("images.png") // Remplace "logo" par le nom de ton image dans Assets
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150) // Ajuste la taille du logo
                .padding(.top, 0) // Ajout d'un peu d'espace en haut
            
            // 2. Nom de l'application
            Text("ALT+F4") // Remplace avec le nom de ton app
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .padding(.bottom, 30)
            
            //Spacer() // Espace flexible pour pousser les boutons vers le bas
            
            // 3. Boutons (Jouer, Options, Crédits)
            VStack(spacing: 20) {
                Button(action: {
                    // Action pour Jouer (ex. naviguer vers une autre vue)
                    print("Jouer action")
                }) {
                    Text("Jouer")
                        .font(.title)
                        .fontWeight(.medium)
                        .frame(width: 250, height: 50)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .shadow(radius: 10)
                }
                
                Button(action: {
                    // Action pour Options
                    print("Options action")
                }) {
                    Text("Options")
                        .font(.title)
                        .fontWeight(.medium)
                        .frame(width: 250, height: 50)
                        .background(Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .shadow(radius: 10)
                }
                
                Button(action: {
                    // Action pour Crédits
                    print("Crédits action")
                }) {
                    Text("Crédits")
                        .font(.title)
                        .fontWeight(.medium)
                        .frame(width: 250, height: 50)
                        .background(Color.black)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .shadow(radius: 10)
                }
            }
            .padding(.bottom, 100) // Espace en bas avant les boutons
            
        }
        .background(Color.white) // Fond blanc de la page
        .edgesIgnoringSafeArea(.all) // Ignore les bords sécurisés
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

