//
//  MVVMLiveData.swift
//  VOYD
//
//  Created by MacBook Pro on 17/10/2022.
//

import Foundation

class LiveData<T>{
    
    init(){
        value = nil
        onChangeCallbacks = []
    }
    
    init(_ initVal: T){
        value = initVal
        onChangeCallbacks = []
    }
    
    private var value: T? = nil
    private var onChangeCallbacks: [(T?) ->Void] = []
    
    func setValue(_ value:T){
        self.value = value
        notify()
    }
    
    func getValue() -> T?{
        return self.value
    }
    
    func getOrDefualt(_ defaultVal: T) -> T{
        return self.value ?? defaultVal
    }
    
    func observe(onChange: @escaping (_ type:T?)->Void){
        onChangeCallbacks.append(onChange)
    }
    
    func notify(){
        onChangeCallbacks.forEach({(it) in
            it(value)
        })
    }
}
