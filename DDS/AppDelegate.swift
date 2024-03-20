//
//  AppDelegate.swift
//  OneDS
//
//  Created by Vineet Choudhary on 18/03/24.
//

import Foundation
import AppKit

class AppDelegate: NSObject, NSApplicationDelegate {
	func applicationDidFinishLaunching(_ notification: Notification) {
		let requiredAppMenus = ["DDS"]
		NSApp.mainMenu?.items.removeAll { !requiredAppMenus.contains($0.title) }
	}

	func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
		true
	}
}
