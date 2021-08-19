//
//  ViewController.swift
//  CurrencyConverterApp
//
//  Created by Semih Kalaycı on 19.08.2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var cadLabel: UILabel!
    @IBOutlet weak var chfLabel: UILabel!
    @IBOutlet weak var gbpLabel: UILabel!
    @IBOutlet weak var jpyLabel: UILabel!
    @IBOutlet weak var usdLabel: UILabel!
    @IBOutlet weak var tryLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func getRatesClicked(_ sender: Any) {

        //1- Request & Session apiye git
        //2- Restonse & Data datayı çek
        //3- Parsing & JSOn Serialization veriyi işle
        
        // - inf.plist e gir ve herhangi bir yere App Transport Security Settings ekle
        // - daha sonra sol taraında çıkan oka tıkla ve ok açağı bakacak şekle gelsin
        // - App Transport Security Settings in yanındaki ekleme butonundan
        // - Allow Arbitrary Loads ekle ve value yu yes yap bu sayede veri alışverişi için izin verilmiş olacak
        
        // 1. adım
        let url = URL(string: "http://data.fixer.io/api/latest?access_key=53a5cda331484f4c1ca7733e47a08298&format=1")
        
        let session = URLSession.shared
        //Closure
        let task = session.dataTask(with: url!) { (data, response, error) in //closure olduğu için bize bunları dönecek ve istediğimiz ismi verebiliriz içeride kulanmak için
            
            if error != nil{
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okBtn = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okBtn)
                self.present(alert, animated: true, completion: nil)
                
         
                
            }else{
                // 2. adım
                if data != nil{
                    
                    do {
                        let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String,Any> // ilkis tring çünkü title 2.si any çünkü listede var stringte var intte var
                        
                        DispatchQueue.main.async {
                          //  print(jsonResponse["rates"]) // title yaz value getirsin
                            
                            if let rates = jsonResponse["rates"] as? [String:Any]{
                                
                                //print(rates)
                                
                                if let cad = rates["CAD"] as? Double {
                                    self.cadLabel.text = "CAD: \(cad)"
                                }
                                if let chf = rates["CHF"] as? Double {
                                    self.chfLabel.text = "CHF: \(chf)"
                                }
                                if let GBP = rates["GBP"] as? Double {
                                    self.gbpLabel.text = "GBP: \(GBP)"
                                }
                                if let JPY = rates["JPY"] as? Double {
                                    self.jpyLabel.text = "JPY: \(JPY)"
                                }
                                if let USD = rates["USD"] as? Double {
                                    self.usdLabel.text = "USD: \(USD)"
                                }
                                if let TRY = rates["TRY"] as? Double {
                                    self.tryLabel.text = "TRY: \(TRY)"
                                }
                           

                    
                                
                            }
                        }
                        
                        
                    } catch  {
                        print("Veri çekme hatası")
                        
                    }
                    
                    
                    
                }
                
                
            }
        }
        
        task.resume()
        
        
        
    }
    
}

