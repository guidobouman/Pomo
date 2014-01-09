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
    
    // -- Settings
    
    IBOutlet NSTextField *workDurationField;
    IBOutlet NSTextField *breakDurationField;
    IBOutlet NSStepper *workDurationStepper;
    IBOutlet NSStepper *breakDurationStepper;
    IBOutlet NSButton *repeatSessionsCheckbox;
    IBOutlet NSButton *launchAtLoginCheckbox;
    
    IBOutlet NSButton *workSoundCheckbox;
    IBOutlet NSButton *breakSoundCheckbox;
    IBOutlet NSSlider *outputVolumeSlider;
}

- (IBAction)showPreferenceWindow;

- (IBAction)switchView:(id)sender;

- (IBAction)loadPreferences;
- (IBAction)savePreferences:(id)sender;

@end
