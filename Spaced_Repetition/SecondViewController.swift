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
    @IBOutlet var tableView: UITableView!
    
    var listCount = 1
    var canContinue = true
    
    
    
    @IBOutlet weak var Translation_Displayed: UITextView!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Front_Word.delegate = self
        Back_Word.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
        
        listCount = 1
        canContinue = true
        
        while canContinue == true
        {
            if UserDefaults.standard.object(forKey: "savedFCard\(listCount)") as? String == "" || UserDefaults.standard.object(forKey: "savedFCard\(listCount)") as? String == nil
            {
                canContinue = false
            }
            listCount += 1
        }
    
    }
    
    
    @IBAction func Save_Card(_ sender: Any) {
        
        print(r)
        
       
        if !(Front_Word.text!.isEmpty) && !(Back_Word.text!.isEmpty)
        {
            Translation_Displayed.text = "\(Front_Word.text!)   \(Back_Word.text!)"
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
        UserDefaults.standard.set(Front_Word.text!, forKey: "savedFCard\(i)")
        UserDefaults.standard.set(Back_Word.text!, forKey: "savedBCard\(i)")
        
        r += 1
    
        listCount = 1
        canContinue = true
        
        while canContinue == true
        {
            if UserDefaults.standard.object(forKey: "savedFCard\(listCount)") as? String == "" || UserDefaults.standard.object(forKey: "savedFCard\(listCount)") as? String == nil
            {
                canContinue = false
            }
            listCount += 1
        }
    
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
        
        listCount = 1
        canContinue = true
        
        while canContinue == true
        {
            if UserDefaults.standard.object(forKey: "savedFCard\(listCount)") as? String == "" || UserDefaults.standard.object(forKey: "savedFCard\(listCount)") as? String == nil
            {
                canContinue = false
            }
            listCount += 1
        }
    
        
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

extension SecondViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("you tapped me!")
    }
}

extension SecondViewController: UITableViewDataSource {
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (listCount - 1)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let F = UserDefaults.standard.object(forKey: "savedFCard\(indexPath.row + 1)")
        let B = UserDefaults.standard.object(forKey: "savedBCard\(indexPath.row + 1)")
        cell.textLabel?.text = "Front: \(F!)     Back: \(B!)"
        
        return cell
    }
    
}
