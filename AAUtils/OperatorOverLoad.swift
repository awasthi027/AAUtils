//
//  OperatorOverLoad.swift
//  AAUtils
//
//  Created by Ashish Awasthi on 06/02/20.
//  Copyright © 2020 Ashish Awasthi. All rights reserved.
//

import Foundation
import UIKit
// https://en.wikipedia.org/wiki/Mathematical_operators_and_symbols_in_Unicode

/* ⊖ ⊗ ⊕ these are unicode symbals we can use for operator overloading for unique way indentification.
 which will not conflict with existing one. If write same as existing one. It will conflict with existing one.*/

/* It will override existing functionalty of adding two numbers
 ** Example we have to array [1, 2, 3] + [1, 2, 3] = [1, 2, 3,1, 2, 3] with existing one.
  It will add two array as existing functionalty. We have write specifix identication for adding to array.
 */

/*public func +(left: [Int], right: [Int]) -> [Int] { // 1
    var sum = [Int]() // 2
    assert(left.count == right.count, "vector of same length only")  // 3
    for (key, _) in left.enumerated() {
      sum.append(left[key] + right[key]) // 4
    }
    return sum
}*/

// Here we can use + because we can't directly add two points.

public func + (left: CGPoint, right: CGPoint) -> CGPoint {
  return CGPoint(x: left.x + right.x, y: left.y + right.y)
}
public func * (left: CGPoint, right: CGPoint) -> CGPoint {
  return CGPoint(x: left.x * right.x, y: left.y * right.y)
}


/* This will ⊕| two array one by one
 Example we have to array [1, 2, 3] + [1, 2, 3] = [2,4,6] with existing one
 */
precedencegroup AdditionPrecedence {
  associativity: left
  higherThan: LogicalConjunctionPrecedence
}

/* This will only add interger numbers. We want to add any number double, Int, Float
infix operator ⊕| : AdditionPrecedence
public func ⊕|(left: [Int], right: [Int]) -> [Int] { // 2
    var sum = [Int].init(repeating: 0, count: left.count)
    assert(left.count == right.count, "vector of same length only")
    for (key, _) in left.enumerated() {
        sum[key] = left[key] + right[key]
    }
    return sum
}
 */


public protocol Number {  // 1
    static func +(l: Self, r: Self) -> Self // 2
    static func *(l: Self, r: Self) -> Self // 3
    static func -(l: Self, r: Self) -> Self // 4
}

extension Double : Number {} // 3
extension Float  : Number {}
extension Int    : Number {}

precedencegroup GenericAdditionPrecedence {
  associativity: left
  higherThan: LogicalConjunctionPrecedence
}
infix operator ⊕| : GenericAdditionPrecedence

public func ⊕|<T: Number>(left: [T], right: [T]) -> [T] { // 4
    var add = [T]()
    assert(left.count == right.count, "vector of same length only")
    for (key, _) in left.enumerated() {
        add.append(left[key] + right[key])
    }
    return add
}

precedencegroup GenericMinusPrecedence {
  associativity: left
  higherThan: LogicalConjunctionPrecedence
}
infix operator ⊖| : GenericMinusPrecedence

public func ⊖|<T: Number>(left: [T], right: [T]) -> [T] { // 4
    var minus = [T]()
    assert(left.count == right.count, "vector of same length only")
    for (key, _) in left.enumerated() {
        minus.append(left[key] - right[key])
    }
    return minus
}


precedencegroup GenericMultiPrecedence {
  associativity: left
  higherThan: LogicalConjunctionPrecedence
}
infix operator ⊛| : GenericMultiPrecedence

public func ⊛|<T: Number>(left: [T], right: [T]) -> [T] { // 4
    var multiple = [T]()
    assert(left.count == right.count, "vector of same length only")
    for (key, _) in left.enumerated() {
        multiple.append(left[key] * right[key])
    }
    return multiple
}

public class OperatonOverLoad {
    public init() {}
    
    public func testOperatorOverLoading() {
        let firstNumbers = [1, 2, 3]
        let secondNumbers = [1, 2, 3]
        let normalAdd = firstNumbers + secondNumbers
        FSLogInfo("Sum of two normal array First Number:- \(firstNumbers), Second Number:-\(secondNumbers)\nSum\(normalAdd)")
        let sum = [1, 2, 3] ⊕| [1, 2, 3]
        FSLogInfo("Sum of two numbers First ⊕| Number:- \(firstNumbers), Second Number:-\(secondNumbers)\n\(sum)")
        let gFirst = [1.4, 2.1, 3.1]
        let gSecond =  [1.6, 2, 3.2]
        let genericSum = gFirst ⊕| gSecond
        FSLogInfo("Generic of two numbers ⊕| First Number:- \(gFirst), Second Number:-\(gSecond)\n\(genericSum)")
        let genericMinus = gFirst ⊛| gSecond
        FSLogInfo("Generic of Minus numbers ⊕| First Number:- \(gFirst), Second Number:-\(gSecond)\n\(genericMinus)")
        let genericMultiple = gFirst ⊖| gSecond
        FSLogInfo("Generic of Multiple numbers ⊕| First Number:- \(gFirst), Second Number:-\(gSecond)\n\(genericMultiple)")
        let pt1 = CGPoint(x: 10, y: 20)
        let pt2 = CGPoint(x: -5, y: 10)
        let pt3 = pt1 + pt2
        FSLogInfo("Addition of two Points First Point:- \(pt1), Second Point:-\(pt2)\n\(pt3)")
        let pt4 = pt1 * pt2
        FSLogInfo("Multification of two Points First Point:- \(pt1), Second Point:-\(pt2)\n\(pt4)")
      
    }
}

