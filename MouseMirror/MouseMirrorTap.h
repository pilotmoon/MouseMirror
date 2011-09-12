//
//  MouseMirrorTap.h
//  MouseMirror
//
//  Created by Nick Moore on 12/09/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *MouseMirrorPrefsMirrorX;
extern NSString *MouseMirrorPrefsMirrorY;

@interface MouseMirrorTap : NSObject {
	CGEventMask mask;
	CFMachPortRef port;
	CFRunLoopSourceRef source;    
}
@property (readonly, getter=isActive) BOOL active;
- (void)start;
- (void)stop;
- (void)enableTap:(BOOL)state;
@end
