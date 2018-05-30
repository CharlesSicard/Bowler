//
//  SecondViewController.swift
//  Bowler
//
//  Created by Charles Sicard on 01/05/2018.
//  Copyright © 2018 Charles Sicard. All rights reserved.
//

import UIKit
import SwiftOSC


// OSC setup
let ip_xair = ipxr
let port_xair:Int = 10024

//let ip_xair = "localhost"
//let port_xair:Int = 50500

//var server = OSCServer(address: "", port: 10024)
let client = OSCClient(address: ip_xair, port: port_xair)


func roundme(_ num:Float) -> Float {
    let result = (num * 100).rounded() / 100
    return result
}

enum onoff : String {
    case ON, OFF
}

func mute(_ bus:Int, _ channel:Int) {
    // Mute a channel
    if (bus == 0) {
        // We work Master LR Bus -- TESTING
            let packet = OSCMessage(OSCAddressPattern("/ch/\(String(format: "%02d", channel))/mix/on"),1)
            print("Send Packet : \(packet)")
            client.send(packet)
        } else {
        //  -- TESTING
            let packet = OSCMessage(OSCAddressPattern("/ch/\(String(format: "%02d", channel))/mix/\(bus)/on"),1)
            print("Send Packet : \(packet)")
            client.send(packet)
    }
}

func unmute(_ bus:Int, _ channel:Int) {
    // Unmute a channel
    if (bus == 0) {
        // We work Master LR Bus -- TESTING
        let packet = OSCMessage(OSCAddressPattern("/ch/\(String(format: "%02d", channel))/mix/on"),0)
        print("Send Packet : \(packet)")
        client.send(packet)
    } else {
        // -- TESTING
        let packet = OSCMessage(OSCAddressPattern("/ch/\(String(format: "%02d", channel))/mix/\(bus)/on"),0)
        print("Send Packet : \(packet)")
        client.send(packet)
    }
}

func fader(_ bus:Int, _ channel:Int, _ value:Float) {
    // Move fader on a channel
    if (bus == 0) {
        // We work Master LR Bus
        if (channel == 0) {
            // We work Master level -- TESTING
            let packet = OSCMessage(OSCAddressPattern("/lr/mix/fader"),value)
            print("Send Packet : \(packet)")
            client.send(packet)
        } else if (channel == 101) {
            // FX1
            let packet = OSCMessage(OSCAddressPattern("/rtn/1/mix/fader"),value)
            print("Send Packet : \(packet)")
            client.send(packet)
        } else if (channel == 102) {
            // FX2
            let packet = OSCMessage(OSCAddressPattern("/rtn/2/mix/fader"),value)
            print("Send Packet : \(packet)")
            client.send(packet)
        } else if (channel == 103) {
            // FX3
            let packet = OSCMessage(OSCAddressPattern("/rtn/3/mix/fader"),value)
            print("Send Packet : \(packet)")
            client.send(packet)
        } else if (channel == 104) {
            // FX4
            let packet = OSCMessage(OSCAddressPattern("/rtn/4/mix/fader"),value)
            print("Send Packet : \(packet)")
            client.send(packet)
        } else {
            // We work Channel level -- WORKING
            let packet = OSCMessage(OSCAddressPattern("/ch/\(String(format: "%02d", channel))/mix/fader"),value)
            //let packet = OSCMessage(OSCAddressPattern("/rtn/1/mix/fader"),value)
            print("Send Packet : \(packet)")
            client.send(packet)
        }
    } else {
        if (channel == 0) {
            // We work Master level -- TESTING
            let packet = OSCMessage(OSCAddressPattern("/bus/\(String(format: "%02d", bus))/mix/fader"),value)
            print("Send Packet : \(packet)")
            client.send(packet)
        } else if (channel == 101) {
            // FX1
            let packet = OSCMessage(OSCAddressPattern("/rtn/1/mix/\(String(format: "%02d", bus))/level"),value)
            print("Send Packet : \(packet)")
            client.send(packet)
        } else if (channel == 102) {
            // FX2
            let packet = OSCMessage(OSCAddressPattern("/rtn/2/mix/\(String(format: "%02d", bus))/level"),value)
            print("Send Packet : \(packet)")
            client.send(packet)
        } else if (channel == 103) {
            // FX3
            let packet = OSCMessage(OSCAddressPattern("/rtn/3/mix/\(String(format: "%02d", bus))/level"),value)
            print("Send Packet : \(packet)")
            client.send(packet)
        } else if (channel == 104) {
            // FX4
            let packet = OSCMessage(OSCAddressPattern("/rtn/4/mix/\(String(format: "%02d", bus))/level"),value)
            print("Send Packet : \(packet)")
            client.send(packet)
        } else {
            // We work Channel level -- WORKING
            let packet = OSCMessage(OSCAddressPattern("/ch/\(String(format: "%02d", channel))/mix/\(String(format: "%02d", bus))/level"),value)
            print("Send Packet : \(packet)")
            client.send(packet)
        }
    }
}

func output(_ output:Int, _ source:Int) {
    // Change Aux outputs -- We assume Stereo -- TESTING

    let packet = OSCMessage(OSCAddressPattern("/routing/aux/\(String(format: "%02d", output))/src"),source)
    print("Send Packet : \(packet)")
    client.send(packet)
    let packet2 = OSCMessage(OSCAddressPattern("/routing/aux/\(String(format: "%02d", output+1))/src"),source+1)
    print("Send Packet : \(packet2)")
    client.send(packet2)
    
}

func muteunmute(_ sender:UISwitch!,_ bus:Int,_ channel:Int) {
    if (sender.isOn == true){
        unmute(bus,channel)
    }
    else{
        mute(bus,channel)
    }
}




class SecondViewController: UIViewController {

    @objc func requestFaderUpdateZone1() {
        // Request Fader Value :
       
        let fader101 = OSCMessage(OSCAddressPattern("/rtn/1/mix/fader"))
        print("Send Packet : \(fader101)")
        client.send(fader101)
        
        
        let fader102 = OSCMessage(OSCAddressPattern("/rtn/2/mix/fader"))
        print("Send Packet : \(fader102)")
        client.send(fader102)
        
        
        let fader103 = OSCMessage(OSCAddressPattern("/rtn/3/mix/fader"))
        print("Send Packet : \(fader103)")
        client.send(fader103)
        
        
        let fader104 = OSCMessage(OSCAddressPattern("/rtn/4/mix/fader"))
        print("Send Packet : \(fader104)")
        client.send(fader104)
        
       
        let fader105 = OSCMessage(OSCAddressPattern("/ch/09/mix/fader"))
        print("Send Packet : \(fader105)")
        client.send(fader105)
        
    }

    
    
    
    //------ Slider Outlets -------
    
    @IBOutlet weak var zone1Fad1: UISlider!
    @IBOutlet weak var zone1Fad2: UISlider!
    @IBOutlet weak var zone1Fad3: UISlider!
    @IBOutlet weak var zone1Fad4: UISlider!
    @IBOutlet weak var zone1Fad5: UISlider!
    @IBOutlet weak var zone1Fad6: UISlider!
    
    //------ Labels Outlets -------
    
    @IBOutlet weak var labelZone1: UILabel!

    //------ Switch Outlets -------
    
    @IBOutlet weak var zone1Sw1: UISwitch!
    @IBOutlet weak var zone1Sw2: UISwitch!
    @IBOutlet weak var zone1Sw3: UISwitch!
    @IBOutlet weak var zone1Sw4: UISwitch!
    @IBOutlet weak var zone1Sw5: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Subscribe to notification of changes for Zone1
         NotificationCenter.default.addObserver(self, selector: #selector(updateFaderZone1(notification:)), name: NSNotification.Name.fader101, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateFaderZone1(notification:)), name: NSNotification.Name.fader102, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateFaderZone1(notification:)), name: NSNotification.Name.fader103, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateFaderZone1(notification:)), name: NSNotification.Name.fader104, object: nil)
         NotificationCenter.default.addObserver(self, selector: #selector(updateFaderZone1(notification:)), name: NSNotification.Name.fader105, object: nil)
        
        
        //Initial request for fader
        requestFaderUpdateZone1()
        
        //Repeat every 10 secs
        var timer1 = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(requestFaderUpdateZone1), userInfo: nil, repeats: true)
        

        // Do any additional setup after loading the view, typically from a nib.
        //let defaults = UserDefaults.standard
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    //------ Sliders Actions -------
    
    // FX Engines FX1...4 Fader 27...30
    
    @IBAction func zone1Fad1Action(_ sender: UISlider) {
        fader(0,101,roundme(sender.value))
    }
    @IBAction func zone1Fad2Action(_ sender: UISlider) {
        fader(0,102,roundme(sender.value))
    }
    @IBAction func zone1Fad3Action(_ sender: UISlider) {
        fader(0,103,roundme(sender.value))
    }
    @IBAction func zone1Fad4Action(_ sender: UISlider) {
        fader(0,104,roundme(sender.value))
    }
    @IBAction func zone1Fad5Action(_ sender: UISlider) {
        fader(0,9,roundme(sender.value))
    }
    @IBAction func zone1Fad6Action(_ sender: UISlider) {
        fader(0,0,roundme(sender.value))
    }

    
    //------ Switch Actions -------
    
    @IBAction func zone1Sw1Action(_ sender: UISwitch) {
       // muteunmute(sender, 0, 1)
    }
    @IBAction func zone1Sw2Action(_ sender: UISwitch) {
      //  muteunmute(sender, 0, 3)
    }
    @IBAction func zone1Sw3Action(_ sender: UISwitch) {
        //muteunmute(sender, 0, 5)
    }
    @IBAction func zone1Sw4Acton(_ sender: UISwitch) {
        //muteunmute(sender, 0, 7)
        //requestFaderUpdateZone1()
    }
    @IBAction func zone1Sw5Action(_ sender: UISwitch) {
        //muteunmute(sender, 0, 9)
//        let test101 = OSCMessage(OSCAddressPattern("/rtn/1/mix/fader"),0.95)
//        print("Send Packet : \(test101)")
//        client.send(test101)
//        let test102 = OSCMessage(OSCAddressPattern("/rtn/2/mix/fader"),0.85)
//        print("Send Packet : \(test102)")
//        client.send(test102)
//        let test103 = OSCMessage(OSCAddressPattern("/rtn/3/mix/fader"),0.75)
//        print("Send Packet : \(test103)")
//        client.send(test103)
//        let test104 = OSCMessage(OSCAddressPattern("/rtn/4/mix/fader"),0.65)
//        print("Send Packet : \(test104)")
//        client.send(test104)
//        let test105 = OSCMessage(OSCAddressPattern("/ch/09/mix/fader"),0.55)
//        print("Send Packet : \(test105)")
//        client.send(test105)
        

        
    }
    

    @objc dynamic func updateFaderZone1(notification: Notification){
       
        if (notification.name == NSNotification.Name.fader101) {
            if let level = notification.userInfo?["zone1Fad1"] as? Float32 { zone1Fad1.value = level; print("tzqt \(level)")}
         //   NotificationCenter.default.removeObserver(self, name: NSNotification.Name("fader101"), object: nil)
        }
        if (notification.name == NSNotification.Name.fader102) {
            if let level = notification.userInfo?["zone1Fad2"] as? Float32 { zone1Fad2.value = level }
         //   NotificationCenter.default.removeObserver(self, name: NSNotification.Name("fader102"), object: nil)
        }
        
        if (notification.name == NSNotification.Name.fader103) {
            if let level = notification.userInfo?["zone1Fad3"] as? Float32 { zone1Fad3.value = level }
         //   NotificationCenter.default.removeObserver(self, name: NSNotification.Name("fader103"), object: nil)
        }
        
        if (notification.name == NSNotification.Name.fader104) {
            if let level = notification.userInfo?["zone1Fad4"] as? Float32 { zone1Fad4.value = level }
        //    NotificationCenter.default.removeObserver(self, name: NSNotification.Name("fader104"), object: nil)
        }
        
        if (notification.name == NSNotification.Name.fader105) {
            if let level = notification.userInfo?["zone1Fad5"] as? Float32 { zone1Fad5.value = level }
         //   NotificationCenter.default.removeObserver(self, name: NSNotification.Name("fader105"), object: nil)
    
        }
        

        

    }


    

}

