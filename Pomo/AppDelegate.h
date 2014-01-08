//
//  AppDelegate.h
//  Pomo
//
//  Created by Guido Bouman on 08/01/14.
//  Copyright (c) 2014 Guido Bouman. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate> {
    
    IBOutlet NSMenu *statusMenu;
    NSStatusItem *statusItem;
    NSImage *statusImage;
    NSImage *statusHighlightImage;
    
    IBOutlet NSWindow *preferencesWindow;
    
    IBOutlet NSView *generalView;
    IBOutlet NSView *audioView;
    IBOutlet NSView *aboutView;
    
    int currentViewTag;
    
}

- (IBAction)showPreferences:(id)sender;
- (IBAction)switchView:(id)sender;

@end
