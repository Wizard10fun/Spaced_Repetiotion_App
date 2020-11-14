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

   // public var completionHandler: ((String?) -> Void)?
  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Front_Word.delegate = self
        Back_Word.delegate = self
        
        
       
        // Do any additional setup after loading the view.
    }
    
    @IBAction func Save_Card(_ sender: Any) {
     /*
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        print("date: \(date)   hour: \(hour)   minutes: \(minutes)")
   */
        
        /*
        if r == 0
        {
            cards.append(Card(englishWord: English_Word.text!, frenchWord: French_Word.text!))
        }
        */
        cards.append(Card(frontWord: Front_Word.text!, backWord: Back_Word.text!))
        
      //  cards.append(Card(englishWord: "aaaaa", frenchWord: "bbbb"))
        
        /*
        for i in 0..<r {
            if cards[i].englishWord.isEmpty
            {
                cards.append(Card(englishWord: English_Word.text!, frenchWord: French_Word.text!))
                r = i
            }
            
            
            r += 1
        }
         */
        
        print(r)
        
        //let card1 = Card(englishWord: English_Word.text!, frenchWord: French_Word.text!)
        if !(cards[r].frontWord.isEmpty) && !(cards[r].backWord.isEmpty)
        {
            Translation_Displayed.text = "\(cards[r].frontWord)   \(cards[r].backWord)"
        }
        else
        {
            Translation_Displayed.text = "You didn't enter an front and/or back for the card"
        }
        //print(r)
        
        
        var i = 1
        var holder = UserDefaults.standard.object(forKey: "savedFCard\(i)") as? String
        while holder != ""
        {
            i += 1
            holder = UserDefaults.standard.object(forKey: "savedFCard\(i)") as? String
            
        }
        UserDefaults.standard.set(0, forKey: "LastIncriment\(i)")
        
        
  //      print("i: \(i)")
        
       
        
        UserDefaults.standard.set(cards[r].frontWord, forKey: "savedFCard\(i)")
        UserDefaults.standard.set(cards[r].backWord, forKey: "savedBCard\(i)")
        
      
        r += 1
        
   //     completionHandler?(French_Word.text)
       
    }
    
    @IBAction func Retrieve(_ sender: Any) {
        
        let cardNum = Int(CardN.text!) ?? 0
        
        Translation_Displayed.text = "\(UserDefaults.standard.object(forKey: "savedFCard\(cardNum)") as! String) \(UserDefaults.standard.object(forKey: "savedBCard\(cardNum)") as! String)"
    }
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "segue"{
            let destinationController = segue.destination as! ThirdViewController
            
            
            
                destinationController.EnglishCard = UserDefaults.standard.object(forKey: "savedECard1") as! String


            
        }
        if segue.identifier == "segue"{
            let destinationController = segue.destination as! ThirdViewController
            
                destinationController.FrenchCard = UserDefaults.standard.object(forKey: "savedFCard1") as! String
            
        }
          
        
    }
 */
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
    

    /*
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
}

extension SecondViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        Translation_Displayed.resignFirstResponder()
        return true
    }
}


