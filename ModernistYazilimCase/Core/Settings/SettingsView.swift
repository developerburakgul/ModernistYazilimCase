//
//  UsersView.swift
//  ModernistYazilimCase
//
//  Created by Burak Gül on 6.07.2025.
//

import SwiftUI

struct SettingsView: View {
    @StateObject var viewModel: SettingsViewModel
    @EnvironmentObject var container: DependencyContainer
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            mainContent
                .task{
                    await viewModel.loadData()
                }
                .navigationTitle(TextKey.settingsTitle.stringValue.capitalized)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title2)
                            .foregroundStyle(UIColor.red.toColor)
                    }

                }
                
        }
    }
    
    @ViewBuilder
    private var mainContent: some View {
        switch viewModel.state {
        case .idle:
            Color.clear
        case .loading:
            ProgressView()
        case .failed(let userError):
            ErrorView(model: userError)
        case .loaded( _):
            contentView()
        }
    }
    
    func contentView() -> some View {
        Form {
            Section(TextKey.appSettings.stringValue.capitalized) {
                language()
            }
        }
        
    }
    
    private func language() -> some View {
        HStack(spacing: 12) {
            Image(systemName: "globe")
                .foregroundStyle(.blue)
                .frame(width: 24)
            Text(TextKey.language.stringValue.capitalized)
            Spacer()
            Menu {
                Picker("", selection: $viewModel.selectedLanguage) {
                    ForEach(viewModel.allLanguages) { language in
                        Text(language.languageModel.name)
                            .tag(language)
                    }
                }
                .onChange(of: viewModel.selectedLanguage) { oldValue, newValue in
                    if newValue != oldValue {
                        viewModel.changeLanguage(newValue)
                    }
                }
            } label: {
                Text(viewModel.selectedLanguage.languageModel.name)
                    .foregroundStyle(UIColor.label.toColor)
            }
        }
        
    }
}

#Preview {
    let container = DevPreview.shared.container
    let viewModelFactory = ViewModelFactory(container: container)
    SettingsView(
        viewModel: viewModelFactory.makeSettingsViewModel()
    )
    .previewEnvironment()
}
