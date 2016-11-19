//
//  TvViewController.swift
//  Remocon
//
//  Created by Ryo Katsuma on 2015/05/23.
//  Copyright (c) 2015年 Ryo Katsuma. All rights reserved.
//

import UIKit
import IJReachability

class TvViewController: UIViewController {

    // MARK: - Properties -
    lazy fileprivate var tvView: TvView = self.createTvView()
    lazy fileprivate var signal: IremoconSignal = self.createIremoconSignal()

    // MARK: - Life cycle events -
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initNavigationItem()
        self.initGradientBackground()
        self.view.addSubview(tvView)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.layoutTvView()

        self.tvView.delegate = self
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        self.checkConnectionReachability()
    }

    // MARK: - Create subviews -
    fileprivate func createTvView() -> TvView {
        return TvView(frame: .zero)
    }

    fileprivate func initGradientBackground() {
        let topColor: UIColor = UIColor(red:0.07, green:0.13, blue:0.26, alpha:1)
        let bottomColor: UIColor = UIColor(red:0.54, green:0.74, blue:0.74, alpha:1)
        let gradientColors: [CGColor] = [topColor.cgColor, bottomColor.cgColor]
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        gradientLayer.frame = self.view.bounds
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }

    fileprivate func initNavigationItem() {
        let navigationBar: UINavigationBar = self.navigationController!.navigationBar

        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.tintColor = .white
        navigationBar.barTintColor = .clear
        navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]

    }

    // MARK: - Layout subviews -
    fileprivate func layoutTvView() {
        tvView.frame.size = CGSize(width: 280, height: 450)
        tvView.center = self.view.center
    }

    fileprivate func createIremoconSignal() -> IremoconSignal {
        return IremoconSignal.sharedInstance
    }

    fileprivate func showInputModalView() {
        let inputControlViewController: UINavigationController = UINavigationController(rootViewController: InputControlViewController())
        inputControlViewController.modalTransitionStyle = .coverVertical
        inputControlViewController.modalPresentationStyle = .overFullScreen
        self.present(inputControlViewController, animated: true, completion: nil)
    }

    fileprivate func checkConnectionReachability() {
        if !IJReachability.isConnectedToNetwork() {
            showConnectionAlert()
            return
        }

        let statusType: IJReachabilityType = IJReachability.isConnectedToNetworkOfType()
        switch statusType {
        case .wwan:
            showConnectionAlert()
        case .notConnected:
            showConnectionAlert()
        case .wiFi:
            break
        }
    }

    fileprivate func showConnectionAlert() {
        let alertController: UIAlertController = UIAlertController(title: "iRemocon", message: "Cannot connect to iRemocon", preferredStyle: .alert)
        let okAction: UIAlertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }

}

extension TvViewController: TvViewDelegate {
    func buttonDidTap(_ channel: Int, sender: TvView) {
        print("buttonDidTap on TvView: \(channel)")
        signal.send(channel)

        if channel == ConfigurationService.inputModalChannel {
            showInputModalView()
        }
    }
}
