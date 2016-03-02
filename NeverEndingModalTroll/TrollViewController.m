//
//  TrollViewController.m
//  NeverEndingModalTroll
//
//  Created by Magfurul Abeer on 2/19/16.
//  Copyright © 2016 Magfurul Abeer. All rights reserved.
//

#import "TrollViewController.h"

@interface TrollViewController ()

@property (weak, nonatomic) IBOutlet UIView *background;
@property (weak, nonatomic) IBOutlet UIImageView *trollFaceImageView;
@property (nonatomic) NSUInteger timerCount;
@property (strong, nonatomic) NSTimer *timer;
@property (strong, nonatomic) NSTimer *oneByOne;
@property (nonatomic) NSUInteger colorCount;
@property (strong, nonatomic) NSMutableArray *leViews;
@property (nonatomic) NSUInteger numberOfSpawns;
@property (nonatomic) NSUInteger maxSpawns;
@property (weak, nonatomic) IBOutlet UIImageView *deadpoolOooh;
//@property (strong, nonatomic) NSTimer *deadpoolTimer;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *deadpoolTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *deadPoolAtTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *deadPoolAtBottom;
@property (nonatomic) BOOL deadpoolWasHere;
@end

UIDynamicAnimator* _animator;
UIGravityBehavior* _gravity;

@implementation TrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.deadpoolWasHere = NO;
    self.deadPoolAtTop.active = NO;
    self.timerCount = 0;
    self.colorCount = 0;

    // Move to View Controller?
    if (self.numberOfTimesToRotate > 0) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(autoRotate) userInfo:nil repeats:YES];
    }
    
    [self performSelector:@selector(showDeadPool) withObject:nil afterDelay:15];

}

-(void)autoRotate {

    self.trollFaceImageView.transform = CGAffineTransformMakeRotation(self.timerCount/-0.2);
    self.timerCount += 10;
    if (self.timerCount % 50 == 0) {
        switch (self.colorCount) {
            case 0:
                self.background.backgroundColor = [UIColor purpleColor];
                break;
            case 1:
                self.background.backgroundColor = [UIColor blueColor];
                break;
            case 2:
                self.background.backgroundColor = [UIColor magentaColor];
                break;
            case 3:
                self.background.backgroundColor = [UIColor greenColor];
                break;
            case 4:
                self.background.backgroundColor = [UIColor cyanColor];
                break;
            case 5:
                self.background.backgroundColor = [UIColor orangeColor];
                break;
            case 6:
                self.background.backgroundColor = [UIColor yellowColor];
                self.colorCount = 0;
                break;
            default:
                break;
        }
        if (self.timerCount % 600 == 0 && self.timerCount != 0) {
            self.maxSpawns = arc4random() % 30 + 1;
            self.numberOfSpawns = 0;
            self.leViews = [@[] mutableCopy];
            
            self.oneByOne = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(spawnAMeme) userInfo:nil repeats:YES];
            
        }
        self.colorCount++;
    }
}

-(void)spawnAMeme {         // 0 - 60
    NSUInteger x = arc4random_uniform((u_int32_t)self.view.frame.size.width) - 60; //
    NSUInteger y = arc4random_uniform((u_int32_t)self.view.frame.size.height) - 60;
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, 60, 60)];
    imgView.image = [UIImage imageNamed:@"woah"];
    [self.background addSubview:imgView];
    
    _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    _gravity = [[UIGravityBehavior alloc] initWithItems:@[imgView]];
    [_animator addBehavior:_gravity];
    
    self.numberOfSpawns++;
    
    if (self.numberOfSpawns == self.maxSpawns) {
        [self.oneByOne invalidate];
        self.oneByOne = nil;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)problem:(UIButton *)sender {
    [self.timer invalidate];
    self.timer = nil;
    [self dismissViewControllerAnimated:YES completion:^{
        if (self.deadpoolWasHere) {
            [self.delegate showSexyDeadpool];
        } else {
            [self.delegate hideSexyDeadpool];
        }
        [self.delegate addALo];
        [self.delegate presentAnotherModal];
        [self.delegate playMusicIfNotPlaying];
    }];
}

-(BOOL)prefersStatusBarHidden {
    return YES;
}

-(void)showDeadPool {
    self.deadpoolOooh.hidden = NO;
    [UIView animateWithDuration:9
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.deadPoolAtBottom.active = NO;
                         self.deadPoolAtTop.active = YES;
                         [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        self.deadpoolWasHere = YES;
    }];
}

@end
