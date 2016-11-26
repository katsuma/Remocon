//
//  ConfigurationService.swift
//  Remocon
//
//  Created by Ryo Katsuma on 2015/05/24.
//  Copyright (c) 2015年 Ryo Katsuma. All rights reserved.
//

import Foundation
import RealmSwift

class ConfigurationService {
    static let inputModalChannel: Int = 1261
    fileprivate static let realm = try! Realm()

    static let channelButtons: [Dictionary<String, String>] = [
        ["label": "1", "channel": "1201"],
        ["label": "2", "channel": "1202"],
        ["label": "3", "channel": "1203"],
        ["label": "4", "channel": "1204"],
        ["label": "5", "channel": "1205"],
        ["label": "6", "channel": "1206"],
        ["label": "7", "channel": "1207"],
        ["label": "8", "channel": "1208"],
        ["label": "9", "channel": "1209"],
        ["label": "minus", "channel": "1272"], // 1252 is based on TV
        ["label": "power", "channel": "1241"],
        ["label": "plus", "channel": "1271"],  // 1251 is based on TV
    ]

    static let inputButton: Dictionary<String, String> = [
        "label": "Input", "channel": String(inputModalChannel)
    ]

    static let playPauseButton: Dictionary<String, String> = [
        "label": "playpause", "channel": "1270"
    ]

    static let controlButtons: [Dictionary<String, String>] = [
        ["label": "up",    "channel": "1262"],
        ["label": "down",  "channel": "1263"],
        ["label": "right",  "channel": "1264"],
        ["label": "left",  "channel": "1265"],
        ["label": " ",  "channel": "1266"],
        ["label": "menu",  "channel": "1267"],
    ]

    static var iRemocon: Dictionary<String, String> = [
        "address": loadRemoconAddress()!,
        "port": "51013"
    ]

    fileprivate static func loadRemoconAddress() -> String? {
        if let localSetting: LocalSetting = realm.objects(LocalSetting.self).last {
            return localSetting.remoconAddress;
        } else {
            let localSetting: LocalSetting = LocalSetting()
            try! realm.write {
                realm.add(localSetting)
            }
            return localSetting.remoconAddress;
        }
    }

    static func updateRemoconAddress(address: String) {
        if address == iRemocon["address"] {
            return
        }

        let localSetting: LocalSetting? = realm.objects(LocalSetting.self).last
        try! realm.write {
            localSetting?.remoconAddress = address
            iRemocon["address"] = address
            IremoconSignal.sharedInstance.updateTCPClient()
        }
    }
}
