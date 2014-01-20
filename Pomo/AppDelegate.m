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
        [self setStatusBarTitle:theTime];
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
    
}

- (IBAction)toggleBreak:(id)sender {
    
    if(!isRunning || !isBreak) {
        [self startTimer:true];
    }
    else {
        [self stopTimer];
    }
    
}

- (void)startTimer:(BOOL)toBreak {
    
    isRunning = true;
    isBreak = toBreak;
    
    NSTimeInterval targetSeconds = (isBreak ? breakDuration : workDuration) * 60;
    targetTime = [[NSDate alloc] initWithTimeIntervalSinceNow:targetSeconds];
    
    [menuTimer invalidate];
    
    menuTimer = [NSTimer scheduledTimerWithTimeInterval:1
                                                 target:self
                                               selector:@selector(tick:)
                                               userInfo:nil
                                                repeats:YES];
    
    [self tick:menuTimer];
    
    [self updateStatusItem];
    
}

- (void)stopTimer {
    
    isRunning = false;
    isBreak = false;
    
    [menuTimer invalidate];
    
    [self setStatusBarTitle:[self timeFormatted:workDuration * 60]];
    
    [self updateStatusItem];
    
}

- (void)updateStatusItem {
    
    if(isRunning) {
        if(isBreak) {
            [workMenuItem setTitle:@"Start work session"];
            [breakMenuItem setTitle:@"Stop break session"];
        }
        else {
            [workMenuItem setTitle:@"Stop work session"];
            [breakMenuItem setTitle:@"Start break session"];
        }
    }
    else {
        [workMenuItem setTitle:@"Start work session"];
        [breakMenuItem setTitle:@"Start break session"];
    }
    
}

- (void)tick:(NSTimer*)timer {
    
    NSTimeInterval timeLeft = [targetTime timeIntervalSinceNow];
    
    [self setStatusBarTitle:[self timeFormatted:timeLeft]];
    
    if(timeLeft < 0) {
        if(repeatSessions || !isBreak) {
            [self startTimer:!isBreak];
        }
        else {
            [self stopTimer];
        }
    }
    
}

- (void)setStatusBarTitle:(NSString *)value {
    
    
    NSColor *textColor = isBreak ? [NSColor redColor] : [NSColor blackColor];
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                textColor, NSForegroundColorAttributeName,
                                [NSFont menuBarFontOfSize:0], NSFontAttributeName,
                                nil];
    
    [statusItem setAttributedTitle:[[NSAttributedString alloc] initWithString:value attributes:attributes]];
    
}

@end