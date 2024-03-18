//
//  Log.swift
//  DDS
//
//  Created by Vineet Choudhary on 18/03/24.
//

import Foundation
import OSLog

struct Log {
	private static let subsystem = Bundle.main.bundleIdentifier!
	static let `default` = Logger(subsystem: subsystem, category: "Default")
}
