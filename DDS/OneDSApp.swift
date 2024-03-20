//
//  OneDSApp.swift
//  OneDS
//
//  Created by Vineet Choudhary on 18/03/24.
//

import SwiftUI

@main
struct OneDSApp: App {
	private struct LayoutConstants {
		static let defaultWidth: CGFloat = 650.0
		static let defaultHeight: CGFloat = 350.0
	}

	@NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
		rootView()
    }

	private func rootView() -> some Scene {
		WindowGroup {
			MainView()
				.frame(
					minWidth: LayoutConstants.defaultWidth,
					idealWidth: LayoutConstants.defaultWidth,
					minHeight: LayoutConstants.defaultHeight,
					idealHeight: LayoutConstants.defaultHeight)
		}
		.defaultSize(width: LayoutConstants.defaultWidth, height: LayoutConstants.defaultHeight)
	}
}
