//
//  Task.swift
//  TodoList
//
//  Created by Pawel Kacela on 11/02/2026.
//

import Foundation

public struct Task: Identifiable, Equatable, Codable {
    public var id: UUID = .init()
    public var name: String
    public var dateCreated: Date
}
