//
//  HeaderView.swift
//  iosChallenge
//
//  Created by Sergio Lopez Rosado on 3/10/24.
//

import SwiftUI

struct HeaderView: View {
    var showBackButton: Bool
    var onBackButtonPressed: (() -> Void)?
    
    var body: some View {
        VStack {
            HStack {
                if showBackButton {
                    Button(action: {
                        onBackButtonPressed?()
                    }) {
                        Image(systemName: "chevron.backward")
                            .foregroundColor(.black)
                    }
                    .padding(.leading, 16)
                }
                Spacer()
                Image("idealistaLong")
                    .resizable()
                    .frame(width: 217, height: 40)
                Spacer()
                if showBackButton {
                    Spacer()
                }
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
    HeaderView(showBackButton: true)
}
