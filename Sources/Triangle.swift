//
//  Triangle.swift
//  meshlib
//
//  Created by md on 12/21/17.
//

import Foundation

public final class Triangle {
  public let v1Index: Int
  public let v2Index: Int
  public let v3Index: Int

  public init(_ v1Index: Int, _ v2Index: Int, _ v3Index: Int) {
    self.v1Index = v1Index
    self.v2Index = v2Index
    self.v3Index = v3Index
  }

  public func clone() -> Triangle {
    return Triangle(v1Index, v2Index, v3Index)
  }
}
