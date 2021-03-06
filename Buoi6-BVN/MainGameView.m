//
//  MainGameView.m
//  Buoi6-BVN
//
//  Created by doductrung on 5/18/13.
//  Copyright (c) 2013 doductrung. All rights reserved.
//

#import "MainGameView.h"
#import "Save.h"
#import "Question.h"
#import "Player.h"
@interface MainGameView ()

@end

@implementation MainGameView
{
    CGAffineTransform _btnTransform;
    UISlider * slider;
    float volume;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void) initial {
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"mainGameBG.png"]]];
    [self addGuesture:[self intSingleTapGuesture:@selector(backToMenuScreen)] for:self.backBtn];
    [self.questionTV setEditable:NO];
    // khoi tao player va question
    self.player = [[Player alloc] init];
    self.question = [[Question alloc] init];
    [self.question loadQuestion:self.player.curentLevel];
    [self showQuestion:self.question];
    // add a,b,c,d button
    [self addGuesture:[self intSingleTapGuesture:@selector(aAnswer)] for:self.aBtn];
    [self addGuesture:[self intSingleTapGuesture:@selector(bAnswer)] for:self.bBtn];
    [self addGuesture:[self intSingleTapGuesture:@selector(cAnswer)] for:self.cBtn];
    [self addGuesture:[self intSingleTapGuesture:@selector(dAnswer)] for:self.dBtn];
    self.aBtn.tag = 1;
    self.bBtn.tag = 2;
    self.cBtn.tag = 3;
    self.dBtn.tag = 4;
    // init alert view
    self.answerNotification = [[UIAlertView alloc] initWithTitle:@"Xác nhận" message:@"Bạn có chắc chắn chọn đáp án này ?" delegate:self cancelButtonTitle:@"Hủy bỏ" otherButtonTitles:@"Đồng ý", nil];
    self.loseNotification = [[UIAlertView alloc] initWithTitle:@"Game kết thúc" message:@"Bạn trả lời sai, chúc bạn may mắn lần sau." delegate:self cancelButtonTitle:@"Đồng ý" otherButtonTitles:NULL, nil];
    self.winNotification = [[UIAlertView alloc] initWithTitle:@"Chúc mừng bạn" message:@"Và chúng ta đã tìm được triệu phú, chính là Bạn !!!" delegate:self cancelButtonTitle:@"Đồng ý" otherButtonTitles:NULL, nil];
    // init save
    Save *gameController = [[Save alloc] init];
    if(gameController.conTinue == NO){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Chào mừng bạn ^^" message:@"Hãy vận dụng hiểu biết của mình để trở thành triệu phú." delegate:self cancelButtonTitle:@"Bắt đầu" otherButtonTitles:NULL, nil];
        [alert show];
    }else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Chào mừng bạn trở lại!!!" message:@"Hãy vận dụng hiểu biết của mình để trở thành triệu phú." delegate:self cancelButtonTitle:@"Tiếp tục" otherButtonTitles:NULL, nil];
        [alert show];
    }
    // init audio controller and load sound
   // NSArray *sound = [NSArray arrayWithObjects:@"wrong.m4a", @"win.mp3" , @"ding.mp3", nil];
    self.audioController = [[SoundPlayer alloc] init];
    [self.audioController preloadSound:soundNames];
    //-------------------------
    [self addGuesture:[self intSingleTapGuesture:@selector(showVolumeSlider)] for:self.volumeBtn];
    [self addGuesture:[self intSingleTapGuesture:@selector(hiddenSlider)] for:self.xBtn];
    volume = 0.3;
    [self.audioController playSound:backgroundMusic];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initial];
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
//back to main menu
- (void) backToRootScreen {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void) goToLevel1 {
    MainGameView *mainGameView = [[MainGameView alloc] initWithNibName:nil bundle:NULL];
    [self.navigationController pushViewController:mainGameView animated:YES];
}

- (void) backToMenuScreen {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
// show question
- (void) showQuestion: (Question *) question {
    [self.questionTV setText:question.question];
    [self.numberTf setText:[NSString stringWithFormat:@"Câu %d", question.number]];
    [self.ATf setText:[NSString stringWithFormat:@"%@", [question.answers objectAtIndex:0]]];
    [self.BTf setText:[NSString stringWithFormat:@"%@", [question.answers objectAtIndex:1]]];
    [self.CTf setText:[NSString stringWithFormat:@"%@", [question.answers objectAtIndex:2]]];
    [self.DTf setText:[NSString stringWithFormat:@"%@", [question.answers objectAtIndex:3]]];
}

- (void) aAnswer {
    self.playerAnswer = 0;
    [self.answerNotification show];
}
- (void) bAnswer {
    self.playerAnswer = 1;
    [self.answerNotification show];
}
- (void) cAnswer {
    self.playerAnswer = 2;
    [self.answerNotification show];}
- (void) dAnswer {
    self.playerAnswer = 3;
    [self.answerNotification show];
}
//check answer
- (void) checkRight:(int) playerAnswer{
    NSLog(@"Player chose: %d", playerAnswer);
    bool answer = [self.question checkRight: playerAnswer];
    if(answer == YES) {
        [self.rewardLb setText:[NSString stringWithFormat:@"Phần thưởng: %ld000 VND", self.question.reward]];
        // play sound
        [self.audioController playSound:dingSound];
        if(self.question.number < 16) {
        [self showQuestion:self.question];
        }else{
            [self.audioController stopSound:backgroundMusic];
            [self.audioController playSound:victorySound];
            [self.winNotification show];
        }
    }else{
        [self.audioController playSound:wrongSound];
        [self.loseNotification show];
    }
}
//handle alert
- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSString *buttonTitle = [alertView buttonTitleAtIndex:buttonIndex];
    if(alertView == self.answerNotification){
        if([buttonTitle isEqualToString:@"Đồng ý"]) {
            [self setTransform];
            [self checkRight:self.playerAnswer];
        }else {
            [self setTransform];
            return;
        };
    }
    if(alertView == self.loseNotification){
        if([buttonTitle isEqualToString:@"Đồng ý"]) {
            [self getPlayerScore];
        }else return;
    }
    if(alertView == self.getName){
        if([buttonTitle isEqualToString:@"Đồng ý"]) {
            UITextField *nameTf = [self.getName textFieldAtIndex:0];
            self.player.name = nameTf.text;
            self.player.money = self.question.reward;
            NSLog(@"player's name: %@", self.player.name);
            if(self.player.money > 0){
                [self writeScore];
            }
            [self backToRootScreen];
        }else return;
    }
    
    if(alertView == self.winNotification){
        if([buttonTitle isEqualToString:@"Đồng ý"]) {
            [self getPlayerScore];
        }else return;
    }
}
// get player score
- (void) getPlayerScore {
    self.getName = [[UIAlertView alloc] initWithTitle:@"Tên bạn" message:@"Ghi danh điểm cao" delegate:self cancelButtonTitle:@"Đồng ý" otherButtonTitles:NULL, nil];
    [self.getName setAlertViewStyle:UIAlertViewStylePlainTextInput];
    [self.getName show];
}
// write score to file
- (void) writeScore {
    NSString *scorePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    scorePath = [scorePath stringByAppendingPathComponent:@"HighScore.plist"];
    // If the file doesn't exist in the Documents Folder, copy it.
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath:scorePath]) {
        [fileManager copyItemAtPath:scorePath toPath:scorePath error:nil];
    }
    /*NSString *scorePath = [[NSBundle mainBundle] pathForResource:@"HighScore" ofType:@"plist"];*/
    NSMutableArray *sources = [[NSMutableArray alloc] initWithContentsOfFile:scorePath];
    NSDictionary *highestScore = nil;
    if(sources.count > 0){
        highestScore  = [sources objectAtIndex:(sources.count -1)];
    }else{
        sources = [[NSMutableArray alloc] init];
    }
    
    NSNumber *playerMN = [NSNumber numberWithInt:self.player.money];
    NSMutableDictionary *plScore = [[NSMutableDictionary alloc] initWithObjectsAndKeys:self.player.name, @"Name",  playerMN, @"Score",nil];
    if(highestScore != nil) {
        int hScore = [[highestScore objectForKey:@"Score"]intValue];
        NSLog(@"highest score: %d", hScore);
        if(self.player.money >= hScore){
            [sources addObject:plScore];
            [sources writeToFile:scorePath atomically:YES];
        }
    }else{
        [sources addObject:plScore];
        [sources writeToFile:scorePath atomically:YES];
    }
    NSLog(@"Done");
}
// some effect when touch the answer
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *myTouch = [touches anyObject];
    if(myTouch.view.tag == 1){
        _btnTransform = self.aBtn.transform;
        self.aBtn.transform = CGAffineTransformScale(self.aBtn.transform, 1.5, 1.5);
    }else if(myTouch.view.tag == 2){
        _btnTransform = self.bBtn.transform;
        self.bBtn.transform = CGAffineTransformScale(self.bBtn.transform, 1.5, 1.5);
    }else if(myTouch.view.tag == 3){
        _btnTransform = self.cBtn.transform;
        self.cBtn.transform = CGAffineTransformScale(self.cBtn.transform, 1.5, 1.5);
    }else if(myTouch.view.tag == 4){
        _btnTransform = self.dBtn.transform;
        self.dBtn.transform = CGAffineTransformScale(self.dBtn.transform, 1.5, 1.5);
    }
}
- (void) setTransform{
    self.aBtn.transform = _btnTransform;
    self.bBtn.transform = _btnTransform;
    self.cBtn.transform = _btnTransform;
    self.dBtn.transform = _btnTransform;
}
// create volume control
- (void) showVolumeSlider {
    slider = [[UISlider alloc] initWithFrame:CGRectMake(150, 230, 100,50)];
    slider.center = CGPointMake(self.volumeBtn.center.x - 50, self.volumeBtn.center.y + 30);
    slider.value = volume;
    [slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:slider];
}
- (void) sliderValueChanged: (id) sender {
    volume = slider.value;
    NSLog(@"%f", volume);
    [self.audioController setVolume:volume withFileNamesArray:soundNames];
}
- (void) hiddenSlider {
    [slider removeFromSuperview];
}
@end
