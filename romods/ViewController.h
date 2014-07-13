//
//  ViewController.h
//  romods
//
//  Created by Kosuke Nagano on 2014/07/11.
//  Copyright (c) 2014年 Kousuke Nagano. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "romods.h"
#import <RMCore/RMCore.h>
#import <RMCharacter/RMCharacter.h>
#import "AppDelegate.h"

@interface ViewController : UIViewController <RMCoreDelegate> {
    UILabel *debugText;
}

@property IBOutlet UILabel* debugText;

@property (nonatomic, strong) RMCoreRobot<HeadTiltProtocol, DriveProtocol, LEDProtocol> *Romo;

- (IBAction)pushLEDBtn:(id)sender;

@end

