//
//  OneDSApp.swift
//  OneDS
//
//  Created by Vineet Choudhary on 18/03/24.
//

import SwiftUI

@main
struct OneDSApp: App {
	@NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
			MainView()
				.navigationTitle("Disable Display Sleep")
				.frame(minWidth: 650, idealWidth: 650, maxWidth: 650, minHeight: 350, idealHeight: 350, maxHeight: 350)
        }
    }
}
