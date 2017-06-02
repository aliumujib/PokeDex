//
//  Pokemon.swift
//  Pokedex
//
//  Created by Abdul-Mujib Aliu on 5/27/17.
//  Copyright © 2017 Abdul-Mujib Aliu. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {

    private var _id: Int!
    private var _name : String!
    private var _height : Int!
    private var _weight : Int!
    private var _pokedexEntry : String!
    private var _primaryType : String!
    private var _secondaryType : String!
    
    var name: String{
        if(_name == nil){
            _name = ""
        }
        return _name
    }

    
    var pokedexEntry: String{
        if(_pokedexEntry == nil){
            _pokedexEntry = "N/A"
        }
        return _pokedexEntry
    }

    var primaryType: String{
        if(_primaryType == nil){
            _primaryType = "N/A"
        }
        return _primaryType
    }

    var secondaryType: String{
        if(_secondaryType == nil){
            _secondaryType = "N/A"
        }
        return _secondaryType
    }


    var id: Int{
        if(_id == 0){
            
        }
        return _id
    }
    
    var height: Int{
        if(_height == 0){
            
        }
        return _height
    }
    
    
    
    var weight: Int{
        if(_weight == 0){
            
        }
        return _weight
    }
    
    init(id: Int, weight: Int, height: Int, name: String) {
        _id = id
        _name = name
        _weight = weight
        _height = height
    }
    
    init(id: Int, name: String) {
        _id = id
        _name = name
    }
    
    func getExtraDetails(completedDownload: @escaping CompletedDownload){
        Alamofire.request(getPokeMonDetailsURLforID(id: id)).responseJSON{ (response) in
            if let mainDict = response.result.value as? Dictionary<String,Any>{
                if let types = mainDict["types"] as? [Dictionary<String, Any>]{
                    for i in 0...types.count - 1{
                        if let name = types[i]["name"] as? String{
                            if(i==0){
                             self._primaryType = name
                            }
                            
                            if(i==1){
                                self._secondaryType = name
                            }
                        }
                    }
                }
                
                if let descs = mainDict["descriptions"] as? [Dictionary<String, Any>]{
                    if let url = descs[0]["resource_uri"] as? String{
                            var uri = "\(BASE_URL)\(url)"
                        print(uri)
                        Alamofire.request(uri).responseJSON{
                        (response) in
                            
                            if let responseDict = response.result.value as? Dictionary<String, Any>{
                            if let desc = responseDict["description"] as? String{
                                self._pokedexEntry = desc
                            }
                        }
                            completedDownload()
                    }
    
                }
            }
        }
            
            completedDownload()
        }
        
        
    }
    
}


