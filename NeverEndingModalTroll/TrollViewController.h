//
//  TrollViewController.h
//  NeverEndingModalTroll
//
//  Created by Magfurul Abeer on 2/19/16.
//  Copyright © 2016 Magfurul Abeer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

@interface TrollViewController : UIViewController

@property (strong, nonatomic) id <TrollDelegate> delegate;
@property (nonatomic) NSUInteger numberOfTimesToRotate;

@end
