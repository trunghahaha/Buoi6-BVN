//
//  Controller.m
//  Buoi6-BVN
//
//  Created by doductrung on 5/18/13.
//  Copyright (c) 2013 doductrung. All rights reserved.
//

#import "Save.h"

@implementation Save
- (id) init {
    self = [super init];
    [self loadFromSave];
    return self;
}
- (void) loadFromSave {
    NSString *savePath = [[NSBundle mainBundle] pathForResource:@"Save" ofType:@"plist"];
    NSDictionary *save = [[NSDictionary alloc] initWithContentsOfFile:savePath];
    NSString *result = [save objectForKey:@"Continue"];
    if([result isEqualToString:@"NO"]){
        self.conTinue = NO;
    }else self.conTinue = YES;
}
@end
