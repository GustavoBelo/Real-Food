//
//  Bindable.swift
//  Real Food
//
//  Created by Gustavo Belo on 12/07/22.
//

import Foundation

public class Bindable<T> {
    public typealias Listener = (T) -> ()
    
    // MARK: - Properties
    public var listeners: [Listener] = []
    
    // MARK: - Constructors
    public init(_ v: T) {
        value = v
    }
    
    // MARK: - Bind
    public func bind(_ listener: @escaping Listener) {
        self.listeners.append(listener)
    }
    
    // MARK: - Trigger
    public var value: T {
        didSet { listeners.forEach { $0(value) } }
    }
}
