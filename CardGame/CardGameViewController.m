//
//  CardGameViewController.m
//  CardGame
//
//  Created by David Eleazar García Santiago on 17/03/13.
//  Copyright (c) 2013 David Eleazar García Santiago. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipLabel;
@property (nonatomic) int flipCount;
@end

@implementation CardGameViewController

- (void) setFlipCount:(int)flipCount {
    _flipCount = flipCount;
    self.flipLabel.text = [NSString stringWithFormat:@"Flips: %d", flipCount];
}

- (IBAction)flipCard:(UIButton *)sender {
    PlayingCardDeck *playingCardDeck = [[PlayingCardDeck alloc] init];
    Card *card = [playingCardDeck drawRamdonCard];
                                
    if (!sender.selected) {
        self.flipCount++;
    }
    
    [sender setTitle:[card contents] forState:UIControlStateSelected];
    sender.selected = !sender.isSelected;
}

@end
