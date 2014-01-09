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
    
    NSBundle *bundle = [NSBundle mainBundle];
    statusImage = [[NSImage alloc] initWithContentsOfFile:[bundle pathForResource:@"Icon" ofType:@"png"]];
    statusHighlightImage = [[NSImage alloc] initWithContentsOfFile:[bundle pathForResource:@"Highlight Icon" ofType:@"png"]];
    
    statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    [statusItem setMenu:statusMenu];
    [statusItem setImage:statusImage];
    [statusItem setAlternateImage:statusHighlightImage];
    [statusItem setHighlightMode:YES];
    
    if(!preferenceWindowController) {
        preferenceWindowController = [[PreferenceWindowController alloc] init];
    }
    
}

- (IBAction)showPreferences:(id)sender {
    
    [preferenceWindowController showPreferenceWindow:nil];
    
}

@end