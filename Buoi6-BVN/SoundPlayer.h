//
//  SoundPlayer.h
//  Buoi6-BVN
//
//  Created by doductrung on 5/22/13.
//  Copyright (c) 2013 doductrung. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
@interface SoundPlayer : NSObject
- (void) preloadSound: (NSArray *) fileNames;
- (void) playSound: (NSString*) name;
- (void) setVolume: (float) volumn withFileNamesArray: (NSArray *) fileNames;
- (void) stopSound: (NSString *) name;
@end
