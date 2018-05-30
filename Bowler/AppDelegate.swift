//
//  AppDelegate.swift
//  Bowler
//
//  Created by Charles Sicard on 01/05/2018.
//  Copyright © 2018 Charles Sicard. All rights reserved.
//

import UIKit
import SwiftOSC

extension NSNotification.Name {
    static let fader101 = NSNotification.Name(rawValue: "fader101")
    static let fader102 = NSNotification.Name(rawValue: "fader102")
    static let fader103 = NSNotification.Name(rawValue: "fader103")
    static let fader104 = NSNotification.Name(rawValue: "fader104")
    static let fader105 = NSNotification.Name(rawValue: "fader105")
    static let fader201 = NSNotification.Name(rawValue: "fader201")
    static let fader202 = NSNotification.Name(rawValue: "fader202")
    static let fader203 = NSNotification.Name(rawValue: "fader203")
    static let fader204 = NSNotification.Name(rawValue: "fader204")
    static let fader205 = NSNotification.Name(rawValue: "fader205")
    static let zone1zone2 = NSNotification.Name(rawValue: "zone1zone2")
}


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        var server = OSCServer(address: "", port: 50500)
        server.start()
        
        class OSCHandler: OSCServerDelegate {
            
            
            public var value101:Float=100
            public var value102:Float=100
            public var value103:Float=100
            public var value104:Float=100
            public var value105:Float=100
            public var value201:Float=100
            public var value202:Float=100
            public var value203:Float=100
            public var value204:Float=100
            public var value205:Float=100
            public var zone2:Int=100
            
            func didReceive(_ message: OSCMessage) {
                
                print("Received Message : \(message)")
               
                
                if message.description.range(of:"Address</rtn/1/mix/fader") != nil {
                    value101=handleXRResponse(message)
                    if(value101 != -1) {
                        print("MIX::RTN1::\(value101)")
                        NotificationCenter.default.post(name: NSNotification.Name.fader101, object: self, userInfo: ["zone1Fad1" : value101])
                    }
                }
                if message.description.range(of:"Address</rtn/2/mix/fader") != nil {
                    value102=handleXRResponse(message)
                    if(value102 != -1) {
                        print("MIX::RTN2::\(value102)")
                        NotificationCenter.default.post(name: NSNotification.Name.fader102, object: self, userInfo: ["zone1Fad2" : value102])
                    }
                    
                }
                if message.description.range(of:"Address</rtn/3/mix/fader") != nil {
                    value103=handleXRResponse(message)
                    if(value103 != -1) {
                        print("MIX::RTN3::\(value103)")
                        NotificationCenter.default.post(name: NSNotification.Name.fader103, object: self, userInfo: ["zone1Fad3" : value103])
                    }
                }
                if message.description.range(of:"Address</rtn/4/mix/fader") != nil {
                    value104=handleXRResponse(message)
                    if(value104 != -1) {
                        print("MIX::RTN4::\(value104)")
                        NotificationCenter.default.post(name: NSNotification.Name.fader104, object: self, userInfo: ["zone1Fad4" : value104])
                    }
                }
                if message.description.range(of:"Address</ch/09/mix/fader") != nil {
                    value105=handleXRResponse(message)
                     if(value105 != -1) {
                        print("MIX::IPAD::\(value105)")
                        NotificationCenter.default.post(name: NSNotification.Name.fader105, object: self, userInfo: ["zone1Fad5" : value105])
                    }
                }
                
                if message.description.range(of:"Address</rtn/1/mix/01/level") != nil {
                    value201=handleXRResponse(message)
                    if(value201 != -1) {
                        print("BUS1::RTN1::\(value201)")
                        NotificationCenter.default.post(name: NSNotification.Name.fader201, object: self, userInfo: ["zone2Fad1" : value201])
                    }
                }
                if message.description.range(of:"Address</rtn/2/mix/01/level") != nil {
                    value202=handleXRResponse(message)
                    if(value202 != -1) {
                        print("BUS1::RTN2::\(value202)")
                        NotificationCenter.default.post(name: NSNotification.Name.fader202, object: self, userInfo: ["zone2Fad2" : value202])
                    }
                    
                }
                if message.description.range(of:"Address</rtn/3/mix/01/level") != nil {
                    value203=handleXRResponse(message)
                    if(value203 != -1) {
                        print("BUS1::RTN3::\(value203)")
                        NotificationCenter.default.post(name: NSNotification.Name.fader203, object: self, userInfo: ["zone2Fad3" : value203])
                    }
                }
                if message.description.range(of:"Address</rtn/4/mix/01/level") != nil {
                    value204=handleXRResponse(message)
                    if(value204 != -1) {
                        print("BUS1::RTN4::\(value204)")
                        NotificationCenter.default.post(name: NSNotification.Name.fader204, object: self, userInfo: ["zone2Fad4" : value204])
                    }
                }
                if message.description.range(of:"Address</ch/09/mix/01/level") != nil {
                    value205=handleXRResponse(message)
                    if(value205 != -1) {
                        print("BUS1::IPAD::\(value205)")
                        NotificationCenter.default.post(name: NSNotification.Name.fader205, object: self, userInfo: ["zone2Fad5" : value205])
                    }
                }
                if message.description.range(of:"Address</routing/aux/01") != nil {
                    zone2=handleXRZoneResponse(message)
                    if(zone2 != -1) {
                        print("ZONE2::\(zone2)")
                        NotificationCenter.default.post(name: NSNotification.Name.zone1zone2, object: self, userInfo: ["zone2" : zone2])
                    }
                }
                
                
            }
            
            
            
            func handleXRResponse(_ message:OSCMessage) -> Float{
                let regex = try! NSRegularExpression(pattern:"Float<(.*?)>", options: [])
                var results = [String]()
                
                regex.enumerateMatches(in: message.description, options: [], range: NSMakeRange(0, message.description.utf16.count)) { result, flags, stop in
                    if let r = result?.range(at: 1), let range = Range(r, in: message.description) {
                        results.append(String(message.description[range]))
                    }
                }
                if (results.isEmpty) {
                    return -1
                } else {
                    return Float(results[0])!
                }
            }
            
            func handleXRZoneResponse(_ message:OSCMessage) -> Int{
                let regex = try! NSRegularExpression(pattern:"Int<(.*?)>", options: [])
                var results = [String]()
            
                regex.enumerateMatches(in: message.description, options: [], range: NSMakeRange(0, message.description.utf16.count)) { result, flags, stop in
                    if let r = result?.range(at: 1), let range = Range(r, in: message.description) {
                        results.append(String(message.description[range]))
                    }
                }
                if (results.isEmpty) {
                    return -1
                } else {
                    return Int(results[0])!
                }
            }
            
        }
        server.delegate =  OSCHandler()
        return true
    }


    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        var vc2 = SecondViewController()
        vc2.requestFaderUpdateZone1()
        var vc3 = ThridViewController()
        vc3.requestFaderUpdateZone2()
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

