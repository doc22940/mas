//
//  SSPurchase.swift
//  mas-cli
//
//  Created by Andrew Naylor on 25/08/2015.
//  Copyright (c) 2015 Andrew Naylor. All rights reserved.
//

import CommerceKit
import StoreFoundation

typealias SSPurchaseCompletion =
    (_ purchase: SSPurchase?, _ completed: Bool, _ error: Error?, _ response: SSPurchaseResponse?) -> Void

// MARK: - StoreFoundation.SSPurchase
extension SSPurchase {
    /// Initializes a purchase for the given app ID. This is only to trigger the download of an already purchased app.
    ///
    /// - Parameters:
    ///   - appId: App ID, passed as `itemIdentifier`, the `salableAdamId` query parameter of `buyParameters` string

    ///   - account: Store account.
    convenience init(appId: UInt64, account: ISStoreAccount) {
        self.init()

        buyParameters =
            "productType=C&price=0&salableAdamId=\(appId)&pricingParameters=STDRDL&pg=default&appExtVrsId=0"
        itemIdentifier = appId
        accountIdentifier = account.dsID
        appleID = account.identifier

        let downloadMetadata = SSDownloadMetadata()
        downloadMetadata.kind = "software"
        downloadMetadata.itemIdentifier = appId

        self.downloadMetadata = downloadMetadata
    }

    /// Performs the app purchase and download.
    ///
    /// - Parameter completion: Closure which is passed info about the transaction.
    ///
    /// - Note: Use `CKDownloadQueueObserver` to monitor any download that is started from calling this method.
    func perform(_ completion: @escaping SSPurchaseCompletion) {
        CKPurchaseController.shared().perform(self, withOptions: 0, completionHandler: completion)
    }
}
