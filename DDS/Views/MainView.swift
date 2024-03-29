//
//  ContentView.swift
//  OneDS
//
//  Created by Vineet Choudhary on 18/03/24.
//

import SwiftUI

struct MainView: View {
	struct LayoutConstants {
		static let defaultSpacing: CGFloat = 5.0
	}
	
	@ObservedObject var model = MainViewModel()

    var body: some View {
		mainView()
			.navigationTitle("Disable Display Sleep")
    }

	func mainView() -> some View {
		VStack(alignment: .center, spacing: LayoutConstants.defaultSpacing) {
			Spacer()
			displaySleepStatusView()
			displaySleepHelpView()
			Spacer()
			launchAtLoginView()
		}
		.onAppear { model.disableDisplaySleep(); }
		.padding()
	}

	private func displaySleepStatusView() -> some View {
		HStack(alignment: .center, spacing: LayoutConstants.defaultSpacing) {
			Text("Disable Display Sleep:")
			Image(systemName: model.sleepDisabled ? "checkmark.circle" : "x.circle")
				.foregroundStyle(model.sleepDisabled ? .green : .red)
		}
		.font(.largeTitle)
	}

	@ViewBuilder
	private func displaySleepHelpView() -> some View {
		if model.sleepDisabled {
			Text("Quit the application to enable display sleep again.")
				.font(.title3)
		} else {
			VStack(alignment: .center, spacing: LayoutConstants.defaultSpacing) {
				Text("Something went wrong. Please restart the application.")
				Text("The application is not able to disable display sleep.")
			}
			.font(.title3)
		}
	}

	@ViewBuilder
	private func launchAtLoginView() -> some View {
		if model.launchAtLoginStatus == .notFound {
			VStack(alignment: .center, spacing: LayoutConstants.defaultSpacing) {
				Text("Add 'DDS.app' to your Login Items to launch at login.")
				(Text("Click here to open Login Items")
					.underline() +
				Text(" and configure 'DDS.app' to launch automatically at login."))
			}
			.font(.title3)
			.onTapGesture { model.openSystemSettingsLoginItems() }
		} else {
			Toggle("Launch at login", isOn: .init(
				get: { model.launchAtLoginStatus == .enabled },
				set: { model.launchAtLogin($0) }))
			.font(.title3)
		}
	}
}
