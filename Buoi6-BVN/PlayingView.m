//
//  PlayingView.m
//  Buoi6-BVN
//
//  Created by doductrung on 5/18/13.
//  Copyright (c) 2013 doductrung. All rights reserved.
//

#import "PlayingView.h"
#import "MainGameView.h"
@interface PlayingView ()

@end

@implementation PlayingView

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"playingViewBG.png"]]];
    
    [self addGuesture:[self intSingleTapGuesture:@selector(backToRootScreen)] for:self.backBtn];
    [self addGuesture:[self intSingleTapGuesture:@selector(goToLevel1)] for:self.lv1Btn];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
- (void) backToRootScreen {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void) goToLevel1 {
    MainGameView *mainGameView = [[MainGameView alloc] initWithNibName:nil bundle:NULL];
    [self.navigationController pushViewController:mainGameView animated:YES];
}
@end
