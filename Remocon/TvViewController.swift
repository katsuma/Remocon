//
//  TvViewController.swift
//  Remocon
//
//  Created by Ryo Katsuma on 2015/05/23.
//  Copyright (c) 2015年 Ryo Katsuma. All rights reserved.
//

import UIKit

class TvViewController: UIViewController {

    // MARK: - Properties -
    lazy fileprivate var tvView: TvView = self.createTvView()
    lazy fileprivate var signal: IremoconSignal = self.createIremoconSignal()

    private var isHiddenHomeIndicator: Bool = true

    // MARK: - Life cycle events -
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initGradientBackground()
        self.view.addSubview(tvView)
        self.initNavigationItem()
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
        let topColor: UIColor = UIColor(red:0.949, green:0.737, blue:0.612, alpha:1)
        let bottomColor: UIColor = UIColor(red:0.239, green:0.286, blue:0.49, alpha:1)
        let gradientColors: [CGColor] = [topColor.cgColor, bottomColor.cgColor]
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        gradientLayer.frame = self.view.bounds
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }

    fileprivate func initNavigationItem() {
        self.navigationController!.navigationBar.isHidden = false
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
        let connectionStatus = Reach().connectionStatus()
        switch connectionStatus {
            case .unknown, .offline:
                showConnectionAlert()
            case .online(.wwan):
                showConnectionAlert()
            case .online(.wiFi):
                break
        }
    }

    fileprivate func showConnectionAlert() {
        let alertController: UIAlertController = UIAlertController(title: "iRemocon", message: "Cannot connect to iRemocon", preferredStyle: .alert)
        let okAction: UIAlertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }

    @available(iOS 11, *)
    override var prefersHomeIndicatorAutoHidden: Bool {
        return isHiddenHomeIndicator
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
