//
//  SecondViewController.swift
//  Bowler
//
//  Created by Charles Sicard on 01/05/2018.
//  Copyright © 2018 Charles Sicard. All rights reserved.
//

import UIKit
import SwiftOSC


class ThridViewController: UIViewController {
    
    
    //------ Slider Outlets -------
    
    
    @IBOutlet weak var zone2Fad1: UISlider!
    @IBOutlet weak var zone2Fad2: UISlider!
    @IBOutlet weak var zone2Fad3: UISlider!
    @IBOutlet weak var zone2Fad4: UISlider!
    @IBOutlet weak var zone2Fad5: UISlider!
    @IBOutlet weak var zone2Fad6: UISlider!
    
    
    //------ Labels Outlets -------
    

    @IBOutlet weak var labelZone2: UILabel!
    
    //------ Switch Outlets -------
    
    @IBOutlet weak var zone1zone22: UISwitch!
    
    @IBOutlet weak var zone2Sw1: UISwitch!
    @IBOutlet weak var zone2Sw2: UISwitch!
    @IBOutlet weak var zone2Sw3: UISwitch!
    @IBOutlet weak var zone2Sw4: UISwitch!
    @IBOutlet weak var zone2Sw5: UISwitch!
    
    
    @objc func requestFaderUpdateZone2() {
        
        
        let fader201 = OSCMessage(OSCAddressPattern("/rtn/1/mix/01/level"))
        print("Send Packet : \(fader201)")
        client.send(fader201)
        
        
        let fader202 = OSCMessage(OSCAddressPattern("/rtn/2/mix/01/level"))
        print("Send Packet : \(fader202)")
        client.send(fader202)
        
        
        let fader203 = OSCMessage(OSCAddressPattern("/rtn/3/mix/01/level"))
        print("Send Packet : \(fader203)")
        client.send(fader203)
        
        
        let fader204 = OSCMessage(OSCAddressPattern("/rtn/4/mix/01/level"))
        print("Send Packet : \(fader204)")
        client.send(fader204)
        
        
        let fader205 = OSCMessage(OSCAddressPattern("/ch/09/mix/01/level"))
        print("Send Packet : \(fader205)")
        client.send(fader205)
        
        
        let zone2 = OSCMessage(OSCAddressPattern("/routing/aux/01"))
        print("Send Packet : \(zone2)")
        client.send(zone2)
    }
    
    
    override func viewDidLoad() {
    
        super.viewDidLoad()
        
        
        //Sburscribe to notification for Zone2
        NotificationCenter.default.addObserver(self, selector: #selector(updateFaderZone2(notification:)), name: NSNotification.Name.fader201, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateFaderZone2(notification:)), name: NSNotification.Name.fader202, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateFaderZone2(notification:)), name: NSNotification.Name.fader203, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateFaderZone2(notification:)), name: NSNotification.Name.fader204, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateFaderZone2(notification:)), name: NSNotification.Name.fader205, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateFaderZone2(notification:)), name: NSNotification.Name.zone1zone2, object: nil)
        
        
        //Initial request for fader
        requestFaderUpdateZone2()

        //Repeat every 10 secs
        var timer2 = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(requestFaderUpdateZone2), userInfo: nil, repeats: true)
        
        // Do any additional setup after loading the view, typically from a nib.
    
        
        if (zone1zone22.isOn == true) {
            zone2Fad1.isEnabled = false
            zone2Fad2.isEnabled = false
            zone2Fad3.isEnabled = false
            zone2Fad4.isEnabled = false
            zone2Fad5.isEnabled = false
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //------ Sliders Actions -------
    
    // FX Engines FX1...4 Fader 27...30
    
    
    @IBAction func zone2Fad1Action(_ sender: UISlider) {
        fader(1,101,roundme(sender.value))
    }
    @IBAction func zone2Fad2Action(_ sender: UISlider) {
        fader(1,102,roundme(sender.value))
    }
    @IBAction func zone2Fad3Action(_ sender: UISlider) {
        fader(1,103,roundme(sender.value))
    }
    @IBAction func zone2Fad4Action(_ sender: UISlider) {
        fader(1,104,roundme(sender.value))
    }
    @IBAction func zone2Fad5Action(_ sender: UISlider) {
        fader(1,9,roundme(sender.value))
    }
    @IBAction func zone2Fad6Action(_ sender: UISlider) {
        fader(1,0,roundme(sender.value))
    }
    
    
    //------ Switch Actions -------
    
    
    @IBAction func zone1zone2Action2(_ sender: UISwitch) {
        if (sender.isOn == true){
            output(1,36)
            zone2Fad1.isEnabled = false
            zone2Fad2.isEnabled = false
            zone2Fad3.isEnabled = false
            zone2Fad4.isEnabled = false
            zone2Fad5.isEnabled = false
        }
        else{
            output(1,26)
            zone2Fad1.isEnabled = true
            zone2Fad2.isEnabled = true
            zone2Fad3.isEnabled = true
            zone2Fad4.isEnabled = true
            zone2Fad5.isEnabled = true
        }
    }
    
    
    
    @IBAction func zone2Sw1Action(_ sender: UISwitch) {
        muteunmute(sender, 1, 1)
    }
    @IBAction func zone2Sw2Action(_ sender: UISwitch) {
        muteunmute(sender, 1, 3)
    }
    @IBAction func zone2Sw3Action(_ sender: UISwitch) {
        muteunmute(sender, 1, 5)
    }
    @IBAction func zone2Sw4Action(_ sender: UISwitch) {
        //muteunmute(sender, 1, 7)
        requestFaderUpdateZone2()
        
    }
    @IBAction func zone2Sw5Action(_ sender: UISwitch) {
        //muteunmute(sender, 1, 9)
        let test201 = OSCMessage(OSCAddressPattern("/rtn/1/mix/01/level"),0.95)
        print("Send Packet : \(test201)")
        client.send(test201)
        let test202 = OSCMessage(OSCAddressPattern("/rtn/2/mix/01/level"),0.85)
        print("Send Packet : \(test202)")
        client.send(test202)
        let test203 = OSCMessage(OSCAddressPattern("/rtn/3/mix/01/level"),0.75)
        print("Send Packet : \(test203)")
        client.send(test203)
        let test204 = OSCMessage(OSCAddressPattern("/rtn/4/mix/01/level"),0.65)
        print("Send Packet : \(test204)")
        client.send(test204)
        let test205 = OSCMessage(OSCAddressPattern("/ch/09/mix/01/level"),0.55)
        print("Send Packet : \(test205)")
        client.send(test205)
        
        let testzone2 = OSCMessage(OSCAddressPattern("/routing/aux/01"),26)
        print("Send Packet : \(testzone2)")
        client.send(testzone2)
    }
    
    @objc dynamic func updateFaderZone2(notification: Notification){
    
    if (notification.name == NSNotification.Name.fader201) {
        if let level = notification.userInfo?["zone2Fad1"] as? Float32 { zone2Fad1.value = level }
    //NotificationCenter.default.removeObserver(self, name: NSNotification.Name("fader201"), object: nil)
    }
    if (notification.name == NSNotification.Name.fader202) {
        if let level = notification.userInfo?["zone2Fad2"] as? Float32 { zone2Fad2.value = level }
    //NotificationCenter.default.removeObserver(self, name: NSNotification.Name("fader202"), object: nil)
    }
    
    if (notification.name == NSNotification.Name.fader203) {
        if let level = notification.userInfo?["zone2Fad3"] as? Float32 { zone2Fad3.value = level }
   // NotificationCenter.default.removeObserver(self, name: NSNotification.Name("fader203"), object: nil)
    }
    
    if (notification.name == NSNotification.Name.fader204) {
        if let level = notification.userInfo?["zone2Fad4"] as? Float32 { zone2Fad4.value = level }
   // NotificationCenter.default.removeObserver(self, name: NSNotification.Name("fader204"), object: nil)
    }
    
    if (notification.name == NSNotification.Name.fader205) {
        if let level = notification.userInfo?["zone2Fad5"] as? Float32 { zone2Fad5.value = level }
   // NotificationCenter.default.removeObserver(self, name: NSNotification.Name("fader205"), object: nil)
    
    }
    
    if (notification.name == NSNotification.Name.zone1zone2) {

        if let level = notification.userInfo?["zone2"] as? Int {

            if (level == 26) {
                zone1zone22.isOn = false
                zone2Fad1.isEnabled = true
                zone2Fad2.isEnabled = true
                zone2Fad3.isEnabled = true
                zone2Fad4.isEnabled = true
                zone2Fad5.isEnabled = true
            }
            else if (level == 36) {
                zone1zone22.isOn = true
                zone2Fad1.isEnabled = false
                zone2Fad2.isEnabled = false
                zone2Fad3.isEnabled = false
                zone2Fad4.isEnabled = false
                zone2Fad5.isEnabled = false
            } }
    //NotificationCenter.default.removeObserver(self, name: NSNotification.Name("zone1zone2"), object: nil)
    
    }
    }
    
}

