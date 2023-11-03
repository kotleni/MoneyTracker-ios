//
//  AdBanner.swift
//  MoneyTracker
//
//  Created by Viktor Varenik on 20.08.2022.
//

import GoogleMobileAds
import SwiftUI
import UIKit

/// Admob banner bridge from UIKit to SwiftUI
final class AdBanner: UIViewControllerRepresentable {
    private let onUpdate: (_ isSuccess: Bool) -> Void // update handler
    
    init(onUpdate: @escaping (_ isSuccess: Bool) -> Void) {
        self.onUpdate = onUpdate
    }
    
    func makeUIViewController(context: Context) -> AdBannerViewController {
        let viewContoller = AdBannerViewController(onUpdate: onUpdate)
        return viewContoller
    }
    
    func updateUIViewController(_ uiViewController: AdBannerViewController, context: Context) { }
}

final class AdBannerViewController: UIViewController, GADBannerViewDelegate {
    private var adUnitID: String = Static.adUnitID    // banner id
    private var bannerView: GADBannerView!            // banner view
    private var onUpdate: (_ isSuccess: Bool) -> Void // update handler
    
    init(onUpdate: @escaping (_ isSuccess: Bool) -> Void) {
        self.onUpdate = onUpdate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        bannerView = GADBannerView(adSize: GADAdSizeFullBanner)
        view = bannerView
        
        bannerView.adUnitID = adUnitID
        bannerView.rootViewController = self
        bannerView.delegate = self
        bannerView.load(GADRequest())
    }
    
    func bannerView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: Error) {
        onUpdate(false)
    }
    
    func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
        onUpdate(true)
    }
    
    func bannerViewWillPresentScreen(_ bannerView: GADBannerView) {
        onUpdate(true)
    }
}
