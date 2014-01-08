//
//  AppDelegate.m
//  Pomo
//
//  Created by Guido Bouman on 08/01/14.
//  Copyright (c) 2014 Guido Bouman. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification*)aNotification {
    
    NSBundle *bundle = [NSBundle mainBundle];
    statusImage = [[NSImage alloc] initWithContentsOfFile:[bundle pathForResource:@"Icon" ofType:@"png"]];
    statusHighlightImage = [[NSImage alloc] initWithContentsOfFile:[bundle pathForResource:@"Highlight Icon" ofType:@"png"]];
    
    statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    [statusItem setMenu:statusMenu];
    [statusItem setImage:statusImage];
    [statusItem setAlternateImage:statusHighlightImage];
    [statusItem setHighlightMode:YES];
    
    [preferencesWindow setTitle:@"General"];
    [preferencesWindow setContentSize:[generalView frame].size];
    [[preferencesWindow contentView] addSubview:generalView];
    
}

- (IBAction)showPreferences:(id)sender {
    
    [NSApp activateIgnoringOtherApps:YES];
    [preferencesWindow setLevel:1];
    [preferencesWindow makeKeyAndOrderFront:self];
    
}

- (IBAction)switchView:(id)sender {
    
    int tag = (int)[sender tag];
    
    NSView *view = [self viewForTag:tag];
    NSView *previousView = [self viewForTag:currentViewTag];
    
    currentViewTag = tag;
    
    [preferencesWindow setTitle:[sender label]];
    
    NSRect newFrame = [self newFrameForNewContentView:view];
    
    [NSAnimationContext beginGrouping];
    
    if([[NSApp currentEvent] modifierFlags] & NSShiftKeyMask) {
        [[NSAnimationContext currentContext] setDuration:1.0];
    }
    
    [[[preferencesWindow contentView] animator] replaceSubview:previousView with:view];
    [[preferencesWindow animator] setFrame:newFrame display:YES];
    
    [NSAnimationContext endGrouping];
    
}
     
- (NSRect)newFrameForNewContentView:(NSView*)view {
    
    NSRect newFrameRect = [preferencesWindow frameRectForContentRect:[view frame]];
    NSRect oldFrameRect = [preferencesWindow frame];
    NSSize newSize = newFrameRect.size;
    NSSize oldSize = oldFrameRect.size;
    
    NSRect frame = [preferencesWindow frame];
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