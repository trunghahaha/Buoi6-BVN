//
//  SoundPlayer.m
//  Buoi6-BVN
//
//  Created by doductrung on 5/22/13.
//  Copyright (c) 2013 doductrung. All rights reserved.
//

#import "SoundPlayer.h"

@implementation SoundPlayer
{
    NSMutableDictionary *audio;
}
- (void) preloadSound: (NSArray *) fileNames {
    audio = [NSMutableDictionary dictionaryWithCapacity:fileNames.count];
    for(NSString * name in fileNames) {
        NSString *soundPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:name];
        NSURL * soundURL = [NSURL fileURLWithPath:soundPath];
        NSLog(@"%@", soundURL);
        NSError * error = nil;
        AVAudioPlayer * player  = [[AVAudioPlayer alloc] initWithContentsOfURL:soundURL error:&error];
        if([name isEqualToString:@"Background music.mp3"])
            player.numberOfLoops = 10;
        else if([name isEqualToString:@"Victory.mp3"])
            player.numberOfLoops = 5;
        else {
            player.numberOfLoops = 0;
        }
        player.volume = 0.3;
        [player prepareToPlay];
        audio[name] = player;
    }
}
- (void) setVolume: (float) volumn withFileNamesArray: (NSArray *) fileNames{
    for(NSString *name in fileNames){
        AVAudioPlayer * player = (AVAudioPlayer *) audio[name];
        player.volume = volumn;
    }
}
- (void) playSound: (NSString*) name {
    NSAssert(audio[name], @"not found");
    AVAudioPlayer * player = (AVAudioPlayer *) audio[name];
    if(player.isPlaying){
        player.currentTime = 0;
    }else{
        [player play];  
    }
}
- (void) stopSound: (NSString *) name {
    AVAudioPlayer * player = (AVAudioPlayer *) audio[name];
    [player stop];
}
@end
