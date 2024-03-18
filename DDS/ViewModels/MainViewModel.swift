//
//  MainViewModel.swift
//  OneDS
//
//  Created by Vineet Choudhary on 18/03/24.
//

import Foundation
import IOKit
import IOKit.pwr_mgt
import ServiceManagement


class MainViewModel: ObservableObject {
	@Published var sleepDisabled = false
	@Published var launchAtLogin = false {
		willSet {
			if newValue {
				try? SMAppService.mainApp.register()
			} else {
				try? SMAppService.mainApp.unregister()
			}
		}
	}

	private var ioReturn: IOReturn?
	private var assertionID: IOPMAssertionID = 0

	func disableSleep() {
		print("disable sleep")
		let reasonForActivity = "OneDS working..." as CFString
		ioReturn = IOPMAssertionCreateWithName(
			kIOPMAssertionTypeNoDisplaySleep as CFString,
			IOPMAssertionLevel(kIOPMAssertionLevelOn),
			reasonForActivity,
			&assertionID)

		if ioReturn == kIOReturnSuccess {
			sleepDisabled = true
		} else {
			sleepDisabled = false
		}
	}

	func enableSleep() {
		print("enable sleep")
		if ioReturn == kIOReturnSuccess {
			ioReturn = IOPMAssertionRelease(assertionID)
			sleepDisabled = false
		}
	}
}
