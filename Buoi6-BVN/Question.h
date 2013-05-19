//
//  Question.h
//  Buoi6-BVN
//
//  Created by doductrung on 5/19/13.
//  Copyright (c) 2013 doductrung. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Question : NSObject
@property (nonatomic, strong) NSMutableArray* data;
@property (nonatomic, strong) NSString * question;
@property (nonatomic, strong) NSArray *answers;
@property (nonatomic, assign) int rightAnswer;
@property (nonatomic, assign) int playerAnswer;
@property (nonatomic, assign) int level;
@property (nonatomic, assign) int number;
@property (nonatomic, assign) long reward;
- (void) loadQuestion: (int) currentLevel;
- (bool) checkRight: (int) playerAnswer;
@end
