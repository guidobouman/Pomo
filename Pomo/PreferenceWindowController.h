//
//  PreferenceWindowController.h
//  Pomo
//
//  Created by Guido Bouman on 08/01/14.
//  Copyright (c) 2014 Guido Bouman. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface PreferenceWindowController : NSWindowController {

    IBOutlet NSWindow *preferenceWindow;
    
    IBOutlet NSToolbar *toolbar;

    IBOutlet NSView *generalView;
    IBOutlet NSView *audioView;
    IBOutlet NSView *aboutView;
    
    int currentViewTag;

}

- (IBAction)showPreferenceWindow:(id)sender;
- (IBAction)switchView:(id)sender;

@end