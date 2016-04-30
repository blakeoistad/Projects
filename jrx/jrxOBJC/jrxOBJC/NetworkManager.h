//
//  NetworkManager.h
//  jrxOBJC
//
//  Created by Blake Oistad on 4/30/16.
//  Copyright © 2016 Blake Oistad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"

@interface NetworkManager : NSObject {
    BOOL *serverAvailable;
}

+ (id)sharedInstance;

@end





@interface MyManager : NSObject {
    NSString *someProperty;
}

@property (nonatomic, retain) NSString *someProperty;

+ (id)sharedManager;

@end