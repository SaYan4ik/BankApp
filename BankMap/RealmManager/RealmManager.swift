//
//  RealmManager.swift
//  BankMap
//
//  Created by Александр Янчик on 24.01.23.
//

import Foundation
import RealmSwift


class RealmManager<T> where T: Object {
    private let realm = try! Realm()
    
    func write(object: T) {
        try? realm.write {
            realm.add(object)
        }
    }
    
    func read() -> [T] {
        return Array(realm.objects(T.self))
    }
}

