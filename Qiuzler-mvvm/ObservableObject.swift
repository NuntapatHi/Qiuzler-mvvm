//
//  ObservableObject.swift
//  Qiuzler-mvvm
//
//  Created by Nuntapat Hirunnattee on 17/9/2565 BE.
//

import Foundation

final class ObservableObject<T>{
    
    var value: T{
        didSet{
            listener?(value)
        }
    }
    
    private var listener: ((T) -> Void)?
    
    init(_ value: T){
        self.value = value
    }
    
    func bind(_ listener: @escaping (T) -> Void){
        listener(value)
        self.listener = listener
    }
}
