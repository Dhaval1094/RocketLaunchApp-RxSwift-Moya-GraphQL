//
//  Clousers.swift
//  RocketLaunchApp
//
//  Created by Dhaval Trivedi on 02/06/21.
//

import Foundation

/*
 This provides flexibility to use closures with different number of parameters and return type. Directly assign and use the closer in any class.
 */

// Empty Result + Void Return
typealias EmptyResult<ReturnType> = () -> ReturnType

// Custom Result + Custom Return
typealias SingleResultWithReturn<T, ReturnType> = ((T) -> ReturnType)
typealias DoubleResultWithReturn<T1, T2, ReturnType> = ((T1, T2) -> ReturnType)
typealias TripleResultWithReturn<T1, T2, T3, ReturnType> = ((T1, T2, T3) -> ReturnType)
// Max limit should be three arguments only

// Custom Result + Void Return
typealias SingleResult<T> = SingleResultWithReturn<T, Void>
typealias DoubleResult<T1, T2> = DoubleResultWithReturn<T1, T2, Void>
typealias TripleResult<T1, T2, T3> = TripleResultWithReturn<T1, T2, T3, Void>

typealias VoidResult = EmptyResult<Void> // () -> Void
typealias ErrorResult = SingleResult<Error> // (Error) -> Void
typealias BoolResult = SingleResult<Bool> // (Bool) -> Void
