//
//  AppDelegate.swift
//  wtf-button
//
//  Created by Stephane Piriou on 28/12/2017.
//  Copyright © 2017 AppCoda. All rights reserved.
//

import Cocoa
import AVFoundation

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    // Create audio player object and initialize with URL to sound
    let enabled = true
    //NSApp.setActivationPolicy(NSApplicationActivationPolicy.Accessory)
    var audioPlayer: AVAudioPlayer?
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        guard let path = Bundle.main.url(forResource: "wtf", withExtension: "mp3") else { return }
        let soundUrl = path//URL(fileURLWithPath: path)
        audioPlayer = try? AVAudioPlayer(contentsOf: path)
        
        if let button = statusItem.button {
            button.image = NSImage(named:NSImage.Name("Icon64"))
            button.action = #selector(self.statusBarButtonClicked(_:))
            button.sendAction(on: [.leftMouseUp, .rightMouseUp])
        }
    }
    
    @objc func statusBarButtonClicked(_ sender: NSStatusBarButton) {
        let event = NSApp.currentEvent!
        if event.type == NSEvent.EventType.rightMouseUp {
            constructMenu()
        } else {
            audioPlayer?.play()
        }
    }
 
    func constructMenu() {
        let menu = NSMenu()
        var itemString = ""
        
        if (enabled){
            itemString = "Random Trigger Enabled"
        } else {
            itemString = "Random Trigger Disabled"
        }
        
        let item = NSMenuItem(title: itemString, action: #selector(AppDelegate.printQuote(_:)), keyEquivalent: "P")
        // Allow Random trigger
        menu.addItem(item)
        menu.addItem(NSMenuItem.separator())
        // Quit
        menu.addItem(NSMenuItem(title: "Quit Quotes", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"))
        menu.addItem(NSMenuItem.separator())
        
        statusItem.menu = menu
    }
    
    func randomTriggerEnabled()
    {
    }
    
}

