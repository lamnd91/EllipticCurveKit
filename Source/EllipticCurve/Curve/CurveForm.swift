//
//  Curve.swift
//  EllipticCurveKit
//
//  Created by Alexander Cyon on 2018-08-02.
//  Copyright © 2018 Alexander Cyon. All rights reserved.
//

import Foundation

public protocol CurveForm {
    var galoisField: Field { get }
    func multiply(point: TwoDimensionalPoint, by number: Number) -> TwoDimensionalPoint
    var equation: Polynomial { get }
    func contains<P>(point: P) -> Bool where P: Point
    func isIdentity<P>(point: P) -> Bool where P: Point
}

public extension CurveForm {
    func contains<P>(point: P) -> Bool where P: Point {
        if isIdentity(point: point) {
            return true
        } else {
            return equation.isZero(point: point, modulus: galoisField.modulus)
        }
    }

    func containsPointAt(x: Number, y: Number) -> Bool {
        return contains(point: AffinePointOnCurve<Self>(x: x, y: y))
    }

    func mod(_ number: Number) -> Number {
        return galoisField.mod(number)
    }

    func mod(expression: @escaping () -> Number) -> Number {
        return galoisField.mod(expression: expression)
    }

    func modInverseP(_ v: Number, _ w: Number) -> Number {
        return galoisField.modInverse(v, w)
    }
}