//
//  Data+Extention.swift
//  ArrayOperations
//
//  Created by Ashish Awasthi on 20/12/20.
//  Copyright © 2020 Ashish Awasthi. All rights reserved.
//

import Foundation
extension Data {
    /* Gets bytes array from the data object (Data) */
    public var bytes : [UInt8] {
        return [UInt8](self)
    }
   
    /* Substract data object by passing start bytes and needed number of bytes called lenth*/
    public func subtract(_ start: Int, _ lenth: Int) ->Data {
        precondition(self.count >=  start + lenth,
                     "Invalid data range range. trying to find out of bound data")
        let allBytes = Array(Data(bytes: self.bytes, count: self.count))
        let partBytes = Array(allBytes[start..<start + lenth])
        let dataPart = Data(bytes: partBytes, count: partBytes.count)
        return dataPart
    }
    /* Ignite connect checksum logic...*/
    //==========================================================================
    var checkSum: UInt16 {
        return self.checksumAlgorithm
    }
    
    private var checksumAlgorithm: UInt16 {
        var checkSum: UInt16 = 0
        var actualLength =  self.count
        if actualLength < 2 {
            return 0
        }
        /* Checking whether data lenth is odd or even *, Its true if lenth is old */
        let isDataLengthOdd = actualLength & 1 == 1
        if isDataLengthOdd {
            actualLength = actualLength - 1
        }
        let allBytes = Array(Data(bytes: self.bytes, count: self.count))
        for index in stride(from: 0, to: actualLength, by: 2) {
            let temp1  = lowerBites(allBytes[index])
            let temp2 =  upperBites(allBytes[index + 1])
            let temp = (temp1 | temp2)
            checkSum += UInt16(temp)
        }
        if isDataLengthOdd {
            let temp = lowerBites(allBytes[self.count - 1])
            checkSum += UInt16(temp);
        }
        /* 2's complement..... */
        var complementCheckSum = UInt32(checkSum)
        complementCheckSum = (0x10000 - complementCheckSum)
        complementCheckSum = (complementCheckSum & 0xFFFF)
        return UInt16(complementCheckSum)
    }
    /* Find out masked lower bites */
    func lowerBites(_ b: UInt8) -> UInt8 {
        return b & 0xFF
    }
    /* Find out masked upper bites */
    func upperBites(_ b: UInt8) -> UInt8 {
        let ret = (b << 8)
        return (ret & 0xFF)
    }
    //========================================================================
}

/* ===================== Test Result ==================
 
 guard let data = "abc".data(using: .utf8) else { return }
 let checksum = data.checkSum // 65340
 print("abc checksum: \(checksum)")
 
 abc checksum: 65340
 
 */
