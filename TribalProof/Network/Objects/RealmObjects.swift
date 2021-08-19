//
//  RealmObjects.swift
//  TribalWorldWideMitch
//
//  Created by Mitch Samaniego on 24/07/21.
//

import Foundation
import RealmSwift

class PhotoDB: Object {
    @objc dynamic var urls: NSData? = nil
    @objc dynamic var altDescription: String = ""
    @objc dynamic var profileImage: NSData? = nil
    @objc dynamic var id: String = ""
}
