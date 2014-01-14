//
//  AppDelegate.h
//  Pomo
//
//  Created by Guido Bouman on 08/01/14.
//  Copyright (c) 2014 Guido Bouman. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class PreferenceWindowController;

@interface AppDelegate : NSObject <NSApplicationDelegate> {
    
    PreferenceWindowController *preferenceWindowController;
    
    IBOutlet NSMenu *statusMenu;
    NSStatusItem *statusItem;
    NSImage *statusImage;
    NSImage *statusHighlightImage;
    
    
    int workDuration;
    int breakDuration;
    int repeatSessions;
    int launchAtLogin;
    
    int workSound;
    int breakSound;
    int outputVolume;
    
}

- (IBAction)showPreferences:(id)sender;
- (void)loadPreferences:(NSUserDefaults *)defaults;

@end
