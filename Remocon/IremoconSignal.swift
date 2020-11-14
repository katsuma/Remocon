//
//  IremoconSignal.swift
//  Remocon
//
//  Created by Ryo Katsuma on 2015/05/30.
//  Copyright (c) 2015年 Ryo Katsuma. All rights reserved.
//

import UIKit
import SwiftSocket

final class IremoconSignal {
    lazy fileprivate var client: TCPClient = self.createTCPClient()

    static let sharedInstance = IremoconSignal()

    fileprivate init() { }

    fileprivate func createTCPClient() -> TCPClient {
        let addr: String = ConfigurationService.iRemocon["address"]!
        let port: String = ConfigurationService.iRemocon["port"]!

        return TCPClient(address: addr, port: Int32(port)!)
    }

    internal func updateTCPClient() {
        client = createTCPClient()
    }

    internal func send(_ channel: Int) {
        _ = client.connect(timeout: 10)
        _ = client.send(string: "*is;\(channel)\r\n")
        client.close()
    }
}
