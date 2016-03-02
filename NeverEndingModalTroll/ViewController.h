//
//  ViewController.h
//  NeverEndingModalTroll
//
//  Created by Magfurul Abeer on 2/19/16.
//  Copyright © 2016 Magfurul Abeer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@protocol TrollDelegate <NSObject>

@required
-(void)presentAnotherModal;
-(void)addALo;
-(void)playMusicIfNotPlaying;
-(void)startTextManipulation;
-(void)showSexyDeadpool;
-(void)hideSexyDeadpool;
@end

@interface ViewController : UIViewController

@property (strong, nonatomic) AVAudioPlayer *audioPlayer;
@property (strong, nonatomic) NSTimer *textManipulationTimer;

@end

