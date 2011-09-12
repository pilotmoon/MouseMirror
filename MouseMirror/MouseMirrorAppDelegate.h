//
//  MouseMirrorAppDelegate.h
//  MouseMirror
//
//  Created by Nick Moore on 12/09/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface MouseMirrorAppDelegate : NSObject <NSApplicationDelegate> {
    NSWindow *window;
}

@property (assign) IBOutlet NSWindow *window;

@end
