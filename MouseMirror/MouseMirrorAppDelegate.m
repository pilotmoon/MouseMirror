//
//  MouseMirrorAppDelegate.m
//  MouseMirror
//
//  Created by Nick Moore on 12/09/2011.
//  Copyright 2011 Nick Moore. All rights reserved.
//

#import "MouseMirrorAppDelegate.h"
#import "MouseMirrorTap.h"

NSString *MouseMirrorPrefsHasRunBefore=@"HasRunBefore";

@implementation MouseMirrorAppDelegate

@synthesize window=_window;

+ (void)initialize
{
    if (self==[MouseMirrorAppDelegate class]) {
        // register default settings
        [[NSUserDefaults standardUserDefaults] registerDefaults:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                 [NSNumber numberWithBool:YES], MouseMirrorPrefsMirrorX,
                                                                 [NSNumber numberWithBool:YES], MouseMirrorPrefsMirrorY,
                                                                 nil]];
    }
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    if (![[NSUserDefaults standardUserDefaults] boolForKey:MouseMirrorPrefsHasRunBefore]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:MouseMirrorPrefsHasRunBefore];
        [self.window center];
    }
    [self.window setFrameAutosaveName:@"MouseMirrorMainWindow"];
    _tap=[[MouseMirrorTap alloc] init];
    [_tap start];
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender
{
    return YES;
}

@end
