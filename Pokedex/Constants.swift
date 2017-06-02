//
//  Utils.swift
//  Pokedex
//
//  Created by Abdul-Mujib Aliu on 5/27/17.
//  Copyright © 2017 Abdul-Mujib Aliu. All rights reserved.
//

import Foundation

var MAIN_VC_IDENTIFIER = "MAIN_VC_IDENTIFIER"
var DETAIL_VC_IDENTIFIER = "DETAIL_VC_IDENTIFIER"
var MAIN_VC_POKE_CELL_IDENTIFIER = "MAIN_VC_POKE_CELL_IDENTIFIER"
var MAIN_VC_POKE_DETAIL_SEGUE_IDENTIFIER = "MAIN_VC_POKE_DETAIL_SEGUE_IDENTIFIER"

var BASE_URL = "http://pokeapi.co"
var POKE_MON_BASE_URL = "/api/v1/pokemon"

typealias CompletedDownload = () -> ()

func getPokeMonDetailsURLforID(id: Int) -> String  {
    return "\(BASE_URL)/\(POKE_MON_BASE_URL)/\(id)/"
}
