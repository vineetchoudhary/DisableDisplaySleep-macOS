//
//  ContentView.swift
//  OneDS
//
//  Created by Vineet Choudhary on 18/03/24.
//

import SwiftUI

struct MainView: View {
	@ObservedObject var model = MainViewModel()

    var body: some View {
		mainView()
    }

	func mainView() -> some View {
		VStack(alignment: .center, spacing: 5) {
			Spacer()
			HStack(alignment: .center, spacing: .zero) {
				Text("Disable Display Sleep: ")
				Image(systemName: model.sleepDisabled ? "checkmark.circle" : "x.circle")
					.foregroundStyle(model.sleepDisabled ? .green : .red)
			}
			.font(.title)
			if model.sleepDisabled {
				Text("Quit application to enable display sleep again.")
			} else {
				Text("Something wrong. Please try again.")
				Text("Application is not able to disable display sleep.")
			}
			Spacer()
			Toggle("Launch at login", isOn: .init(get: { model.launchAtLogin }, set: { model.launchAtLogin = $0 }))
		}
		.font(.title3)
		.onAppear { model.disableSleep() }
		.padding()
	}
}
