//: [Previous](@previous)

import Foundation

func maxInArray<T: Comparable>(input: [T]) -> T {
    var max = input[0]
    for item in input {
        if item > max {
            max = item
        }
    }
    return max
}

var a = 3
var b = 5
var c = a + b
var d = c + 3
b = 8