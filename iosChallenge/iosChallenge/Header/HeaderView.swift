//
//  HeaderView.swift
//  iosChallenge
//
//  Created by Sergio Lopez Rosado on 3/10/24.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Image("idealistaLong")
                    .resizable()
                    .frame(width: 217, height: 40)
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
