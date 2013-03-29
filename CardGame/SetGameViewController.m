//
//  SetGameViewController.m
//  CardGame
//
//  Created by David Eleazar García Santiago on 28/03/13.
//  Copyright (c) 2013 David Eleazar García Santiago. All rights reserved.
//

#import "SetGameViewController.h"
#import "CardSetGame.h"
#import "SetCardDeck.h"

@interface SetGameViewController ()
@property (strong, nonatomic) CardSetGame *game;
@property (nonatomic, strong) NSDictionary *colors;
@property (nonatomic, strong) NSDictionary *shadings;
@end

@implementation SetGameViewController

#define FONT_SIZE 13
#define STROKE_WIDTH -5
#define SOLID_SHADING 1.0
#define STRIPPED_SHADING 0.5
#define OPEN_SHADING 0

- (CardGame *) game {
    if (!_game) {
        _game = [[CardSetGame alloc] initWithCardCount:self.cardButtons.count usingDeck:[[SetCardDeck alloc] init]];
    }
    
    return _game;
}

- (NSDictionary *) colors {
    return @{@"red" : [UIColor redColor], @"green" : [UIColor greenColor], @"blue" : [UIColor blueColor]};
}

- (UIColor *) color:(NSString *)color {
    return [self colors][color];
}

- (UIColor *) color:(NSString *)color withShading:(NSString *)shading {
    return [[self color:color] colorWithAlphaComponent:[self shading:shading]];
}

- (CGFloat) shading:(NSString *)shading {
    return [[self shadings][shading] floatValue];
}

- (NSDictionary *) shadings {
    return @{@"solid" : @SOLID_SHADING, @"stripped" : @STRIPPED_SHADING, @"open" : @OPEN_SHADING};
}

- (NSAttributedString *) formatCardName:(NSString *)unformattedCardName {
    NSArray *chunks = [unformattedCardName componentsSeparatedByString: @"|"];
    NSUInteger number = [chunks[0] intValue];
    NSString *symbol = chunks[1];
    NSString *color = chunks[2];
    NSString *shading = chunks[3];
    NSString *cardName = @"";
    
    for (int i=0; i<number; i++) {
        cardName = [cardName stringByAppendingString:symbol];
    }
    
    return [[NSAttributedString alloc] initWithString:cardName
                                           attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:FONT_SIZE],
                      NSForegroundColorAttributeName : [self color:color withShading:shading],
                           NSStrokeColorAttributeName: [self color:color],
                          NSStrokeWidthAttributeName : @STROKE_WIDTH}];
}

- (void) updateUI {
    for (UIButton *cardButton in self.cardButtons) {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        NSAttributedString *cardNameAttributedString = [self formatCardName:[card contents]];
        [cardButton setAttributedTitle:cardNameAttributedString forState:UIControlStateNormal];
        [cardButton setAttributedTitle:cardNameAttributedString forState:UIControlStateSelected];
        [cardButton setAttributedTitle:cardNameAttributedString forState:UIControlStateSelected|UIControlStateDisabled];
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        
        if (card.isFaceUp) {
            cardButton.alpha = card.isUnplayable ? 0 : 0.6;
        } else {
            cardButton.alpha = 1.0;
        }
    }
    
    NSMutableAttributedString *matchingString = [[NSMutableAttributedString alloc] initWithString:@"Last flip: "
                                                                                       attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:FONT_SIZE]}];
    
    if (self.game.cardsPlayed) {
        if (self.game.cardsPlayed.count == 1) {
            [matchingString appendAttributedString:[self formatCardName:[[self.game.cardsPlayed lastObject] contents]]];
        } else {
            if (self.game.cardsPlayed.count == 3) {
                if (self.game.isMatched) {
                    [matchingString appendAttributedString:[[NSAttributedString alloc] initWithString:@" Matched "
                                                                                           attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:FONT_SIZE]}]];
                    
                    for (Card *card in self.game.cardsPlayed) {
                        [matchingString appendAttributedString:[self formatCardName:[card contents]]];
                    }
                } else {
                    [matchingString appendAttributedString:[[NSAttributedString alloc] initWithString:@" Didn't match "
                                                                                           attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:FONT_SIZE]}]];
                    
                    for (Card *card in self.game.cardsPlayed) {
                        [matchingString appendAttributedString:[self formatCardName:[card contents]]];
                    }
                }
            } else {
                for (Card *card in self.game.cardsPlayed) {
                    [matchingString appendAttributedString:[self formatCardName:[card contents]]];
                }
            }
            
        }
    }
    
    self.lastFlipLabel.attributedText = [matchingString copy];
    self.scoresLabel.text = [NSString stringWithFormat:@"Scores: %d", self.game.score];
}

@end
