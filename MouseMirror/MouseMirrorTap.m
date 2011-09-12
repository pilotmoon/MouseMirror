//
//  MouseMirrorTap.m
//  MouseMirror
//
//  Created by Nick Moore on 12/09/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MouseMirrorTap.h"

NSString *MouseMirrorPrefsMirrorX=@"MirrorX";
NSString *MouseMirrorPrefsMirrorY=@"MirrorY";

#define MOVE_MASK \
    CGEventMaskBit(kCGEventMouseMoved)|\
    CGEventMaskBit(kCGEventLeftMouseDragged)|\
    CGEventMaskBit(kCGEventRightMouseDragged)|\
    CGEventMaskBit(kCGEventOtherMouseDragged)

// This is called every time there is a scroll event. It has to be efficient.
static CGEventRef eventTapCallback (CGEventTapProxy proxy,
                                    CGEventType type,
                                    CGEventRef event,
                                    void *userInfo)
{    
	MouseMirrorTap *tap=(MouseMirrorTap *)userInfo;

    if (CGEventMaskBit(type)&MOVE_MASK)
    {
        CGPoint location=CGEventGetLocation(event);
        NSLog(@"location is %@", NSStringFromPoint(NSPointFromCGPoint(location)));
        
        int64_t dx=CGEventGetIntegerValueField(event, kCGMouseEventDeltaX);
        int64_t dy=CGEventGetIntegerValueField(event, kCGMouseEventDeltaY);
        NSLog(@"dx %lli dy %lli" , dx, dy);

        if ([[NSUserDefaults standardUserDefaults] boolForKey:MouseMirrorPrefsMirrorX]) {
            location.x-=dx;
        }
        if ([[NSUserDefaults standardUserDefaults] boolForKey:MouseMirrorPrefsMirrorY]) {
            location.y-=dy;
        }   
        
        NSLog(@"warping to is %@", NSStringFromPoint(NSPointFromCGPoint(location)));
        CGWarpMouseCursorPosition(location);  
    }
    else if(type==kCGEventTapDisabledByTimeout)
    { 
        // This can happen sometimes. (Not sure why.) 
        [tap enableTap:TRUE]; // Re-enable it.
    }	
    
	return event;
}

@implementation MouseMirrorTap

- (BOOL)isActive
{
	return source&&port;
}

- (void)start
{
	if(self.active)
		return;
    
    // ask HID system to let go of the mouse
    CGAssociateMouseAndMouseCursorPosition(FALSE);
    
	// create mach port
	port = (CFMachPortRef)CGEventTapCreate(kCGHIDEventTap,
										   kCGHeadInsertEventTap,
										   kCGEventTapOptionDefault,
										   MOVE_MASK,
										   eventTapCallback,
										   self);
    
	// create source and add to tun loop
	source = (CFRunLoopSourceRef)CFMachPortCreateRunLoopSource(kCFAllocatorDefault, port, 0);
	CFRunLoopAddSource(CFRunLoopGetMain(), source, kCFRunLoopCommonModes);
}

- (void)stop
{
	if (!self.active)
		return;
    
    CGAssociateMouseAndMouseCursorPosition(TRUE);

	CFRunLoopRemoveSource(CFRunLoopGetMain(), source, kCFRunLoopCommonModes);
	CFMachPortInvalidate(port);
	CFRelease(source);
	CFRelease(port);
	source=nil;
	port=nil;
}

- (void)enableTap:(BOOL)state
{
	CGEventTapEnable(port, state);
}

@end

