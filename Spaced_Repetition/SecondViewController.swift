//
//  SecondViewController.swift
//  Spaced_Repetition
//
//  Created by McMahon Family on 11/5/20.
//

import UIKit

var r = 0;
var cards = [Card]()


class SecondViewController: UIViewController {
   
    
    @IBOutlet weak var Front_Word: UITextField!
    @IBOutlet weak var Back_Word: UITextField!
    @IBOutlet weak var CardN: UITextField!
    
    @IBOutlet weak var Translation_Displayed: UITextView!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Front_Word.delegate = self
        Back_Word.delegate = self
    
    }
    
    @IBAction func Save_Card(_ sender: Any) {
        
        print(r)
        
       
        if !(cards[r].frontWord.isEmpty) && !(cards[r].backWord.isEmpty)
        {
            Translation_Displayed.text = "\(cards[r].frontWord)   \(cards[r].backWord)"
        }
        else
        {
            Translation_Displayed.text = "You didn't enter an front and/or back for the card"
        }
  
        
        var i = 1
        var holder = UserDefaults.standard.object(forKey: "savedFCard\(i)") as? String
        while holder != ""
        {
            i += 1
            holder = UserDefaults.standard.object(forKey: "savedFCard\(i)") as? String
            
        }
        
        UserDefaults.standard.set(0, forKey: "LastIncriment\(i)")
        UserDefaults.standard.set(cards[r].frontWord, forKey: "savedFCard\(i)")
        UserDefaults.standard.set(cards[r].backWord, forKey: "savedBCard\(i)")
        
        r += 1
    
    }
    
    @IBAction func Retrieve(_ sender: Any) {
        
        let cardNum = Int(CardN.text!) ?? 0
        
        Translation_Displayed.text = "\(UserDefaults.standard.object(forKey: "savedFCard\(cardNum)") as! String) \(UserDefaults.standard.object(forKey: "savedBCard\(cardNum)") as! String)"
    }

    @IBAction func RemoveCard(_ sender: Any) {
        
        let cardNum = Int(CardN.text!) ?? 0
        
        UserDefaults.standard.set("", forKey: "savedFCard\(cardNum)")
        UserDefaults.standard.set("", forKey: "savedBCard\(cardNum)")
        
        var a = 1
        
        while a < 1000 // Limit at 1000 cards, increases if you need to
        {
            if UserDefaults.standard.object(forKey: "savedFCard\(a)") != nil
            {
                if ((UserDefaults.standard.object(forKey: "savedFCard\(a)") as! String) == "")
                {
                    if UserDefaults.standard.object(forKey: "savedFCard\(a+1)") != nil && UserDefaults.standard.object(forKey: "savedBCard\(a+1)") != nil
                    {
                    UserDefaults.standard.set((UserDefaults.standard.object(forKey: "savedFCard\(a+1)") as! String), forKey: "savedFCard\(a)")
                    UserDefaults.standard.set((UserDefaults.standard.object(forKey: "savedBCard\(a+1)") as! String), forKey: "savedBCard\(a)")
                    UserDefaults.standard.set("", forKey: "savedFCard\(a+1)")
                    UserDefaults.standard.set("", forKey: "savedBCard\(a+1)")
                    }
                    else
                    {
                        UserDefaults.standard.set("", forKey: "savedFCard\(a)")
                        UserDefaults.standard.set("", forKey: "savedBCard\(a)")
                        
                    }
                    
                    
                }
            }
            
            a += 1
        }
        UserDefaults.standard.set(0, forKey: "LastIncriment\(cardNum)")
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        Back_Word.resignFirstResponder()
        CardN.resignFirstResponder()
    }
    
}

extension SecondViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        Translation_Displayed.resignFirstResponder()
        return true
    }
}
