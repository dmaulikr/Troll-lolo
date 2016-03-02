//
//  ViewController.m
//  NeverEndingModalTroll
//
//  Created by Magfurul Abeer on 2/19/16.
//  Copyright © 2016 Magfurul Abeer. All rights reserved.
//

#import "ViewController.h"
#import "TrollViewController.h"



@interface ViewController () <TrollDelegate>
@property (weak, nonatomic) IBOutlet UITextView *trolo;
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (nonatomic) NSUInteger count;
@property (weak, nonatomic) IBOutlet UIImageView *yuno;
@property (weak, nonatomic) IBOutlet UIImageView *deadpoolFrenchGirl;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.yuno.hidden = YES;
    self.count = 0;
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)viewDidAppear:(BOOL)animated {
    
    self.yuno.hidden = self.count % 10 == 0 && self.count != 0? NO : YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)troll:(UIButton *)sender {
    NSLog(@"Count: %lu", self.count);
    [self presentAnotherModal];
}

#pragma mark - Troll Delegate 

-(void)presentAnotherModal {
    TrollViewController *trollVC = [self.storyboard instantiateViewControllerWithIdentifier:@"troll"];
    trollVC.delegate = self;
    trollVC.numberOfTimesToRotate = self.count;
    NSLog(@"%lu", trollVC.numberOfTimesToRotate);
    [self presentViewController:trollVC animated:YES completion:^{
        self.count++;
    }];

}

-(void)addALo {
    NSUInteger length = [self.trolo.text length];
    if (length < 1) {
        self.trolo.text = @"Trolo";
    }
    self.button.titleLabel.hidden = YES;
    for (NSUInteger i = 0; i < self.count; i++) {
        self.trolo.text = [self.trolo.text stringByAppendingString:@"lo"];
    }
}

-(void)playMusicIfNotPlaying {
    if (!self.audioPlayer) {
        NSURL *url = [[NSBundle mainBundle] URLForResource:@"trololo" withExtension:@"mp3"];
        NSError *error = nil;
        self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
        [self.audioPlayer prepareToPlay];
        [self.audioPlayer play];
        self.audioPlayer.numberOfLoops = -1;
    }
}

-(void)startTextManipulation {
    self.textManipulationTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(manipulateText) userInfo:nil repeats:YES];
}

-(void)manipulateText {
}

-(void)showSexyDeadpool {
    self.deadpoolFrenchGirl.hidden = NO;
}

-(void)hideSexyDeadpool {
    self.deadpoolFrenchGirl.hidden = YES;
}

#pragma mark - Other

-(BOOL)prefersStatusBarHidden {
    return YES;
}
@end
