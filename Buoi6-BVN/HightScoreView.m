//
//  HightScoreView.m
//  Buoi6-BVN
//
//  Created by doductrung on 5/18/13.
//  Copyright (c) 2013 doductrung. All rights reserved.
//

#import "HightScoreView.h"

@interface HightScoreView ()

@end

@implementation HightScoreView

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
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"highScoreBG.png"]]];
    [self addGuesture:[self intSingleTapGuesture:@selector(backToRootScreen)] for:self.backBtn];
    [self.highScoreTV setEditable:NO];
    [self loadScore];
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
- (void) loadScore {
    NSString *scorePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    scorePath = [scorePath stringByAppendingPathComponent:@"HighScore.plist"];
    NSFileManager *fileManage = [NSFileManager defaultManager];
    if(![fileManage fileExistsAtPath:scorePath]){
        /*NSString *source = [[NSBundle mainBundle] pathForResource:@"HighScore" ofType:@"plist"];
        [fileManage copyItemAtPath:source toPath:scorePath error:nil];*/
    }
    NSMutableString *scoreTable = [[NSMutableString alloc]initWithFormat:@"Score"];
    NSMutableArray *scores = [[NSMutableArray alloc] initWithContentsOfFile:scorePath];
    for(id sc in scores) {
        NSDictionary *playerScore = sc;
        [scoreTable appendFormat:@"\n%@  %d nghìn VND",[playerScore objectForKey:@"Name"], [[playerScore objectForKey:@"Score"] intValue]];
    }
    NSLog(@"have %d score", scores.count);
    NSLog(@"%@", scoreTable);
    [self.highScoreTV setText:scoreTable];
    NSLog(@"%@", scorePath);
}
@end
