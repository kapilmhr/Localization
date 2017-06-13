//
//  LanguageViewController.swift
//  coredata
//
//  Created by Frantic on 5/27/17.
//  Copyright © 2017 Frantic. All rights reserved.
//

import UIKit

class LanguageViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(LanguageViewController.receiveLanguageChangedNotification(notification:)), name: kNotificationLanguageChanged, object: nil)


        // Do any additional setup after loading the view.
//        for languageCode in Bundle.main.localizations.filter({ $0 != "Base" }) {
//            print(languageCode)
//            let langName = Locale.current.localizedString(forLanguageCode: languageCode)
//           print(langName)
//        }
//        label.text = NSLocalizedString("title_screen", comment: "ttit")
        configureViewFromLocalisation()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.

    }
    
    func receiveLanguageChangedNotification(notification:NSNotification) {
        if notification.name == kNotificationLanguageChanged {
            configureViewFromLocalisation()
        }
    }
    
    func configureViewFromLocalisation() {
        label.text = Localization("title_screen")
    }
    
    @IBAction func selectEnglish(_ sender: UIButton) {
        //changeToLanguage("en")
        
        SetLanguage("English_en")
        configureViewFromLocalisation()


        //label.text = LanguageManager.sharedInstance.LocalizedLanguage(key: "title_screen", languageCode: "es")

        //label.text = NSLocalizedString("title_screen", comment: "ttit")
        
    }

    @IBAction func selectNepali(_ sender: UIButton) {
        //changeToLanguage("ne")
        //label.text = NSLocalizedString("title_screen", comment: "ttit")
        SetLanguage("Nepali_ne")
        configureViewFromLocalisation()
        //label.text = LanguageManager.sharedInstance.LocalizedLanguage(key: "title_screen", languageCode: "ne")

    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: kNotificationLanguageChanged, object: nil)
    }
    
    private func changeToLanguage(_ langCode: String) {
        if Bundle.main.preferredLocalizations.first != langCode {
            let message = "In order to change the language, the App must be closed and reopened by you."
            let confirmAlertCtrl = UIAlertController(title: "App restart required", message: message, preferredStyle: .alert)
            
            let confirmAction = UIAlertAction(title: "Close now", style: .destructive) { _ in
                UserDefaults.standard.set([langCode], forKey: "AppleLanguages")
                UserDefaults.standard.synchronize()
                exit(EXIT_SUCCESS)
            }
            confirmAlertCtrl.addAction(confirmAction)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            confirmAlertCtrl.addAction(cancelAction)
            
            present(confirmAlertCtrl, animated: true, completion: nil)
        }
    }


}

class LanguageManager
{
    
    static let sharedInstance =  LanguageManager()
    
    //Make a function for Localization. Language Code is the one which we will be deciding on button click.
    func LocalizedLanguage(key:String,languageCode:String)->String{
        
        //Make sure you have Localizable bundles for specific languages.
        var path = Bundle.main.path(forResource: languageCode, ofType: "lproj")
        
        //Check if the path is nil, make it as "" (empty path)
        path = (path != nil ? path:"")
        
        let languageBundle:Bundle!
        
        if(FileManager.default.fileExists(atPath: path!)){
            languageBundle = Bundle(path: path!)
            return languageBundle!.localizedString(forKey: key, value: "", table: nil)
        }else{
            // If path not found, make English as default
            path = Bundle.main.path(forResource: "en", ofType: "lproj")
            languageBundle = Bundle(path: path!)
            return languageBundle!.localizedString(forKey: key, value: "", table: nil)
        }
    }
}
