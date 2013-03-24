//
//  GameResultViewController.m
//  CardGame
//
//  Created by David Eleazar García Santiago on 23/03/13.
//  Copyright (c) 2013 David Eleazar García Santiago. All rights reserved.
//

#import "GameResultViewController.h"

@interface GameResultViewController ()

@end

@implementation GameResultViewController

- (void) setup {
}

- (void) updateUI {
    NSString *displayText = @"";
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"es_ES"];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setLocale:locale];
    
    for (GameResult *gameResult in [GameResult allGameResults]) {
        displayText = [displayText stringByAppendingFormat:@"Score: %d day: %@ duration: %gs \n", gameResult.score, [formatter stringFromDate:gameResult.start], round(gameResult.duration)];
    }
    
    self.display.text = displayText;
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updateUI];
}

- (void) awakeFromNib {
    [super awakeFromNib];
    [self setup];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    [self setup];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

#define BY_DATE_CRITERIA 0
#define BY_SCORE_CRITERIA 1
#define BY_DURATION_CRITERIA 2 

- (void) orderByCriteria:(int)criteria {
    if (criteria == BY_DATE_CRITERIA) {
    } else if (criteria == BY_SCORE_CRITERIA) {
    } else if (criteria == BY_DURATION_CRITERIA) {
    }
}

- (IBAction)orderByDate:(UIButton *)sender {
    [self orderByCriteria:BY_DATE_CRITERIA];
}

- (IBAction)ordeByScore:(UIButton *)sender {
    [self orderByCriteria:BY_SCORE_CRITERIA];
}

- (IBAction)orderByDuration:(UIButton *)sender {
    [self orderByCriteria:BY_DURATION_CRITERIA];
}

@end
