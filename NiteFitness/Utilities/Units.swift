//
//  Units.swift
//  1SK
//
//  Created by vuongbachthu on 8/1/21.
//

import Foundation

public struct Units {
  
  public let bytes: Int64
  
  public var kilobytes: Double {
    return Double(bytes) / 1_024
  }
  
  public var megabytes: Double {
    return kilobytes / 1_024
  }
  
  public var gigabytes: Double {
    return megabytes / 1_024
  }
  
  public init(bytes: Int64) {
    self.bytes = bytes
  }
  
  public func getReadableUnit() -> String {
    switch bytes {
    case 0..<1_024:
      return "\(bytes) bytes"
        
    case 1_024..<(1_024 * 1_024):
      return "\(String(format: "%.2f", kilobytes)) kb"
        
    case 1_024..<(1_024 * 1_024 * 1_024):
      return "\(String(format: "%.2f", megabytes)) mb"
        
    case (1_024 * 1_024 * 1_024)...Int64.max:
      return "\(String(format: "%.2f", gigabytes)) gb"
        
    default:
      return "\(bytes) bytes"
    }
  }
    
    public func getUnitCapacity(format: String) -> String {
      switch bytes {
      case 0..<1_024:
        return "\(bytes)"
          
      case 1_024..<(1_024 * 1_024):
        return "\(String(format: format, kilobytes)) Kb"
          
      case 1_024..<(1_024 * 1_024 * 1_024):
        return "\(String(format: format, megabytes)) Mb"
          
      case (1_024 * 1_024 * 1_024)...Int64.max:
        return "\(String(format: format, gigabytes)) Gb"
          
      default:
        return "\(bytes)"
      }
    }
}
