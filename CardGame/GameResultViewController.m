//
//  GameResultViewController.m
//  CardGame
//
//  Created by David Eleazar García Santiago on 23/03/13.
//  Copyright (c) 2013 David Eleazar García Santiago. All rights reserved.
//

#import "GameResultViewController.h"

@interface GameResultViewController ()
@property (nonatomic) SEL sortSelector;
@end

@implementation GameResultViewController

@synthesize sortSelector = _sortSelector;

- (SEL) sortSelector {
    if (!_sortSelector) {
        _sortSelector = @selector(compareByDate:);
    }
    
    return _sortSelector;
}

- (void) setSortSelector:(SEL)sortSelector {
    _sortSelector = sortSelector;
    [self updateUI];
}

- (void) setup {
}

- (void) updateUI {
    NSString *displayText = @"";
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"es_ES"];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setLocale:locale];
    
    for (GameResult *gameResult in [[GameResult allGameResults] sortedArrayUsingSelector:self.sortSelector]) {
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

- (IBAction)orderByDate:(UIButton *)sender {
    self.sortSelector = @selector(compareByDate:);
}

- (IBAction)ordeByScore:(UIButton *)sender {
    self.sortSelector = @selector(compareByScore:);
}

- (IBAction)orderByDuration:(UIButton *)sender {
    self.sortSelector = @selector(compareByDuration:);
}

@end
