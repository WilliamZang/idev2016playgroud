//: Playground - noun: a place where people can play

import UIKit

class Value<T> {
    private var valueBlock: () -> T
    var value: T {
        set {
            valueBlock = { return newValue }
        }
        get { return valueBlock() }
    }
    init(_ initValue: T) {
        valueBlock = { return initValue }
    }
    init (_ initBlock: @escaping () -> T) {
        valueBlock = initBlock
    }
}

func combine<A, B, C>(left: Value<A>, right: Value<B>, reduce:@escaping (A, B) -> C) -> Value<C> {
    return Value {
        return reduce(left.value, right.value)
    }
}

func +(left: Value<Int>, right: Value<Int>) -> Value<Int>{
    return combine(left: left, right: right, reduce: +)
}

var a = Value(5)
var b = Value(7)
var c = a + b

c.value
a.value = 8
c.value
b.value = 12
c.value
c.value = 9
a = c + b
a.value
















