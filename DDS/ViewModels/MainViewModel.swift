//
//  MainViewModel.swift
//  OneDS
//
//  Created by Vineet Choudhary on 18/03/24.
//

import Combine
import Foundation
import IOKit
import IOKit.pwr_mgt
import ServiceManagement

class MainViewModel: ObservableObject {
	@Published var sleepDisabled = false
	@Published var launchAtLoginStatus: SMAppService.Status = .notFound

	private var ioReturn: IOReturn?
	private var assertionID: IOPMAssertionID = 0
	private var subscriptions: Set<AnyCancellable> = .init()

	private let smAppService = SMAppService.mainApp
	
	init() {
		subscribeToSMAppServiceStatus()
	}
}

// MARK: - Enable/Disable display sleep
extension MainViewModel {
	func disableDisplaySleep() {
		Log.default.info("Disabling display sleep...")
		let reasonForActivity = "DDS Active" as CFString
		ioReturn = IOPMAssertionCreateWithName(
			kIOPMAssertionTypeNoDisplaySleep as CFString,
			IOPMAssertionLevel(kIOPMAssertionLevelOn),
			reasonForActivity,
			&assertionID)

		if ioReturn == kIOReturnSuccess {
			sleepDisabled = true
			Log.default.info("Successfully disabled display sleep.")
		} else {
			sleepDisabled = false
			Log.default.warning("Failed to disabled display sleep.")
		}
	}

	func enableDisplaySleep() {
		if ioReturn == kIOReturnSuccess {
			ioReturn = IOPMAssertionRelease(assertionID)
			sleepDisabled = false
			Log.default.info("Enabled display sleep.")
		}
	}
}

// MARK: - Launch at login
extension MainViewModel {
	func launchAtLogin(_ enable: Bool) {
		if enable {
			enableLaunchAtLogin()
		} else {
			disableLaunchAtLogin()
		}
		updateLauncAtLoginStatus()
	}

	func updateLauncAtLoginStatus() {
		launchAtLoginStatus = smAppService.status
	}

	func openSystemSettingsLoginItems() {
		SMAppService.openSystemSettingsLoginItems()
	}

	private func enableLaunchAtLogin() {
		if launchAtLoginStatus == .notRegistered {
			do {
				try smAppService.register()
			} catch {
				Log.default.error("Unable to register app for launch at login. \(error)")
			}
		}
	}

	private func disableLaunchAtLogin() {
		if launchAtLoginStatus == .enabled {
			do {
				try smAppService.unregister()
			} catch {
				Log.default.error("Unable to unregister app for launch at login. \(error)")
			}
		}
	}

	private func subscribeToSMAppServiceStatus() {
		smAppService.publisher(for: \.status, options: [.initial, .new])
			.sink { [weak self] status in
				guard let self else {
					return
				}

				launchAtLoginStatus = status
			}
			.store(in: &subscriptions)
	}
}
