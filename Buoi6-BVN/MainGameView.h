//
//  MainGameView.h
//  Buoi6-BVN
//
//  Created by doductrung on 5/18/13.
//  Copyright (c) 2013 doductrung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Question.h"
#import "Player.h"
#import "config.h"
#import "SoundPlayer.h"
@interface MainGameView : UIViewController <UIAlertViewDelegate>
@property (nonatomic, assign) int playerAnswer;
@property (nonatomic, strong) Question * question;
@property (nonatomic, strong) Player *player;

@property (weak, nonatomic) IBOutlet UIImageView *backBtn;
@property (weak, nonatomic) IBOutlet UILabel *ATf;
@property (weak, nonatomic) IBOutlet UILabel *BTf;
@property (weak, nonatomic) IBOutlet UILabel *CTf;
@property (weak, nonatomic) IBOutlet UILabel *DTf;
@property (weak, nonatomic) IBOutlet UITextView *questionTV;
@property (weak, nonatomic) IBOutlet UILabel *numberTf;
@property (weak, nonatomic) IBOutlet UIImageView *aBtn;
@property (weak, nonatomic) IBOutlet UIImageView *bBtn;
@property (weak, nonatomic) IBOutlet UIImageView *cBtn;
@property (weak, nonatomic) IBOutlet UIImageView *dBtn;
@property (weak, nonatomic) IBOutlet UILabel *rewardLb;
@property (nonatomic, strong) IBOutlet UIAlertView *loseNotification;
@property (nonatomic, strong) IBOutlet UIAlertView *answerNotification;
@property (nonatomic, strong) IBOutlet UIAlertView *getName;
@property (nonatomic, strong) IBOutlet UIAlertView *winNotification;
@property (nonatomic, strong) SoundPlayer *audioController;
@property (weak, nonatomic) IBOutlet UIImageView *volumeBtn;
@property (weak, nonatomic) IBOutlet UIImageView *xBtn;

@end
