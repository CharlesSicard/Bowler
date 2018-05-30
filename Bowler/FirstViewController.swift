//
//  FirstViewController.swift
//  Bowler
//
//  Created by Charles Sicard on 01/05/2018.
//  Copyright © 2018 Charles Sicard. All rights reserved.
//

import UIKit
import SwiftWebSocket

func serialize(_ longstring: String) -> String {
    let data = (longstring).data(using: String.Encoding.utf8)
    let base64 = data!.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
    return base64
}


// Define Settings from iOS Settings
let iptv1 = UserDefaults.standard.string(forKey: "iptv1") ?? "192.168.0.101"
let iptv2 = UserDefaults.standard.string(forKey: "iptv2") ?? "192.168.0.102"
let iptv3 = UserDefaults.standard.string(forKey: "iptv3") ?? "192.168.0.103"
let iptv4 = UserDefaults.standard.string(forKey: "iptv4") ?? "192.168.0.104"
let iptv5 = UserDefaults.standard.string(forKey: "iptv5") ?? "192.168.0.105"
let iptv6 = UserDefaults.standard.string(forKey: "iptv6") ?? "192.168.0.106"
let ipxr = UserDefaults.standard.string(forKey: "ipxr") ?? "192.168.0.120"

var name = serialize("iOS Device")

class FirstViewController: UIViewController {

    // Fonction qui gère le changement de chaine
    func pressKey(_ ip: String, _ key: String) {
        //Nom de l'appli
        let name = "samsungctl"
        //Ouverture du socket
        let ws = WebSocket("ws://\(ip):8001/api/v2/channels/samsung.remote.control?name=\(serialize(name))")
        print("ws://\(ip):8001/api/v2/channels/samsung.remote.con")
        //On fabrique le packet à envoyer
        let json = "{\"method\": \"ms.remote.control\", \"params\": {\"Cmd\": \"Click\", \"DataOfCmd\": \"\(key)\", \"Option\": \"false\", \"TypeOfRemote\": \"SendRemoteKey\"}}"
        //On envoi
        ws.send(json)
        
        //Fonction pour gérer les retours d'info
        ws.event.open = {
            print("opened")
            //send()
        }
        ws.event.close = { code, reason, clean in
            print("close")
        }
        ws.event.error = { error in
            print("error \(error)")
            // Lets Display the error
            let alertController = UIAlertController(title: "Error TV \(ip)", message:
                "Cannot reach TV, TV Off ? Wrong Wifi ? \n\nError Message : \(error)", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
        }
        
        
        ws.event.message = { message in
            if let text = message as? String {
                print("recv: \(text)")
                }
            }
            ws.close()
        }
    

    
    //Déclaration des valeurs des switchs
    @IBOutlet weak var switchTV1: UISegmentedControl!
    
    @IBOutlet weak var switchTV2: UISegmentedControl!
    
    @IBOutlet weak var switchTV3: UISegmentedControl!
    
    @IBOutlet weak var switchTV4: UISegmentedControl!
    
    @IBOutlet weak var switchTV5: UISegmentedControl!
    
    @IBOutlet weak var switchTV6: UISegmentedControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        UserDefaults.standard.register(defaults: [String : Any]())
        print("Settings Bundle : IP TV1 : \(iptv1)")
        print("Settings Bundle : IP TV2 : \(iptv2)")
        print("Settings Bundle : IP TV3 : \(iptv3)")
        print("Settings Bundle : IP TV4 : \(iptv4)")
        print("Settings Bundle : IP TV5 : \(iptv5)")
        print("Settings Bundle : IP TV6 : \(iptv6)")
        print("Settings Bundle : IP XR : \(ipxr)")
    }



    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //Switch1 bouge, on agit
    @IBAction func switch1Action(_ sender: UISegmentedControl) {
        let switched = sender.selectedSegmentIndex
        if(switched == 0)
        {
            pressKey(iptv1, "KEY_1")
        }
        else if(switched == 1)
        {
            pressKey(iptv1, "KEY_2")
        }
        else if(switched == 2)
        {
            pressKey(iptv1, "KEY_3")
        }
        else if(switched == 3)
        {
            pressKey(iptv1, "KEY_4")
        }
        else if(switched == 4)
        {
            pressKey(iptv1, "KEY_POWER")
        }

        
    }
    
    //Switch2 bouge, on agit
    @IBAction func switch2Action(_ sender: UISegmentedControl) {
        let switched = sender.selectedSegmentIndex
        if(switched == 0)
        {
            pressKey(iptv2, "KEY_1")
        }
        else if(switched == 1)
        {
            pressKey(iptv2, "KEY_2")
        }
        else if(switched == 2)
        {
            pressKey(iptv2, "KEY_3")
        }
        else if(switched == 3)
        {
            pressKey(iptv2, "KEY_4")
        }
        else if(switched == 4)
        {
            pressKey(iptv2, "KEY_POWER")
        }
    }
    
    //Switch3 bouge, on agit
    @IBAction func switch3Action(_ sender: UISegmentedControl) {
        let switched = sender.selectedSegmentIndex
        if(switched == 0)
        {
            pressKey(iptv3, "KEY_1")
        }
        else if(switched == 1)
        {
            pressKey(iptv3, "KEY_2")
        }
        else if(switched == 2)
        {
            pressKey(iptv3, "KEY_3")
        }
        else if(switched == 3)
        {
            pressKey(iptv3, "KEY_4")
        }
        else if(switched == 4)
        {
            pressKey(iptv3, "KEY_POWER")
        }
    }
    
    //Switch4 bouge, on agit
    @IBAction func switch4Action(_ sender: UISegmentedControl) {
        let switched = sender.selectedSegmentIndex
        if(switched == 0)
        {
            pressKey(iptv4, "KEY_1")
        }
        else if(switched == 1)
        {
            pressKey(iptv4, "KEY_2")
        }
        else if(switched == 2)
        {
            pressKey(iptv4, "KEY_3")
        }
        else if(switched == 3)
        {
            pressKey(iptv4, "KEY_4")
        }
        else if(switched == 4)
        {
            pressKey(iptv4, "KEY_POWER")
        }
        
    }
    
    //Switch5 bouge, on agit
    @IBAction func switch5Action(_ sender: UISegmentedControl) {
        let switched = sender.selectedSegmentIndex
        if(switched == 0)
        {
            pressKey(iptv5, "KEY_1")
        }
        else if(switched == 1)
        {
            pressKey(iptv5, "KEY_2")
        }
        else if(switched == 2)
        {
            pressKey(iptv5, "KEY_3")
        }
        else if(switched == 3)
        {
            pressKey(iptv5, "KEY_4")
        }
        else if(switched == 4)
        {
            pressKey(iptv5, "KEY_POWER")
        }
        
    }
    
    //Switch4 bouge, on agit
    @IBAction func switch6Action(_ sender: UISegmentedControl) {
        let switched = sender.selectedSegmentIndex
        if(switched == 0)
        {
            pressKey(iptv6, "KEY_1")
        }
        else if(switched == 1)
        {
            pressKey(iptv6, "KEY_2")
        }
        else if(switched == 2)
        {
            pressKey(iptv6, "KEY_3")
        }
        else if(switched == 3)
        {
            pressKey(iptv6, "KEY_4")
        }
        else if(switched == 4)
        {
            pressKey(iptv6, "KEY_POWER")
        }
        
    }

}

