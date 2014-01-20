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
    
    int workDuration;
    int breakDuration;
    int repeatSessions;
    int launchAtLogin;
    
    int workSound;
    int breakSound;
    int outputVolume;
    
    NSStatusItem *statusItem;
    IBOutlet NSMenu *statusMenu;
    IBOutlet NSMenuItem *workMenuItem;
    IBOutlet NSMenuItem *breakMenuItem;
    
    PreferenceWindowController *preferenceWindowController;
    
    bool isRunning;
    bool isBreak;
    
    NSTimer *menuTimer;
    NSDate *targetTime;
    
}

- (IBAction)showPreferences:(id)sender;
- (void)loadPreferences:(NSUserDefaults *)defaults;
- (NSString *)timeFormatted:(int)totalSeconds;

@end
