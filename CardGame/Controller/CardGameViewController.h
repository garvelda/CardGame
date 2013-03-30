//
//  GameViewController.h
//  CardGame
//
//  Created by David Eleazar García Santiago on 28/03/13.
//  Copyright (c) 2013 David Eleazar García Santiago. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameResult.h"

@interface CardGameViewController : UIViewController
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoresLabel;
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastFlipLabel;
@property (strong, nonatomic) GameResult *gameResult;
@end
