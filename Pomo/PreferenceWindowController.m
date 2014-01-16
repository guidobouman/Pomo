//
//  PreferenceWindowController.m
//  Pomo
//
//  Created by Guido Bouman on 08/01/14.
//  Copyright (c) 2014 Guido Bouman. All rights reserved.
//

#import "PreferenceWindowController.h"
#import <ServiceManagement/ServiceManagement.h>

@implementation PreferenceWindowController

- (id)init {
    
    self = [super initWithWindowNibName:@"PreferenceWindow"];
    if (self) {
        
        [self showWindow:nil];
        
//        NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
//        [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
        
        [self setupDefaults];
        
    }
    return self;
}

- (void)windowDidLoad {
    
    [super windowDidLoad];
    
    // Load general as default view.
    [toolbar setSelectedItemIdentifier:@"general"];
    [preferenceWindow setTitle:@"General"];
    [preferenceWindow setContentSize:[generalView frame].size];
    [[preferenceWindow contentView] addSubview:generalView];
    
    NSString *version = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    [versionLabel setStringValue:[NSString stringWithFormat:@"Pomo v%@", version]];
    
}

- (IBAction)setLaunchAtLogin:(id)sender {
    
    if([sender state]) {
        // Turn on launch at login
        if (!SMLoginItemSetEnabled ((__bridge CFStringRef)@"com.guidobouman.LoginHelper", YES)) {
            NSAlert *alert = [NSAlert alertWithMessageText:@"An error ocurred"
                                             defaultButton:@"OK"
                                           alternateButton:nil
                                               otherButton:nil
                                 informativeTextWithFormat:@"Couldn't add Helper App to launch at login item list."];
            [alert runModal];
        }
    } else {
        // Turn off launch at login
        if (!SMLoginItemSetEnabled ((__bridge CFStringRef)@"com.guidobouman.LoginHelper", NO)) {
            NSAlert *alert = [NSAlert alertWithMessageText:@"An error ocurred"
                                             defaultButton:@"OK"
                                           alternateButton:nil
                                               otherButton:nil
                                 informativeTextWithFormat:@"Couldn't remove Helper App from launch at login item list."];
            [alert runModal];
        }
    }
    
}

- (void)setupDefaults
{
    
    NSString *userDefaultsValuesPath;
    NSDictionary *userDefaultsValuesDict;
    
    userDefaultsValuesPath=[[NSBundle mainBundle] pathForResource:@"UserDefaults" ofType:@"plist"];
    userDefaultsValuesDict=[NSDictionary dictionaryWithContentsOfFile:userDefaultsValuesPath];
    [[NSUserDefaults standardUserDefaults] registerDefaults:userDefaultsValuesDict];
    
}


- (IBAction)showPreferenceWindow {
    
    [NSApp activateIgnoringOtherApps:YES];
    [preferenceWindow setLevel:1];
    [preferenceWindow makeKeyAndOrderFront:self];
    
}

- (IBAction)switchView:(id)sender {
    
    int tag = (int)[sender tag];
    
    NSView *view = [self viewForTag:tag];
    NSView *previousView = [self viewForTag:currentViewTag];
    
    currentViewTag = tag;
    
    [preferenceWindow setTitle:[sender label]];
    
    NSRect newFrame = [self newFrameForNewContentView:view];
    
    [NSAnimationContext beginGrouping];
    
    if([[NSApp currentEvent] modifierFlags] & NSShiftKeyMask) {
        [[NSAnimationContext currentContext] setDuration:1.0];
    }
    
    [[[preferenceWindow contentView] animator] replaceSubview:previousView with:view];
    [[preferenceWindow animator] setFrame:newFrame display:YES];
    
    [NSAnimationContext endGrouping];
    
}

- (NSRect)newFrameForNewContentView:(NSView*)view {
    
    NSRect newFrameRect = [preferenceWindow frameRectForContentRect:[view frame]];
    NSRect oldFrameRect = [preferenceWindow frame];
    NSSize newSize = newFrameRect.size;
    NSSize oldSize = oldFrameRect.size;
    
    NSRect frame = [preferenceWindow frame];
    frame.size = newSize;
    frame.origin.y -= (newSize.height - oldSize.height);
    
    return frame;
    
}

- (NSView *)viewForTag:(int)tag {
    
    NSView *view = nil;
    
    switch (tag) {
        case 0:
            view = generalView;
            break;
        case 1:
            view = audioView;
            break;
        case 2:
        default:
            view = aboutView;
            break;
    }
    
    return view;
    
}

@end
