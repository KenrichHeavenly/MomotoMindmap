//
//  MindMap.swift
//  MomotoMindmap
//
//  Created by Kezia Meilany Tandapai on 01/05/26.
//

import Foundation

struct MindMap: Identifiable, Codable, Hashable {
    let id: UUID;
    var title: String;
    var root: MindMapNode;
    var rawText: String;
    var createdAt: Date;
    
    init(id: UUID, title: String, root: MindMapNode, rawText: String, createdAt: Date) {
        self.id = id
        self.title = title
        self.root = root
        self.rawText = rawText
        self.createdAt = createdAt
    }
}
