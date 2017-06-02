//
//  DetailViewController.swift
//  Pokedex
//
//  Created by Abdul-Mujib Aliu on 5/27/17.
//  Copyright © 2017 Abdul-Mujib Aliu. All rights reserved.
//

import UIKit
import ComplimentaryGradientView

class DetailViewController: UIViewController {
    
    //in retrospect, i think stackviews would have been more appropriate .. oh well
    var screenWidth: CGFloat = 0.0
    var screenHeight: CGFloat = 0.0

    var pokemon: Pokemon!
    
    @IBOutlet weak var avatarBackGround: UIImageView!
    
    @IBOutlet weak var avatarImage: UIImageView!

    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var pokemonName: UILabel!
    
    @IBOutlet weak var pokemonIdentifier: UILabel!
    
    @IBOutlet weak var infoLabel: UILabel!
    
    @IBOutlet weak var seperatorBottom: UIView!
    
    @IBOutlet weak var seperatorTop: UIView!
    
    @IBOutlet weak var primaryTypeName: UILabel!
    
    @IBOutlet weak var secondaryTypeName: UILabel!
   
    @IBOutlet weak var primaryTypeDescriptor: UILabel!
    
    @IBOutlet weak var heightLabel: UILabel!
    
    @IBOutlet weak var weightLabel: UILabel!
    
    @IBOutlet weak var secondaryTypeDescriptor: UILabel!
    
    @IBOutlet weak var pokeDexEntryLabel: UILabel!
    
    @IBOutlet weak var heightValueLabel: UILabel!
    
    @IBOutlet weak var weightValueLabel: UILabel!
    
    @IBOutlet weak var gradientBg: ComplimentaryGradientView!
    
    
    
     var cornerRadius: CGFloat = 3
    
     var shadowOffsetWidth: Int = 0
     var shadowOffsetHeight: Int = 1
     var shadowColor: UIColor? = UIColor.black
     var shadowOpacity: Float = 0.3
    
    @IBOutlet weak var cardElevationView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        screenWidth = self.view.frame.width
        screenHeight = self.view.frame.height

        avatarBackGround.layer.cornerRadius = avatarBackGround.frame.size.height/2
        
        
        
        if(pokemon != nil){
            initPokemon(pokemon: pokemon)
            pokemon.getExtraDetails {
                print("GOT HERE DETAILVC")
                self.initPokemon(pokemon: self.pokemon)
            }
        }
        
        initAlignment()
    }
    
  

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initPokemon(pokemon: Pokemon) {
        pokemonName.text = pokemon.name.capitalized
        pokemonIdentifier.text = "#\(pokemon.id)"
        var image = UIImage(named: "\(pokemon.id)")
        avatarImage.image = image
        gradientBg.image = image
        weightValueLabel.text = ("\(pokemon.weight) KG")
        heightValueLabel.text = ("\(pokemon.height) KG")
        pokeDexEntryLabel.text = pokemon.pokedexEntry
        primaryTypeName.text = pokemon.primaryType
        secondaryTypeName.text = pokemon.secondaryType
    }
    
    func initAlignment() {
        avatarBackGround.translatesAutoresizingMaskIntoConstraints = false
        avatarImage.translatesAutoresizingMaskIntoConstraints = false
        backButton.translatesAutoresizingMaskIntoConstraints = false
        pokemonName.translatesAutoresizingMaskIntoConstraints = false
        pokemonIdentifier.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        seperatorBottom.translatesAutoresizingMaskIntoConstraints = false
        seperatorTop.translatesAutoresizingMaskIntoConstraints = false
        primaryTypeName.translatesAutoresizingMaskIntoConstraints = false
        secondaryTypeName.translatesAutoresizingMaskIntoConstraints = false
        primaryTypeDescriptor.translatesAutoresizingMaskIntoConstraints = false
        heightLabel.translatesAutoresizingMaskIntoConstraints = false
        weightLabel.translatesAutoresizingMaskIntoConstraints = false
        secondaryTypeDescriptor.translatesAutoresizingMaskIntoConstraints = false
        pokeDexEntryLabel.translatesAutoresizingMaskIntoConstraints = false
        weightValueLabel.translatesAutoresizingMaskIntoConstraints = false
        heightValueLabel.translatesAutoresizingMaskIntoConstraints = false
        gradientBg.translatesAutoresizingMaskIntoConstraints = false
        
        cardElevationView.translatesAutoresizingMaskIntoConstraints = false

        
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-20-[back(30)]-100-[info]-10-[card(180)]", options: [], metrics: nil, views: ["back": backButton, "info":infoLabel, "card":cardElevationView]))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-30-[pokename]-10-[pokeId]", options: [], metrics: nil, views: ["pokename": pokemonName, "pokeId":pokemonIdentifier]))
        
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-30-[pokename]-10-[pokeId]", options: [], metrics: nil, views: ["pokename": pokemonName, "pokeId":pokemonIdentifier]))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-10-[ava(93)]", options: [], metrics: nil, views: ["ava": avatarImage]))
        
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-20-[avaBg(93)]", options: [], metrics: nil, views: ["avaBg": avatarBackGround]))
        
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-10-[pritypename(21)]-5-[pritypedesc]-10-[divtop(1)]-10-[pokeentry]-10-[divbottom(1)]-5-[heightvallbl]-5-[heightvaldesc]", options: [], metrics: nil, views: ["pritypename": primaryTypeName, "pritypedesc": primaryTypeDescriptor, "divtop": seperatorTop, "pokeentry": pokeDexEntryLabel, "divbottom":seperatorBottom, "heightvallbl":heightValueLabel, "heightvaldesc": heightLabel]))
        
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-10-[sectypename(21)]-5-[sectypedesc]", options: [], metrics: nil, views: ["sectypename": secondaryTypeName, "sectypedesc":secondaryTypeDescriptor]))
        
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[divbottom]-5-[weightvallbl]-5-[weightvaldesc]", options: [], metrics: nil, views: ["divbottom": seperatorBottom, "weightvallbl":weightValueLabel, "weightvaldesc":weightLabel]))
        
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[grad(230)]", options: [], metrics: nil, views: ["grad": gradientBg]))
        
        
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[back(30)]-10-[pokename(\(screenWidth-(screenWidth/2)+20))]-10-[avaBg(150)]", options: [], metrics: nil, views: ["back": backButton, "pokename":pokemonName, "avaBg":avatarBackGround]))
        
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[pokename]-[ava(93)]", options: [], metrics: nil, views: ["pokename": pokemonName, "ava":avatarImage]))
        
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[pokeId]-50-|", options: [], metrics: nil, views: ["pokeId": pokemonIdentifier]))
        
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-30-[infoLbl]-|", options: [], metrics: nil, views: ["infoLbl": infoLabel]))
        
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[priTypeName(70)]-10-[secTypeName(70)]", options: [], metrics: nil, views: ["priTypeName": primaryTypeName, "secTypeName":secondaryTypeName]))
        
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[priTypeDesc(70)]-20-[secTypeDesc(70)]", options: [], metrics: nil, views: ["priTypeDesc": primaryTypeDescriptor, "secTypeDesc":secondaryTypeDescriptor]))
        
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[divTop]-20-|", options: [], metrics: nil, views: ["divTop": seperatorTop]))
        
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[divBtm]-20-|", options: [], metrics: nil, views: ["divBtm": seperatorBottom]))
        
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-30-[pokedexLbl]-30-|", options: [], metrics: nil, views: ["pokedexLbl": pokeDexEntryLabel]))
        
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[card(\(screenWidth-20))]-10-|", options: [], metrics: nil, views: ["card": cardElevationView]))
        
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[grad(\(screenWidth))]-0-|", options: [], metrics: nil, views: ["grad": gradientBg]))
        
        
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-30-[heightVal]-[weightVal]-30-|", options: [], metrics: nil, views: ["heightVal": heightValueLabel, "weightVal":weightValueLabel]))
        
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-30-[heightDesc]-\(screenWidth - 160)-[weightDesc]-30-|", options: [], metrics: nil, views: ["heightDesc": heightLabel, "weightDesc":weightLabel]))
        
    }
    
    override func viewDidLayoutSubviews() {
        cardElevationView.backgroundColor = .white
        cardElevationView.layer.cornerRadius = cornerRadius
        let shadowPath = UIBezierPath(roundedRect: cardElevationView.bounds, cornerRadius: cornerRadius)
        
        cardElevationView.layer.masksToBounds = false
        cardElevationView.layer.shadowColor = shadowColor?.cgColor
        cardElevationView.layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight);
        cardElevationView.layer.shadowOpacity = shadowOpacity
        cardElevationView.layer.shadowPath = shadowPath.cgPath
        
        primaryTypeName.layer.cornerRadius = cornerRadius
        secondaryTypeName.layer.cornerRadius = cornerRadius
        secondaryTypeName.layer.masksToBounds = false
        primaryTypeName.layer.masksToBounds = false
        secondaryTypeName.clipsToBounds = true;
        primaryTypeName.clipsToBounds = true ;
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func backBtnClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}
