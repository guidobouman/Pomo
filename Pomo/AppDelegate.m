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
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self
               selector:@selector(defaultsChanged:)
                   name:NSUserDefaultsDidChangeNotification
                 object:nil];
    
    if(!preferenceWindowController) {
        preferenceWindowController = [[PreferenceWindowController alloc] init];
    }
    
    isRunning = false;
    isBreak = false;
    
    workTitleAttributes = [NSDictionary dictionaryWithObject:[NSColor blackColor] forKey:NSForegroundColorAttributeName];
    breakTitleAttributes = [NSDictionary dictionaryWithObject:[NSColor redColor] forKey:NSForegroundColorAttributeName];
    
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
    
    if(!isRunning) {
        NSString *theTime = [self timeFormatted:workDuration * 60];
        [statusItem setTitle:theTime];
    }
    
}

- (NSString *)timeFormatted:(int)totalSeconds
{
    
    int seconds = totalSeconds % 60;
    int minutes = (totalSeconds / 60);
    
    return [NSString stringWithFormat:@"%02d:%02d", minutes, seconds];
}

- (IBAction)toggleWork:(id)sender {
    
    if(!isRunning || isBreak) {
        [self startTimer:false];
    }
    else {
        [self stopTimer];
    }
    
    [self updateStatusItem];
    
}

- (IBAction)toggleBreak:(id)sender {
    
    if(!isRunning || !isBreak) {
        [self startTimer:true];
    }
    else {
        [self stopTimer];
    }
    
    [self updateStatusItem];
    
}

- (void)startTimer:(BOOL)toBreak {
    
    isRunning = true;
    isBreak = toBreak;
    
    [menuTimer invalidate];
    
    menuTimer = [NSTimer scheduledTimerWithTimeInterval:1
                                                 target:self
                                               selector:@selector(tick:)
                                               userInfo:nil
                                                repeats:YES];
    [self tick:menuTimer];
    
}

- (void)stopTimer {
    
    isRunning = false;
    isBreak = false;
    
    [menuTimer invalidate];
    
    [statusItem setTitle:[self timeFormatted:workDuration * 60]];
    
}

- (void)updateStatusItem {
    
    if(isRunning) {
        if(isBreak) {
            [workMenuItem setTitle:@"Start work session"];
            [breakMenuItem setTitle:@"Stop break timer"];
        }
        else {
            [workMenuItem setTitle:@"Stop work timer"];
            [breakMenuItem setTitle:@"Start break session"];
        }
    }
    else {
        [workMenuItem setTitle:@"Start work session"];
        [breakMenuItem setTitle:@"Start break session"];
    }
    
}

- (void)tick:(NSTimer*)timer {
    
    if(isBreak) {
        NSLog(@"Break!");
    }
    else {
        NSLog(@"Work!");
    }
    
}

@end