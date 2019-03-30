//
//  SoftwareProduct.swift
//  MasKit
//
//  Created by Ben Chatelain on 12/27/18.
//  Copyright © 2018 mas-cli. All rights reserved.
//

import Foundation

/// Protocol describing the members of CKSoftwareProduct used throughout MasKit.
public protocol SoftwareProduct {
    var accountIdentifier: String { get }
    var accountOpaqueDSID: String { get }

    /// Display name of app.
    /// Empty string on 10.14.4 (see #226).
    var appName: String { get }
    var bundleIdentifier: String { get set }
    var bundlePath: String { get set }
    var bundleVersion: String { get set }
    var description: String { get }
    var expectedBundleVersion: String? { get set }
    var expectedStoreVersion: NSNumber? { get set }
    var mdItemRef: NSValue? { get set }
    var installed: Bool { get set }
    var isLegacyApp: Bool { get set }
    var isMachineLicensed: Bool { get set }

    /// zero (or nil) for macOS installers
    var itemIdentifier: NSNumber { get set }

    /// Not populated for macOS installers.
    var purchaseDate: Date? { get set }
    var storeFrontIdentifier: NSNumber? { get set }
}

extension SoftwareProduct {
    /// Determines whether this product is a macOS installer.
    var isMacosInstaller: Bool {
        return appName.starts(with: "Install macOS") || appName.starts(with: "Install OS X")
    }
}
