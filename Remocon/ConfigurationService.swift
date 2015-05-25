//
//  ConfigurationService.swift
//  Remocon
//
//  Created by Ryo Katsuma on 2015/05/24.
//  Copyright (c) 2015年 Ryo Katsuma. All rights reserved.
//

import Foundation

class ConfigurationService {
    static let buttons: [Dictionary<String, String>] = [
        ["label": "1", "channel": "1201"],
        ["label": "2", "channel": "1202"],
        ["label": "3", "channel": "1203"],
        ["label": "4", "channel": "1204"],
        ["label": "5", "channel": "1205"],
        ["label": "6", "channel": "1206"],
        ["label": "7", "channel": "1207"],
        ["label": "8", "channel": "1208"],
        ["label": "9", "channel": "1209"],
        ["label": "volumedown", "channel": "1252"],
        ["label": "power", "channel": "11"],
        ["label": "volumeup", "channel": "1251"],
    ]

    static let iRemocon: Dictionary<String, String> = [
        "address": "192.168.0.3",
        "port": "51013"
    ]
}