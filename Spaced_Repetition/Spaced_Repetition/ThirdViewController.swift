//
//  ThirdViewController.swift
//  Spaced_Repetition
//
//  Created by McMahon Family on 11/5/20.
//

import UIKit
var randCheckForEndCard = 0


class ThirdViewController: UIViewController {
var check = ""
    
    
    @IBOutlet weak var FrontCardDisplay: UITextView!
    @IBOutlet weak var BackCardDisplay: UITextView!

 
    @IBOutlet weak var NumCard: UITextField!
    @IBOutlet weak var HardSR: UITextView!
    @IBOutlet weak var MediumSR: UITextView!
    @IBOutlet weak var EasySR: UITextView!
    
    var OurTimer = Timer()
    

    var EnglishCard = String()
    var FrenchCard = String()
    var FrenchC = ""
    var EnglishC = ""
    var cardNum = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var i = 1
        
        while i < 1000
        {
            if UserDefaults.standard.object(forKey: "SR\(i)") == nil
            {
                UserDefaults.standard.set(0, forKey: "SR\(i)") // 5 settings 0 = fail 1 = hard 2 = Meduim 3 = Easy 4 = not decided yet but for now 0 and 5 will be the same
            }
           
            i += 1
        }
        
        var y = 1
        
        while y < 1000
        {
            if UserDefaults.standard.object(forKey: "Y\(y)") == nil
            {
                UserDefaults.standard.set(0, forKey: "Y\(y)")
            }
           
            y += 1
        }
        
        var m = 1
        
        while m < 1000
        {
            if UserDefaults.standard.object(forKey: "M\(m)") == nil
            {
                UserDefaults.standard.set(0, forKey: "M\(m)")
            }
           
            m += 1
        }
        
        var d = 1
        
        while d < 1000
        {
            if UserDefaults.standard.object(forKey: "D\(d)") == nil
            {
                UserDefaults.standard.set(0, forKey: "D\(d)")
            }
           
            d += 1
        }
        
        var h = 1
        
        while h < 1000
        {
            if UserDefaults.standard.object(forKey: "H\(h)") == nil
            {
                UserDefaults.standard.set(0, forKey: "H\(h)")
            }
           
            h += 1
        }
        
        var min = 1
        while min < 1000
        {
            if UserDefaults.standard.object(forKey: "Min\(min)") == nil
            {
                UserDefaults.standard.set(0, forKey: "Min\(min)")
            }
           
            min += 1
        }
        var I = 1
        while min < 1000
        {
            if UserDefaults.standard.object(forKey: "LastIncriment\(I)") == nil
            {
                UserDefaults.standard.set(1, forKey: "LastIncriment\(I)")
            }
           
            I += 1
        }
        
    }
    
    @IBAction func ShowCard(_ sender: Any) {
        
        cardNum = Int(NumCard.text!) ?? 0
        
        getDateComponents()

            if UserDefaults.standard.integer(forKey: "SR\(cardNum)") == 0
            {
               
                print(cardNum)
                FrontCardDisplay.text = UserDefaults.standard.object(forKey: "savedFCard\(cardNum)") as? String
                BackCardDisplay.text = ""
            }
            else
            {
                print(cardNum)
                FrontCardDisplay.text = ""
                BackCardDisplay.text = ""
            }
        if UserDefaults.standard.integer(forKey: "LastIncriment\(cardNum)") == 0 && UserDefaults.standard.object(forKey: "savedFCard\(cardNum)") as? String != ""
        {
            UserDefaults.standard.set(0, forKey: "LastIncriment\(cardNum)")
        }
        HardSR.text = "+ \(UserDefaults.standard.integer(forKey: "LastIncriment\(cardNum)") * 1)"
        MediumSR.text = "+ \(UserDefaults.standard.integer(forKey: "LastIncriment\(cardNum)") * 2)"
        EasySR.text = "+ \(UserDefaults.standard.integer(forKey: "LastIncriment\(cardNum)") * 3)"
        
    }
    
    @IBAction func NextCard(_ sender: Any) {
        
        cardNum += 1
        randCheckForEndCard = 0
        
        getDateComponents()
        
        if UserDefaults.standard.object(forKey: "savedFCard\(cardNum)") as? String == "" || UserDefaults.standard.object(forKey: "savedFCard\(cardNum)") as? String == nil
        {
            print("I set it")
            cardNum = 1
        }
        while UserDefaults.standard.integer(forKey: "SR\(cardNum)") != 0
        {
            cardNum += 1
        }
        if randCheckForEndCard == 1
        {
            cardNum += 1
        }
        
        if UserDefaults.standard.object(forKey: "savedFCard\(cardNum)") as? String == "" || UserDefaults.standard.object(forKey: "savedFCard\(cardNum)") as? String == nil
        {
            print("I set it")
            cardNum = 1
        }
      
        NextorPreviousCard()
        
        
        
    }
    
    @IBAction func PreviousCard(_ sender: Any) {
        cardNum -= 1
        
        getDateComponents()

        while UserDefaults.standard.integer(forKey: "SR\(cardNum)") != 0
        {
            cardNum -= 1
        }
        NextorPreviousCard()
        
    }
    @IBAction func ShowBack(_ sender: Any) {
        
        getDateComponents()
        
        if UserDefaults.standard.integer(forKey: "SR\(cardNum)") == 0
        {
            BackCardDisplay.text = UserDefaults.standard.object(forKey: "savedBCard\(cardNum)") as? String
        }
        else
        {
            BackCardDisplay.text = "" 
        }
        HardSR.text = "+ \(UserDefaults.standard.integer(forKey: "LastIncriment\(cardNum)") * 1)"
        MediumSR.text = "+ \(UserDefaults.standard.integer(forKey: "LastIncriment\(cardNum)") * 2)"
        EasySR.text = "+ \(UserDefaults.standard.integer(forKey: "LastIncriment\(cardNum)") * 3)"
        
    }
    
    
    @IBAction func FailedCard(_ sender: Any) {
        
        getDateComponents()
         
        if UserDefaults.standard.object(forKey: "savedFCard\(cardNum)") as? String == "" || UserDefaults.standard.object(forKey: "savedFCard\(cardNum)") as? String == nil
        {
            cardNum = 1
        }
        while UserDefaults.standard.integer(forKey: "SR\(cardNum)") != 0
        {
            cardNum += 1
        }
        if UserDefaults.standard.integer(forKey: "SR\(cardNum)") == 0
        {
            FrontCardDisplay.text = UserDefaults.standard.object(forKey: "savedFCard\(cardNum)") as? String
            BackCardDisplay.text = ""
            
        }
        else
        {
            FrontCardDisplay.text = ""
            BackCardDisplay.text = ""
        }
        if UserDefaults.standard.integer(forKey: "LastIncriment\(cardNum)") == 0 && UserDefaults.standard.object(forKey: "savedFCard\(cardNum)") as? String != "" && UserDefaults.standard.object(forKey: "savedFCard\(cardNum)") != nil
        {
            UserDefaults.standard.set(1, forKey: "LastIncriment\(cardNum)")
        }
        NumCard.text = String(cardNum)
        HardSR.text = "+ \(UserDefaults.standard.integer(forKey: "LastIncriment\(cardNum)") * 1)"
        MediumSR.text = "+\(UserDefaults.standard.integer(forKey: "LastIncriment\(cardNum)") * 2)"
        EasySR.text = "+ \(UserDefaults.standard.integer(forKey: "LastIncriment\(cardNum)") * 3)"
        
    }
    
    @IBAction func HardCard(_ sender: Any) {
       
        getDifficultyLevel(incriment: 1)
    
    }
    
    @IBAction func MediumCard(_ sender: Any) {
        
        getDifficultyLevel(incriment: 2)
        
    }
    
    @IBAction func EasyCard(_ sender: Any) {
        
        getDifficultyLevel(incriment: 3)
    }
    
    func getDateComponents()
    {
        let date = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        
        if UserDefaults.standard.integer(forKey: "Y\(cardNum)") < year
        {
            print("at Year")
            UserDefaults.standard.set(0, forKey: "SR\(cardNum)")
        }
        else if UserDefaults.standard.integer(forKey: "Y\(cardNum)") == year
        {
            if UserDefaults.standard.integer(forKey: "M\(cardNum)") < month
            {
                print("at month")
                UserDefaults.standard.set(0, forKey: "SR\(cardNum)")
            }
            else if UserDefaults.standard.integer(forKey: "M\(cardNum)") == month
            {
                if UserDefaults.standard.integer(forKey: "D\(cardNum)") < day
                {
                    print("at day")
                    UserDefaults.standard.set(0, forKey: "SR\(cardNum)")
                }
                else if UserDefaults.standard.integer(forKey: "D\(cardNum)") == day
                {
                    if UserDefaults.standard.integer(forKey: "H\(cardNum)") < hour
                    {
                        print("at hour")
                        UserDefaults.standard.set(0, forKey: "SR\(cardNum)")
                    }
                    else if UserDefaults.standard.integer(forKey: "H\(cardNum)") == hour
                    {
                        if UserDefaults.standard.integer(forKey: "Min\(cardNum)") < minutes
                        {
                            print("at minutes")
                            UserDefaults.standard.set(0, forKey: "SR\(cardNum)")
                        }
                    }
                    else
                    {
                        randCheckForEndCard = 1
                        print("yessirrr")
                    }
                }
            }
        }
    }
    
    func getDifficultyLevel(incriment: Int)
    {
        UserDefaults.standard.set(incriment, forKey: "SR\(cardNum)")
        let date = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        print("year: \(year) month: \(month)  day: \(day)   hour: \(hour)   minutes: \(minutes)")
        var newMin = minutes
        var newH = hour
        var newD = day
        var newM = month
        var newY = year
        let addTo = UserDefaults.standard.integer(forKey: "LastIncriment\(cardNum)")
        UserDefaults.standard.set((addTo * 3), forKey: "LastIncriment\(cardNum)")
        if newMin + (incriment * addTo) >= 60
        {
            newMin = 0
            newH = hour + 1
            if newH >= 24
            {
                newH = 0
                newD = day + 1
             // have to make it specific to each month
            }
        }
        else
        {
            newMin += incriment * addTo
        }
        UserDefaults.standard.set(newY, forKey: "Y\(cardNum)")
        UserDefaults.standard.set(newM, forKey: "M\(cardNum)")
        UserDefaults.standard.set(newD, forKey: "D\(cardNum)")
        UserDefaults.standard.set(newH, forKey: "H\(cardNum)")
        UserDefaults.standard.set(newMin, forKey: "Min\(cardNum)")
        cardNum += 1
        
        
        if UserDefaults.standard.integer(forKey: "Y\(cardNum)") < year
        {
            print("at Year")
            UserDefaults.standard.set(0, forKey: "SR\(cardNum)")
        }
        else if UserDefaults.standard.integer(forKey: "Y\(cardNum)") == year
        {
            if UserDefaults.standard.integer(forKey: "M\(cardNum)") < month
            {
                print("at month")
                UserDefaults.standard.set(0, forKey: "SR\(cardNum)")
            }
            else if UserDefaults.standard.integer(forKey: "M\(cardNum)") == month
            {
                if UserDefaults.standard.integer(forKey: "D\(cardNum)") < day
                {
                    print("at day")
                    UserDefaults.standard.set(0, forKey: "SR\(cardNum)")
                }
                else if UserDefaults.standard.integer(forKey: "D\(cardNum)") == day
                {
                    if UserDefaults.standard.integer(forKey: "H\(cardNum)") < hour
                    {
                        print("at hour")
                        UserDefaults.standard.set(0, forKey: "SR\(cardNum)")
                    }
                    else if UserDefaults.standard.integer(forKey: "H\(cardNum)") == hour
                    {
                        if UserDefaults.standard.integer(forKey: "Min\(cardNum)") < minutes
                        {
                            print("at minutes")
                            UserDefaults.standard.set(0, forKey: "SR\(cardNum)")
                        }
                    }
                }
            }
        }
        if UserDefaults.standard.object(forKey: "savedFCard\(cardNum)") as? String == "" || UserDefaults.standard.object(forKey: "savedFCard\(cardNum)") as? String == nil
        {
            cardNum = 1
        }
        while UserDefaults.standard.integer(forKey: "SR\(cardNum)") != 0
        {
            cardNum += 1
        }
        if UserDefaults.standard.integer(forKey: "SR\(cardNum)") == 0
        {
            FrontCardDisplay.text = UserDefaults.standard.object(forKey: "savedFCard\(cardNum)") as? String
            BackCardDisplay.text = ""
            
        }
        else
        {
            FrontCardDisplay.text = ""
            BackCardDisplay.text = ""
        }
        if UserDefaults.standard.integer(forKey: "LastIncriment\(cardNum)") == 0 && UserDefaults.standard.object(forKey: "savedFCard\(cardNum)") as? String != "" && UserDefaults.standard.object(forKey: "savedFCard\(cardNum)") != nil
        {
            UserDefaults.standard.set(1, forKey: "LastIncriment\(cardNum)")
        }
        NumCard.text = String(cardNum)
        HardSR.text = "+ \(UserDefaults.standard.integer(forKey: "LastIncriment\(cardNum)") * 1)"
        MediumSR.text = "+\(UserDefaults.standard.integer(forKey: "LastIncriment\(cardNum)") * 2)"
        EasySR.text = "+ \(UserDefaults.standard.integer(forKey: "LastIncriment\(cardNum)") * 3)"
        
        
    }
    
    func NextorPreviousCard()
    {
        if UserDefaults.standard.integer(forKey: "SR\(cardNum)") == 0
        {
            FrontCardDisplay.text = UserDefaults.standard.object(forKey: "savedFCard\(cardNum)") as? String
            BackCardDisplay.text = ""
            
        }
        else
        {
            FrontCardDisplay.text = ""
            BackCardDisplay.text = ""
        }
        if UserDefaults.standard.integer(forKey: "LastIncriment\(cardNum)") == 0 && UserDefaults.standard.object(forKey: "savedFCard\(cardNum)") as? String != "" && UserDefaults.standard.object(forKey: "savedFCard\(cardNum)") != nil
        {
            UserDefaults.standard.set(1, forKey: "LastIncriment\(cardNum)")
        }
        NumCard.text = String(cardNum)
        HardSR.text = "+ \(UserDefaults.standard.integer(forKey: "LastIncriment\(cardNum)") * 1)"
        MediumSR.text = "+\(UserDefaults.standard.integer(forKey: "LastIncriment\(cardNum)") * 2)"
        EasySR.text = "+ \(UserDefaults.standard.integer(forKey: "LastIncriment\(cardNum)") * 3)"
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        NumCard.resignFirstResponder()
    
    }

}

