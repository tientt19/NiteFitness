//
//  LoggerExtension.swift
//  NiteFitness
//
//  Created by Tiến Trần on 19/12/2022.
//

import Foundation
import os.log

@available(iOS 14.0, *)
extension Logger {
  static let storeManager = Logger(subsystem: Bundle.main.bundleIdentifier ?? "", category: "Store Manager")
  static let survey = Logger(subsystem: Bundle.main.bundleIdentifier ?? "", category: "Survey")
  static let task = Logger(subsystem: Bundle.main.bundleIdentifier ?? "", category: "Task")
}
