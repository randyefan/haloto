//
//  Channel.swift
//  Haloto
//
//  Created by Randy Efan Jayaputra on 10/11/21.
//

import FirebaseFirestore

struct Channel {
    let id: String?
    let name: String
    var sentDate: Date
    
    
    init(name: String) {
        id = nil
        self.name = name
        self.sentDate = Date()
    }
    
    init?(document: QueryDocumentSnapshot) {
        let data = document.data()
        
        guard let name = data["name"] as? String,  let sentDate = data["created"] as? Timestamp else {
            return nil
        }
        
        id = document.documentID
        self.sentDate = sentDate.dateValue()
        self.name = name
    }
}

// MARK: - DatabaseRepresentation
extension Channel: DatabaseRepresentation {
    var representation: [String: Any] {
        var rep: [String: Any] = ["name": name]
        
        if let id = id {
            rep["id"] = id
        }
        
        rep["created"] = sentDate
        
        return rep
    }
}

// MARK: - Comparable
extension Channel: Comparable {
    static func == (lhs: Channel, rhs: Channel) -> Bool {
        return lhs.id == rhs.id
    }
    
    static func < (lhs: Channel, rhs: Channel) -> Bool {
        return lhs.sentDate < rhs.sentDate
    }
}

