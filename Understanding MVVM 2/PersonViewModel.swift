//
//  PersonManager.swift
//  Understanding MVVM 2
//
//  Created by Mac on 18/01/2021.
//

import Foundation



class PersonViewModel: NSObject {
    var persons:[String] = []{
        didSet{
            self.bindPersonViewModelToController()
        }
    }
    
    
    override init() {
        super.init()
        
    }
    
    var bindPersonViewModelToController: (() -> ()) = {}
    
    func addPerson(name: String) {
        print(name)
        persons.append(name)
    }
    
    
}
