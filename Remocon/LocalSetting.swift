//
//  LocalSetting.swift
//  Remocon
//
//  Created by Ryo Katsuma on 2016/11/26.
//  Copyright © 2016 Ryo Katsuma. All rights reserved.
//

import Foundation
import RealmSwift

class LocalSetting: Object {
    @objc dynamic var remoconAddress:String = "192.168.10.6";
}
