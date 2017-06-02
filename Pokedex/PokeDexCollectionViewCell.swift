//
//  PokeDexCollectionViewCell.swift
//  Pokedex
//
//  Created by Abdul-Mujib Aliu on 5/27/17.
//  Copyright © 2017 Abdul-Mujib Aliu. All rights reserved.
//

import UIKit
import ComplimentaryGradientView

class PokeDexCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cardElevationView: UIView!
    
    @IBOutlet weak var pokeImage: ComplimentaryGradientView!
    
    @IBOutlet weak var pokemonLabel: UILabel!
    
    @IBOutlet weak var pokeMonIcon: UIImageView!
    
    @IBInspectable var cornerRadius: CGFloat = 4
    
    @IBInspectable var shadowOffsetWidth: Int = 0
    @IBInspectable var shadowOffsetHeight: Int = 2
    @IBInspectable var shadowColor: UIColor? = UIColor.black
    @IBInspectable var shadowOpacity: Float = 0.3

    
    override func awakeFromNib() {
        
        cardElevationView.backgroundColor = .white
        cardElevationView.layer.cornerRadius = cornerRadius
        let shadowPath = UIBezierPath(roundedRect: cardElevationView.bounds, cornerRadius: cornerRadius)
        
        cardElevationView.layer.masksToBounds = false
        cardElevationView.layer.shadowColor = shadowColor?.cgColor
        cardElevationView.layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight);
        cardElevationView.layer.shadowOpacity = shadowOpacity
        cardElevationView.layer.shadowPath = shadowPath.cgPath
        
        pokeImage.layer.cornerRadius = cornerRadius
        pokeMonIcon.layer.cornerRadius = cornerRadius
        pokeMonIcon.layer.masksToBounds = false
        pokeImage.layer.masksToBounds = false
        pokeImage.clipsToBounds = true;
        pokeMonIcon.clipsToBounds = true ;

        
        initAlignment()
    }
    
    func initAlignment(){
        cardElevationView.translatesAutoresizingMaskIntoConstraints = false
        pokeImage.translatesAutoresizingMaskIntoConstraints = false
        pokemonLabel.translatesAutoresizingMaskIntoConstraints = false
        pokeMonIcon.translatesAutoresizingMaskIntoConstraints = false
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-(-0)-[avaBg(157)]-10-[pokeName(21)]", options: [], metrics: nil, views: ["avaBg": pokeImage, "pokeName": pokemonLabel]))
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-(-0)-[ava(157)]", options: [], metrics: nil, views: ["ava": pokeMonIcon]))
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[card(157)]", options: [], metrics: nil, views: ["card": cardElevationView]))
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(-0)-[avaBg(140)]", options: [], metrics: nil, views: ["avaBg": pokeImage]))
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(-0)-[ava(140)]", options: [], metrics: nil, views: ["ava": pokeMonIcon]))
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[card(140)]", options: [], metrics: nil, views: ["card": cardElevationView]))
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[pokeName]-|", options: [], metrics: nil, views: ["pokeName": pokemonLabel]))
        
    }
    
    func bindPokeMon(pokeMon: Pokemon)  {
        var image = UIImage(named: "\(pokeMon.id)")
        pokeMonIcon.image  = image
        DispatchQueue.global(qos: .background).async {
            self.pokeImage.image = image
        }
        pokemonLabel.text = pokeMon.name.capitalized
    }
    
}
