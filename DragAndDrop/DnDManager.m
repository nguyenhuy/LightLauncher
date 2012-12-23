//
//  DnDManager.m
//  testDragAndDrop
//
//  Created by Joshua Foster on 8/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DnDManager.h"

#import "DnDOverlayView.h"


@implementation DnDManager

+ (id) instance{
    static DnDManager *sharedManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[DnDManager alloc] init];
    });
    return sharedManager;
}

- (id)init {
	if(( self = [super init] )) {
		dndOverlaysById = [[NSMutableDictionary alloc] init];
	}
	return self;
}

- (void)dealloc {
    [dndOverlaysById release];
    [registrationQueueById release];
    [super dealloc];
}

- (void)registerDnDOverlay:(DnDOverlayView*)overlayView withId:(NSString*)overlayId {
    [dndOverlaysById setObject:overlayView forKey:overlayId];
    
    NSLog( @"Registered DnDOverlay %@", overlayId );
    
    // If we have DnD items which were waiting on this overlay, add them now
    NSMutableArray* queuedItems = [registrationQueueById objectForKey:overlayId];
    if( queuedItems != nil ) {
        for( id item in queuedItems ) [overlayView registerDnDItem:item];
        [registrationQueueById removeObjectForKey:overlayId];
    }
}

- (void)registerDnDItem:(id)item withOverlayId:(NSString*)overlayId {
    DnDOverlayView* overlay = [dndOverlaysById objectForKey:overlayId];
    if( overlay == nil ) {
        // The requested overlay hasn't registered yet -- queue up this item in an array
        // keyed on ID until the overlay registers
        if( registrationQueueById == nil ) registrationQueueById = [[NSMutableDictionary alloc] init];
        NSMutableArray* queuedItems = [registrationQueueById objectForKey:overlayId];
        if( queuedItems == nil ) {
            queuedItems = [[[NSMutableArray alloc] init] autorelease];
            [registrationQueueById setObject:queuedItems forKey:overlayId];
        }
        [queuedItems addObject:item];
    }
    else {
        [overlay registerDnDItem:item];
    }
}

- (void)deregisterDnDItem:(id)item fromOverlayId:(NSString*)overlayId {
    DnDOverlayView* overlay = [dndOverlaysById objectForKey:overlayId];
    [overlay deregisterDnDItem:item];
}

- (void)activateDragModeForOverlayId:(NSString*)overlayId {
    DnDOverlayView* overlay = [dndOverlaysById objectForKey:overlayId];
    overlay.dragModeActive = YES;
}

@end
