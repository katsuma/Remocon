//
//  IremoconSignal.swift
//  Remocon
//
//  Created by Ryo Katsuma on 2015/05/30.
//  Copyright (c) 2015年 Ryo Katsuma. All rights reserved.
//

import UIKit

final class IremoconSignal {
    lazy private var client: TCPClient = self.createTCPClient()

    static let sharedInstance = IremoconSignal()

    private init() { }

    private func createTCPClient() -> TCPClient {
        var addr: String = ConfigurationService.iRemocon["address"]!
        var port: String = ConfigurationService.iRemocon["port"]!

        return TCPClient(addr: addr, port: port.toInt()!)
    }

    internal func send(channel: Int) {
        client.connect(timeout: 10)
        client.send(str: "*is;\(channel)\r\n")
        client.close()
    }
}
