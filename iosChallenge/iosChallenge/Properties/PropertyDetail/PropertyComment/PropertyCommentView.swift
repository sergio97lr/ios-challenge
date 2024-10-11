//
//  PropertyCommentView.swift
//  iosChallenge
//
//  Created by Sergio Lopez Rosado on 7/10/24.
//

import SwiftUI

struct PropertyCommentView: View {
    let comment: String
    
    var body: some View {
        ScrollView {
            Spacer()
            VStack {
                Text(Constants.LocalizableKeys.Home.advertiserComment)
                    .font(.headline)
                    .padding()
                
                Text(comment)
                    .padding()
                
                Spacer()
            }
        }
    }
}

#Preview {
    PropertyCommentView(comment: "")
}

