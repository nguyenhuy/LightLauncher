//
//  Log.h
//  LightLauncher
//
//  Created by Huy Nguyen on 9/29/12.
//  Copyright (c) 2012 EarlyBird Lab. All rights reserved.
//

#ifdef DEBUG
    #define DLog(...) NSLog(@"%s %@", __PRETTY_FUNCTION__, [NSString stringWithFormat:__VA_ARGS__])
#else
    #define DLog(...) do { } while (0)
#endif
