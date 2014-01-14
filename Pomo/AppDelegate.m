//
//  AppDelegate.m
//  Pomo
//
//  Created by Guido Bouman on 08/01/14.
//  Copyright (c) 2014 Guido Bouman. All rights reserved.
//

#import "AppDelegate.h"
#import "PreferenceWindowController.h"

@implementation AppDelegate

- (void)awakeFromNib {
    
    statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    [statusItem setMenu:statusMenu];
    [statusItem setHighlightMode:YES];
    [statusItem setTitle:@"0:00"];
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self
               selector:@selector(defaultsChanged:)
                   name:NSUserDefaultsDidChangeNotification
                 object:nil];
    
    if(!preferenceWindowController) {
        preferenceWindowController = [[PreferenceWindowController alloc] init];
    }
    
}

- (IBAction)showPreferences:(id)sender {
    
    [preferenceWindowController showPreferenceWindow];
    
}

- (void)defaultsChanged:(NSNotification *)notification {
    
    NSUserDefaults *defaults = (NSUserDefaults *)[notification object];
    
    [self loadPreferences:defaults];
    
}

- (void)loadPreferences:(NSUserDefaults *)defaults {
    
    workDuration = (int)[defaults integerForKey:@"workDuration"];
    breakDuration = (int)[defaults integerForKey:@"breakDuration"];
    repeatSessions = [defaults boolForKey:@"repeatSessions"];
    
    workSound = [defaults boolForKey:@"workSound"];
    breakSound = [defaults boolForKey:@"breakSound"];
    outputVolume = (int)[defaults integerForKey:@"outputVolume"];
    
    
    NSLog(@"Output volume: %i", outputVolume);
    
}

@end