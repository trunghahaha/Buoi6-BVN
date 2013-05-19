//
//  RootView.m
//  Buoi6-BVN
//
//  Created by doductrung on 5/17/13.
//  Copyright (c) 2013 doductrung. All rights reserved.
//

#import "RootView.h"
#import "PlayingView.h"
#import "HightScoreView.h"
@interface RootView ()

@end
CGPoint point1, point2, point3, point4, point5;
@implementation RootView

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        // lay vi tri 5 dong xu
        point1= self.coin1.center;
        point2= self.coin2.center;
        point3= self.coin3.center;
        point4= self.coin4.center;
        point5= self.coin5.center;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    // set img background for xib
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]]];
    [self addGuesture:[self intSingleTapGuesture:@selector(goToPlayingView)] for:self.startGameBtn];
    [self addGuesture:[self intSingleTapGuesture:@selector(goToHightScoreView)] for:self.hightScoreBtn];
}
- (void) viewWillAppear:(BOOL)animated {
    if([self.view isHidden]){
    }else{
        self.coin1.center = point1;
        self.coin2.center = point2;
        self.coin3.center = point3;
        self.coin4.center = point4;
        self.coin5.center = point5;
        [self.coin1 setHidden:NO];
        [self.coin2 setHidden:NO];
        [self.coin3 setHidden:NO];
        [self.coin4 setHidden:NO];
        [self.coin5 setHidden:NO];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// go to playing view
- (void) goToPlayingView {
    [self moveCoin];
}
// go to hight score view
- (void) goToHightScoreView {
    HightScoreView *highScoreView = [[HightScoreView alloc]initWithNibName:nil bundle:NULL];
    [self.navigationController pushViewController:highScoreView animated:YES];
}
// init single tap guesture
- (UITapGestureRecognizer *) intSingleTapGuesture: (SEL) selector {
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:selector];
    singleTap.numberOfTapsRequired = 1;
    singleTap.numberOfTouchesRequired = 1;
    return singleTap;
}
// add single tap and enable user interface
- (void) addGuesture: (UITapGestureRecognizer *)singleTap for: (UIImageView *) img {
    [img addGestureRecognizer:singleTap];
    [img setUserInteractionEnabled:YES];
}
// effect: 5 coins all go to a point
- (void) moveCoin {
    [UIView animateWithDuration:0.5 animations:^{
                                                 self.coin1.center = self.man.center;
                                                 self.coin2.center = self.man.center;
                                                 self.coin3.center = self.man.center;
                                                 self.coin4.center = self.man.center;
                                                 self.coin5.center = self.man.center;
    } completion:^(BOOL finished) {
        [self.coin1 setHidden:YES];
        [self.coin2 setHidden:YES];
        [self.coin3 setHidden:YES];
        [self.coin4 setHidden:YES];
        [self.coin5 setHidden:YES];
        // go to next board after everything is done
        PlayingView *playingView = [[PlayingView alloc]initWithNibName:nil bundle:NULL];
        [self.navigationController pushViewController:playingView animated:YES];
    }] ;
}
@end
