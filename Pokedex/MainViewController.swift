//
//  ViewController.swift
//  Pokedex
//
//  Created by Abdul-Mujib Aliu on 5/27/17.
//  Copyright © 2017 Abdul-Mujib Aliu. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UISearchBarDelegate, UICollectionViewDelegate, UICollectionViewDataSource{
    
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var musicOnOfButton: UIButton!
    
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var pokeMonCollectionView: UICollectionView!
    @IBOutlet weak var toolBarSim: UIView!
    
    var pokemonList : [Pokemon]!
    var pokemonListSorted : [Pokemon]!
    var isSearchMode: Bool!
    
    var screenWidth: CGFloat = 0.0
    var screenHeight: CGFloat = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        screenWidth = self.view.frame.width
        screenHeight = self.view.frame.height
        
        searchBar.delegate = self
        
        pokeMonCollectionView.delegate = self
        pokeMonCollectionView.dataSource = self
        
        pokemonList = [Pokemon]()
        pokemonListSorted = [Pokemon]()

        isSearchMode = false
        
        
        initAlignment()
        
        parseCSV()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func initAlignment() {
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        musicOnOfButton.translatesAutoresizingMaskIntoConstraints = false
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
                pokeMonCollectionView.translatesAutoresizingMaskIntoConstraints = false
        toolBarSim.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[toolbar]-|", options: [], metrics: nil, views: ["toolbar": toolBarSim]))
        
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[collectionView]-|", options: [], metrics: nil, views: ["collectionView": pokeMonCollectionView]))
        
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[toolbar(60)]-[collectionView]-|", options: [], metrics: nil, views: ["toolbar": toolBarSim, "collectionView": pokeMonCollectionView]))

        
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-30-[setting(22)]", options: [], metrics: nil, views: ["setting": settingsButton]))
        
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-25-[titleLabel(35)]", options: [], metrics: nil, views: ["titleLabel": titleLabel]))

        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-30-[search(20)]", options: [], metrics: nil, views: ["search": searchButton]))

        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-30-[musicOnOff(20)]", options: [], metrics: nil, views: ["musicOnOff": musicOnOfButton]))

    
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[setting(22)]-10-[title]-10-[search(20)]-15-[music(20)]-0-|", options: [], metrics: nil, views: ["setting": settingsButton, "title":titleLabel, "search":searchButton, "music":musicOnOfButton]))
        
        hideSearchBar()
        
    }
    
    func parseCSV()  {
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")
        do{
            let csv = try CSVParser(contentsOfURL: path!)
            let rows = csv.rows
            
            for row in rows{
                //SINCE WERE SURE POKEMON.CSV IS ALL GOOD
                let pokeId = Int(row["id"]!)!
                let name = String(row["identifier"]!)!
                let weight = Int(row["weight"]!)!
                let height = Int(row["height"]!)!
                let pokemon : Pokemon = Pokemon(id: pokeId, weight: weight, height: height,name: name)
                pokemonList.append(pokemon)
                
                pokeMonCollectionView.reloadData()
            }
        }catch let error as NSError{
            print(error.description)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if isSearchMode! {
            return pokemonListSorted.count
        }else{
            return pokemonList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MAIN_VC_POKE_CELL_IDENTIFIER, for: indexPath) as! PokeDexCollectionViewCell
        
        var pokemon: Pokemon!
        
        
        if isSearchMode! {
            pokemon = pokemonListSorted[indexPath.row]
        }else{
            pokemon = pokemonList[indexPath.row]
        }
        
        cell.bindPokeMon(pokeMon: pokemon)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        var pokemon: Pokemon!
        
        
        if isSearchMode! {
            pokemon = pokemonListSorted[indexPath.row]
        }else{
            pokemon = pokemonList[indexPath.row]
        }
        
            performSegue(withIdentifier: MAIN_VC_POKE_DETAIL_SEGUE_IDENTIFIER, sender: pokemon)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailViewController{
            if let poke = sender as? Pokemon{
                destination.pokemon = poke
            }
            
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func hideSearchBar()  {
        searchBar.frame = CGRect(x: 0, y: -55, width: screenWidth, height: 44)
    }
    
    func revealSearchBar()  {
        searchBar.frame = CGRect(x: -16, y: 20, width: screenWidth, height: 44)
        searchBar.becomeFirstResponder()
    }

    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
        hideSearchBar()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        self.view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if(searchText==""){
            view.endEditing(true)
            hideSearchBar()
        }
        
        if(searchBar.text == nil || searchBar.text == ""){
            isSearchMode = false
        }else{
            isSearchMode = true
            
            let lower = searchBar.text!.lowercased()
            pokemonListSorted = pokemonList.filter({$0.name.range(of: lower) != nil})
        }
        
        pokeMonCollectionView.reloadData()
    }
    
    @IBAction func searchBtnClicked(_ sender: UIButton) {
        revealSearchBar()
    }


}

