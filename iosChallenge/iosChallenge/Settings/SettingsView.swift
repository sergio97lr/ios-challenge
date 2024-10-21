//
//  SettingsView.swift
//  iosChallenge
//
//  Created by Sergio Lopez Rosado on 20/10/24.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    @AppStorage("selectedLanguage") var selectedLanguage = "system"
    @AppStorage("selectedTheme") var selectedTheme = "system"
    @State private var showLanguageAlert = false
    @State private var alertText = ""
    
    var body: some View {
        Group {
            if UIDevice.current.userInterfaceIdiom == .pad {
                NavigationView {
                    settingsForm
                        .navigationBarTitle(Text(Constants.LocalizableKeys.Settings.settings), displayMode: .inline)
                        .navigationBarItems(trailing: Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(systemName: "xmark")
                                .foregroundColor(.primary)
                        })
                }
                .navigationViewStyle(StackNavigationViewStyle())
            } else {
                NavigationView {
                    settingsForm
                        .navigationBarTitle(Text(Constants.LocalizableKeys.Settings.settings), displayMode: .inline)
                        .navigationBarItems(trailing: Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(systemName: "xmark")
                                .foregroundColor(.primary)
                        })
                }
            }
        }
        .onAppear {
            applyTheme(selectedTheme)
        }
        .onChange(of: selectedLanguage) { _ in
            showLanguageAlert = true
            alertText = selectedLanguage == "en" ? Constants.LocalizableKeys.Settings.english : Constants.LocalizableKeys.Settings.spanish
        }
        .onChange(of: selectedTheme) { _ in
            applyTheme(selectedTheme)
        }
        .alert(isPresented: $showLanguageAlert) {
            Alert(
                title: Text(Constants.LocalizableKeys.Others.languageChange),
                message: Text("\(Constants.LocalizableKeys.Others.languageChangeText) \(alertText)"),
                dismissButton: .default(Text("OK")) {
                    changeLanguage(to: selectedLanguage)
                }
            )
        }
    }
    
    var settingsForm: some View {
        Form {
            let favorites = CoreDataManager.shared.getAllFavorites()
            
            // MARK: Language
            Section(header: Text(Constants.LocalizableKeys.Settings.language)) {
                Picker("Select Language", selection: $selectedLanguage) {
                    ForEach(["system", "en", "es"], id: \.self) { language in
                        Text(languageDisplayName(for: language))
                            .padding()
                            .background(selectedLanguage == language ? Color.greenIdealista : Color.clear)
                            .foregroundColor(selectedLanguage == language ? Color.pinkIdealista : Color.primary)
                            .cornerRadius(8)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            // MARK: Theme
            Section(header: Text(Constants.LocalizableKeys.Settings.theme)) {
                Picker("Select Theme", selection: $selectedTheme) {
                    ForEach(["system", "light", "dark"], id: \.self) { theme in
                        Text(themeDisplayName(for: theme))
                            .padding()
                            .background(selectedTheme == theme ? Color.greenIdealista : Color.clear)
                            .foregroundColor(selectedTheme == theme ? Color.pinkIdealista : Color.primary)
                            .cornerRadius(8)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            
            // MARK: Favorites
            if !favorites.isEmpty {
                Section(header: Text(Constants.LocalizableKeys.Settings.yourFavorites)) {
                    ForEach(favorites, id: \.self) { favorite in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(favorite.address ?? "")
                                    .font(.headline)
                                Text(favorite.district ?? "")
                                    .font(.subheadline)
                                Text("\(Utils.formatPrice(favorite.price) ?? "")\(favorite.currencySufix ?? "")")
                                    .font(.footnote)
                            }
                            Spacer()
                            Image("favIcon")
                        }
                        .padding(.vertical, 5)
                    }
                }
            }
        }
    }
    
    func changeLanguage(to language: String) {
        let languageCode: String
        switch language {
        case "en":
            languageCode = "en"
        case "es":
            languageCode = "es"
        default:
            languageCode = Locale.preferredLanguages.first ?? "es"
        }
        LocalizationManager.shared.setLanguage(languageCode: languageCode)
    }
    
    func applyTheme(_ selectedTheme: String) {
        let interfaceStyle: UIUserInterfaceStyle
        switch selectedTheme {
        case "light":
            interfaceStyle = .light
        case "dark":
            interfaceStyle = .dark
        default:
            interfaceStyle = .unspecified
        }
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            for window in windowScene.windows {
                window.overrideUserInterfaceStyle = interfaceStyle
            }
        }
    }
    
    func languageDisplayName(for language: String) -> String {
        switch language {
        case "system": return Constants.LocalizableKeys.Settings.defaultText
        case "en": return Constants.LocalizableKeys.Settings.english
        case "es": return Constants.LocalizableKeys.Settings.spanish
        default: return language
        }
    }
    
    func themeDisplayName(for theme: String) -> String {
        switch theme {
        case "system": return Constants.LocalizableKeys.Settings.defaultText
        case "light": return Constants.LocalizableKeys.Settings.light_theme
        case "dark": return Constants.LocalizableKeys.Settings.dark_theme
        default: return theme
        }
    }
}

#Preview {
    SettingsView()
}
