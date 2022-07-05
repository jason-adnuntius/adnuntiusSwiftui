//
//  AdnuntiusRepresentable.swift
//  AddSwiftui
//
//  Created by Alexander Larsen on 05/07/2022.
//

import AdnuntiusSDK
import Foundation
import SwiftUI

struct AdnuntiusRepresentable: UIViewRepresentable {
    private let adnuntiusAdWebView = AdnuntiusAdWebView()
    private var coordinator = AdnuntiusCoordinator()

    @Binding var width: CGFloat
    @Binding var height: CGFloat

    public var auId: String

    init(auId: String, width: Binding<CGFloat>, height: Binding<CGFloat>) {
        self.auId = auId
        _width = width
        _height = height
    }

    func makeUIView(context: Context) -> AdnuntiusAdWebView {
        if adnuntiusAdWebView.loadAd(getRequest(), completionHandler: coordinator, adnSdkHandler: coordinator) == false {}

        return adnuntiusAdWebView
    }

    func updateUIView(_ uiView: AdnuntiusAdWebView, context: Context) {}

    func makeCoordinator() -> AdnuntiusCoordinator {
        coordinator.parent = self
        return coordinator
    }

    func getRequest() -> AdRequest {
        let adRequest = AdRequest(auId)
        adRequest.kv = ["version": ["6s"]]
        adRequest.useCookies = false
        return adRequest
    }
}

class AdnuntiusCoordinator: NSObject, AdLoadCompletionHandler, AdnSdkHandler {
    var parent: AdnuntiusRepresentable?
    func onNoAdResponse(_ view: AdnuntiusAdWebView) {
        print("onNoAdResponse:")
    }

    func onFailure(_ view: AdnuntiusAdWebView, _ message: String) {
        print("onFailure: \(message)")
    }

    func onAdResponse(_ view: AdnuntiusAdWebView, _ width: Int, _ height: Int) {
        print("onAdResponse: width: \(width), height: \(height)")
        parent?.width = CGFloat(width)
        parent?.height = CGFloat(height)
    }

    func onClose(_ view: AdnuntiusAdWebView) {
        print("onClose:")
    }
}
