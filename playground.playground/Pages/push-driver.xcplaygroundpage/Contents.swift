//: [Previous](@previous)

import Foundation

class Value<T> {
    private var _value: T
    private var observers: [(T) -> Void] = []
    var value: T {
        set {
            _value = newValue
            observers.forEach { (observer) in
                observer(newValue)
            }
        }
        get { return _value }
    }
    init(_ initValue: T) { _value = initValue }
    func observe(_ observeFunc:@escaping (T) -> Void) {
        observeFunc(_value)
        observers.append(observeFunc)
    }
}

func combine<A, B, C>(left: Value<A>, right: Value<B>, reduce:@escaping (A, B) -> C) -> Value<C> {
    var leftValue = left.value
    var rightValue = right.value
    let recalue = { return reduce(leftValue, rightValue) }
    let returnValue = Value(recalue())
    left.observe {
        leftValue = $0
        returnValue.value = recalue()
    }
    right.observe {
        rightValue = $0
        returnValue.value = recalue()
    }
    return returnValue
}


func +(left: Value<Int>, right: Value<Int>) -> Value<Int>{
    return combine(left: left, right: right, reduce: +)
}

var a = Value(3)
var b = Value(5)
var c = a + b

c.observe {
    print("value: \($0)")
}
a.value = 8
c.value
a.value = 12
c.value
b.value = 9



