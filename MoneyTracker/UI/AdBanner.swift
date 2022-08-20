//
//  AdBanner.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 20.08.2022.
//

import GoogleMobileAds
import SwiftUI
import UIKit

final class AdBanner: UIViewControllerRepresentable {
    private let onError: () -> ()
    
    init(onError: @escaping () -> ()) {
       self.onError = onError
   }
    
    func makeUIViewController(context: Context) -> AdBannerViewController {
        let viewContoller = AdBannerViewController(onError: onError)
        return viewContoller
    }
    
    func updateUIViewController(_ uiViewController: AdBannerViewController, context: Context) {
        
    }
}

final class AdBannerViewController: UIViewController, GADBannerViewDelegate {
    private var adUnitID: String = "ca-app-pub-8334416213766495/4179109818" // test: "ca-app-pub-3940256099942544/2934735716"
    private var bannerView: GADBannerView!
    private var onError: () -> ()
    
    init(onError: @escaping () -> ()) {
        self.onError = onError
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
        onError()
    }
    
    func bannerViewWillPresentScreen(_ bannerView: GADBannerView) {
        
    }
}
