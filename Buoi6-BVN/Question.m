//
//  Question.m
//  Buoi6-BVN
//
//  Created by doductrung on 5/19/13.
//  Copyright (c) 2013 doductrung. All rights reserved.
//

#import "Question.h"

@implementation Question
- (id) init {
    self = [super init];
    self.number = 1;
    self.level = 1;
    self.reward = 0;
    return self;
}
- (void) loadQuestion: (int) currentLevel{
    NSString *dataPath;
    // khi level tang thi moi load lai cau hoi
    if(self.number % 3 == 1){
    if(currentLevel == 1){
        dataPath = [[NSBundle mainBundle] pathForResource:@"Level1Questions" ofType:@"plist"];
    }else if(currentLevel == 2){
        dataPath = [[NSBundle mainBundle] pathForResource:@"Level2Questions" ofType:@"plist"];
    }else if(currentLevel == 3){
        dataPath = [[NSBundle mainBundle] pathForResource:@"Level3Questions" ofType:@"plist"];
    }else if(currentLevel == 4){
        dataPath = [[NSBundle mainBundle] pathForResource:@"Level4Questions" ofType:@"plist"];
    }else if(currentLevel == 5){
        dataPath = [[NSBundle mainBundle] pathForResource:@"Level5Questions" ofType:@"plist"];
    }
    self.data = [[NSMutableArray alloc] initWithContentsOfFile:dataPath];
    }
    
    NSDictionary *oneQues;
    while(true){
    int randNumber = arc4random()%(self.data.count);
    //NSLog(@"We have %d questions ", self.data.count);
    //NSLog(@"rand number %d", randNumber);
    oneQues = [self.data objectAtIndex:randNumber];
    if([[oneQues objectForKey:@"Check"] isEqualToString:@"0"])
        break;
    }
    self.question = [oneQues objectForKey:@"Question"];
    self.answers = [oneQues objectForKey:@"Answers"];
    NSString *right = [oneQues objectForKey:@"Right"];
    self.rightAnswer = [right intValue];
    [oneQues setValue:@"1" forKey:@"Check"];
}

- (bool) checkRight: (int) playerAnswer{
    if(playerAnswer == self.rightAnswer) {
        if(self.number == 1){
            self.reward = 1000;
        }else if(self.number == 2){
            self.reward = 2000;
        }else if(self.number == 3){
            self.reward = 3000;
        }else if(self.number == 4){
            self.reward = 4000;
        }else if(self.number == 5){
            self.reward = 5000;
        }else if(self.number == 6){
            self.reward = 6000;
        }else if(self.number == 7){
            self.reward = 7000;
        }else if(self.number == 8){
            self.reward = 8000;
        }else if(self.number == 9){
            self.reward = 9000;
        }else if(self.number == 10){
            self.reward = 10000;
        }else if(self.number == 11){
            self.reward = 11000;
        }else if(self.number == 12){
            self.reward = 12000;
        }else if(self.number == 13){
            self.reward = 13000;
        }else if(self.number == 14){
            self.reward = 14000;
        }else if(self.number == 15){
            self.reward = 15000;
        }
        
        self.number++;
        if(self.number%3 == 1 && self.number != 1 && self.number <16){
            self.level ++;
        }
        [self loadQuestion:self.level];
        return YES;
    }else
        return NO;
}
@end
