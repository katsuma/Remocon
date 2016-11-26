//
//  IremoconSignal.swift
//  Remocon
//
//  Created by Ryo Katsuma on 2015/05/30.
//  Copyright (c) 2015年 Ryo Katsuma. All rights reserved.
//

import UIKit

final class IremoconSignal {
    lazy fileprivate var client: TCPClient = self.createTCPClient()

    static let sharedInstance = IremoconSignal()

    fileprivate init() { }

    fileprivate func createTCPClient() -> TCPClient {
        let addr: String = ConfigurationService.iRemocon["address"]!
        let port: String = ConfigurationService.iRemocon["port"]!

        print("CreateTCP Client by \(addr):\(port)")
        return TCPClient(addr: addr, port: Int(port)!)
    }

    internal func updateTCPClient() {
        client = createTCPClient()
    }

    internal func send(_ channel: Int) {
        _ = client.connect(timeout: 10)
        _ = client.send(str: "*is;\(channel)\r\n")
        _ = client.close()
    }
}
