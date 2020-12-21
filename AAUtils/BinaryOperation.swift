//
//  BinaryOperation.swift
//  ArrayOperations
//
//  Created by Ashish Awasthi on 19/12/20.
//  Copyright © 2020 Ashish Awasthi. All rights reserved.
//

import Foundation

enum BinaryOperationType: Int {
    case rightShift
    case leftShift
    case xor
}
/// Note: Binary operation always apply on two parameters. that why its called binary
/// Binary means two(0,1), decimal means 10(0,1.2....9), hexdecimal means 16(0,1,2.....A, B,C,D,E,F) etc.
class BinaryOperation {
    /// Right shift mean shift every bit number of time need to shift  toward left side
    /// For example value 0000 0100 = 4, Right shift postion = 1, answer 0000 1000 = 8
    /// For example value 0000 0100 = 4, Right shift postion = 3, answer 0010 0000 = 32
    ///- parameter postion: number of time need to shift every toward left side
    ///- parameter value: given value on need to apply right shift
    class func righShift(_ postion: UInt8, value: UInt8) -> UInt8 {
        return value << postion
    }
    /// Left shift mean shift every bit number of time need to shift  toward right side
    /// For example value 0000 0100 = 4, Right shift postion = 1, answer 0000 0010 = 2
    /// For example value 0000 0100 = 4, Right shift postion = 3, answer 0000 0000 = 0 out bound hence 0
    ///- parameter postion: number of time need to shift  toward  right side
    ///- parameter value: given value on need to apply right shift
    
    class func leftShift(_ postion: UInt8, value: UInt8) -> UInt8 {
        return value >> postion
    }
    
    /// XOR Operation means 1 ^1 = 0, 0^1 = 1, 1^0 = 1, 0^0 = 0
    /// For example value 0000 0100 = 4, 0000 0100 = 4  4^4 = 0
    ///  For example value 0000 0100 = 4, 0000 0011 = 4  4^3 =  7
    ///- parameter first: first input parameter
    ///- parameter second:second input parameter
    class func xor(_ first: UInt8, _ second: UInt8) -> UInt8 {
        return first ^ second
    }
    class func and(_ first: UInt8, _ second: UInt8) -> UInt8 {
        return first & second
    }
    /// bitwise operator means ~ just reverse the value  0 = 1 and 1 = 0
    /// For example value 0000 0100 = 4,   ~0000 0100 = 1111 1011 = 251
    ///- parameter value: first input parameter
    class func bitwiseNot(value: UInt8) -> UInt8 {
        return ~value
    }
    /// 2's complement means bitwise not the number and add one in number. That is called 2's complement
    /// For example value 0000 0010 = 2  ~0000 0010  = 1111 1101 = 253 Now add one 253 + 1 = 254 = 1111 1110 its 2's complement
    /// its two complement is:  number + 2's complents = 2 power N  Number is 2, 2's Complements = 254 = 2+ 254 = 256  2 power 8 = 256
    /// Here is we are calculating 2's complement of 8 bits
    ///- parameter value: value for need to calculate 2's complements
    class func twoSComplement(value: UInt8) -> UInt8 {
        return ~value + 1
    }
    /// For example value 0000 0001 = 1,  &  0000 0001 = 1 true
    /// For example value 0000 0010 = 2,  &  0000 0001 = 0 false
    /// For example value 0000 0011 = 3,  &  0000 0001 = 1  true
    /// For example value 0000 0100 = 4,  &  0000 0001 = 0  false
    ///- parameter value: first input parameter
    class func isOldNumber(_ number: UInt8) -> UInt8 {
        return number & 1
    }
}

/* =============================== Test Result ===================================
 
         let value: UInt8 = 4
         var postion: UInt8 = 1
         var newValue = BinaryOperation.righShift(postion, value: value)
         print("value: \(value), After \(postion) right shift value:-\(newValue)")
         postion = 3
         newValue = BinaryOperation.righShift(postion, value: value)
         print("value: \(value), After \(postion) right shift value:-\(newValue)")
         postion = 1
         newValue = BinaryOperation.leftShift(postion, value: value)
         print("value: \(value), After \(postion) left shift value:-\(newValue)")
         postion = 3
         newValue = BinaryOperation.leftShift(postion, value: value)
         print("value: \(value), After \(postion) left shift value:-\(newValue)")
 
         newValue = UInt8(BinaryOperation.xor(4,4))
         print("XOR Values(4,4), After XOR value:-\(newValue)")
         newValue = UInt8(BinaryOperation.xor(4,3))
         print("XOR Values(4,3), After XOR value:-\(newValue)")
         newValue = UInt8(BinaryOperation.xor(4,5))
         print("XOR Values(4,5), After XOR value:-\(newValue)")
         newValue = UInt8(BinaryOperation.xor(10,9))
         print("XOR Values(10,9), After XOR value:-\(newValue)")
         newValue = UInt8(BinaryOperation.xor(9,10))
         print("XOR Values(9,10), After XOR value:-\(newValue)")
         newValue = UInt8(BinaryOperation.xor(255,204))
         print("XOR Values(255,204), After & value:-\(newValue)")
 
         newValue = UInt8(BinaryOperation.twoSComplement(value: 2))
         print("2's complements 2 = \(newValue)")
 
         newValue = UInt8(BinaryOperation.isOldNumber(1))
         print("1 Is old number = \(newValue)")
         newValue = UInt8(BinaryOperation.isOldNumber(2))
         print("2 Is old number = \(newValue)")
 
 value: 4, After 1 right shift value:-8
 value: 4, After 3 right shift value:-32
 value: 4, After 1 left shift value:-2
 value: 4, After 3 left shift value:-0
 XOR Values(4,4), After XOR value:-0
 XOR Values(4,3), After XOR value:-7
 XOR Values(4,5), After XOR value:-1
 XOR Values(10,9), After XOR value:-3
 XOR Values(9,10), After XOR value:-3
 XOR Values(255,204), After & value:-51
 2's complements 2 = 254
 1 Is old number = 1
 2 Is old number = 0
 
 
 
 
 =================================== Test Result ==================================== */
