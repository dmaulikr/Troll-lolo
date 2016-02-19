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

@end

UIDynamicAnimator* _animator;
UIGravityBehavior* _gravity;

@implementation TrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.timerCount = 0;
    self.colorCount = 0;
    // Move to View Controller?
    if (self.numberOfTimesToRotate > 0) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(autoRotate) userInfo:nil repeats:YES];
    }
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
            
            
//            NSTimer *removeSoon = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(removeImageView) userInfo:nil repeats:NO];
        }
        self.colorCount++;
    }
}

-(void)spawnAMeme {
    NSUInteger x = arc4random_uniform((u_int32_t)400) + 1; //
    NSUInteger y = arc4random_uniform((u_int32_t)550) + 1;
    
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
    // Dispose of any resources that can be recreated.
}

- (IBAction)problem:(UIButton *)sender {
    [self.timer invalidate];
    self.timer = nil;
    [self dismissViewControllerAnimated:YES completion:^{
        [self.delegate addALo];
        [self.delegate presentAnotherModal];
        [self.delegate playMusicIfNotPlaying];
    }];
}

-(BOOL)prefersStatusBarHidden {
    return YES;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sendvber:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
