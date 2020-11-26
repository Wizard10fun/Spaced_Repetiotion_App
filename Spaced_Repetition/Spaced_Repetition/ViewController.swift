//
//  ViewController.swift
//  Spaced_Repetition
//
//  Created by McMahon Family on 11/4/20.
//

import UIKit

class ViewController: UIViewController  {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
 

}

class Card {
    
    var frontWord : String
    var backWord : String
    var hasValue : Bool
 
    
    init(frontWord: String, backWord : String)
    {
        self.frontWord = frontWord
        self.backWord = backWord
        self.hasValue = true
       
    }
    
    
    
    
}

