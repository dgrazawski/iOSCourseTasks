//
//  ContentView.swift
//  state_management_6
//
//  Created by Dawid Grazawski on 14/08/2025.
//

import SwiftUI

struct SettingModel: Identifiable {
    let id = UUID()
    let settingName: String
    var settingState: Bool
}

struct ContentView: View {
    @State private var settingsList = [
        SettingModel(settingName: "Dark mode", settingState: false),
        SettingModel(settingName: "Wifi", settingState: true),
        SettingModel(settingName: "Hotspot", settingState: false),
        SettingModel(settingName: "Airplane mode", settingState: false),
        SettingModel(settingName: "Bluetooth", settingState: true),
        SettingModel(settingName: "Lock rotation", settingState: true)
    ]
    var body: some View {
        List($settingsList) { $setting in
            HStack {
                Text(setting.settingName)
                Spacer()
                Toggle("Is on", isOn: $setting.settingState)
                    .labelsHidden()
            }
            
        }
        .navigationTitle("Settings")
    }
}

#Preview {
    NavigationStack {
        ContentView()
    }
}
