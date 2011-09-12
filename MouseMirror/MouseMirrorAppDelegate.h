//
//  MouseMirrorAppDelegate.h
//  MouseMirror
//
//  Created by Nick Moore on 12/09/2011.
//  Copyright 2011 Nick Moore. All rights reserved.
//

#import <Cocoa/Cocoa.h>

extern NSString *MouseMirrorPrefsHasRunBefore;

@class MouseMirrorTap;
@interface MouseMirrorAppDelegate : NSObject <NSApplicationDelegate> {
    NSWindow *_window;
    MouseMirrorTap *_tap;
}

@property (assign) IBOutlet NSWindow *window;

@end
