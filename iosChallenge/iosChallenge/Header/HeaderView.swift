//
//  HeaderView.swift
//  iosChallenge
//
//  Created by Sergio Lopez Rosado on 3/10/24.
//

import SwiftUI

struct HeaderView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var showSettings = false
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Image("idealistaLong")
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 217, height: 40)
                    .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                
                Spacer()
            }
            .padding()
            .background(Color.greenIdealista)
            
            if UIDevice.current.userInterfaceIdiom == .pad {
                Spacer()
            }
        }
    }
}

#Preview {
    HeaderView()
}
