//
//  MindMapNode.swift
//  MomotoMindmap
//
//  Created by Kezia Meilany Tandapai on 01/05/26.
//

import Foundation

struct MindMapNode: Identifiable, Codable, Hashable {
    let id: UUID;
    var title: String
    var summary: String?
    var children: [MindMapNode]
    var isExpanded: Bool
    
    init(id: UUID = UUID(), title: String = "", summary: String = "", children: [MindMapNode] = [], isExpanded: Bool = false) {
        self.id = id
        self.title = title
        self.summary = summary
        self.children = children
        self.isExpanded = isExpanded
    }
}
