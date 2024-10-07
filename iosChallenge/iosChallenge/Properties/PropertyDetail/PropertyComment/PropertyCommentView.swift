//
//  PropertyCommentView.swift
//  iosChallenge
//
//  Created by Sergio Lopez Rosado on 7/10/24.
//

import SwiftUI

struct PropertyCommentView: View {
    @State private var selectedLanguage = "es"
    @State private var translatedText = ""
    @State private var isExpanded = false
    let comment: String
    let languages = ["es": "Español", "en": "Inglés", "fr": "Francés", "de": "Alemán"]
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ScrollView {
            Spacer()
            VStack {
                Text("Comment Language")
                    .font(.headline)
                    .padding()

                VStack(alignment: .leading, spacing: 0) {
                    HStack {
                        Text(languages[selectedLanguage]!)
                            .foregroundColor(.black)
                        Spacer()
                        Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                            .foregroundColor(.black)
                    }
                    .padding()
                    .background(Color.white)
                    .border(Color.gray.opacity(0.5), width: 1)
                    .border(Color.gray.opacity(0.5), width: 1, edges: [.top])
                    .onTapGesture {
                        withAnimation {
                            isExpanded.toggle()
                        }
                    }

                    if isExpanded {
                        ForEach(languages.keys.sorted(), id: \.self) { key in
                            HStack {
                                Text(languages[key]!)
                                    .foregroundColor(selectedLanguage == key ? Color("pinkIdealista") : .black)
                                Spacer()
                            }
                            .padding()
                            .background(Color.white)
                            .border(Color.gray.opacity(0.5), width: 1, edges: key == languages.keys.sorted().last ? [.bottom, .leading, .trailing] : [.leading, .trailing])
                            .frame(maxWidth: .infinity)
                            .onTapGesture {
                                selectedLanguage = key
                                withAnimation {
                                    isExpanded = false
                                }
                            }
                        }
                    }
                }
                .padding()

                Text("Translations may not be 100% accurate.")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding()

                Text(translatedText.isEmpty ? self.comment : translatedText)
                    .padding()

                Spacer()

                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Back to ad")
                        .font(.headline)
                        .foregroundColor(Color("pinkIdealista"))
                        .padding()
                        .background(Color.clear)
                        .border(Color("pinkIdealista"), width: 1)
                }
                .padding(.bottom)
            }
            .onChange(of: selectedLanguage) { newLanguage in
                if newLanguage == "es" {
                    translatedText = self.comment
                } else {
                    translateText(text: self.comment, to: newLanguage)
                }
            }
        }
    }

    func translateText(text: String, to language: String) {
        // Llamada a la API de Google Translator
        // Actualizar translatedText con el resultado de la traducción
    }
}

extension View {
    func border(_ color: Color, width: CGFloat, edges: [Edge] = [.top, .bottom, .leading, .trailing]) -> some View {
        overlay(EdgeBorder(width: width, edges: edges).foregroundColor(color))
    }
}

struct EdgeBorder: Shape {
    var width: CGFloat
    var edges: [Edge]

    func path(in rect: CGRect) -> Path {
        var path = Path()

        for edge in edges {
            var x: CGFloat { edge == .trailing ? rect.maxX - width / 2 : rect.minX + width / 2 }
            var y: CGFloat { edge == .bottom ? rect.maxY - width / 2 : rect.minY + width / 2 }
            var w: CGFloat { edge == .leading || edge == .trailing ? width : rect.width }
            var h: CGFloat { edge == .top || edge == .bottom ? width : rect.height }

            path.addPath(Path(CGRect(x: x, y: y, width: w, height: h)))
        }

        return path
    }
}

#Preview {
    PropertyCommentView(comment: "Hola que tal?")
}
