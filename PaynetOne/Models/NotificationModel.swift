//
//  NotificationModel.swift
//  PaynetOne
//
//  Created by Icloud Vinatti on 19/05/2022.
//

import Foundation

struct NewsItem: Identifiable, Codable {
  var id = UUID()
  let title: String
  let body: String
  let date: Date

  private enum CodingKeys: String, CodingKey {
    case title
    case body
    case date
  }
}
