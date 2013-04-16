//
//  SetGameViewController.m
//  CardGame
//
//  Created by David Eleazar García Santiago on 28/03/13.
//  Copyright (c) 2013 David Eleazar García Santiago. All rights reserved.
//

#import "SetCardGameViewController.h"
#import "SetCardGame.h"
#import "SetCardDeck.h"
#import "SetCardView.h"
#import "SetCard.h"

@interface SetCardGameViewController ()
@property (nonatomic, strong) NSDictionary *colors;
@property (nonatomic, strong) NSDictionary *shadings;
@property (nonatomic, strong) SetCardDeck *deck;
@property (weak, nonatomic) IBOutlet UIButton *threeMoreCardsButton;
@end

@implementation SetCardGameViewController

- (SetCardDeck *) deck {
    if (!_deck) {
        _deck = [[SetCardDeck alloc] init];
    }
    
    return _deck;
}

- (Deck *) createDeck {
    if ([self.deck numberOfCardsInDeck] == 0) {
        self.deck = nil;
    }
    
    return self.deck;
}

- (NSInteger) startingCardCount {
    return 12;
}

- (void) updateCell:(CardCollectionViewCell *)cell usingCard:(Card *)card {
    if ([card isKindOfClass:[SetCard class]]) {
        SetCard *setCard = (SetCard *) card;
        
        if ([cell.cardView isKindOfClass:[SetCardView class]]) {
            SetCardView *setCardView = (SetCardView *) cell.cardView;
            setCardView.rank = setCard.rank;
            setCardView.symbol = setCard.symbol;
            setCardView.shading = setCard.shading;
            setCardView.color = setCard.color;
            setCardView.faceUp = setCard.faceUp;
            setCardView.alpha = setCard.faceUp ? 0.5 : 1.0;
        }
    }
}

- (IBAction)threeMoreCards:(UIButton *)sender {
    if ([self.game isKindOfClass:[SetCardGame class]]) {
        NSUInteger cardsCount = [self.game.cards count];
        SetCardGame *setCardGame = (SetCardGame *) self.game;
        
        if (setCardGame) {
            for (int index=0; index<3; index++) {
                [setCardGame addCardUsingDeck:self.deck];
            }
        }
        
        NSMutableArray *arrayWithIndexPaths = [NSMutableArray array];
        
        for (int i=cardsCount; i<cardsCount+3; i++)
            [arrayWithIndexPaths addObject:[NSIndexPath indexPathForRow:i inSection:0]];
        
        [self.cardCollectionView insertItemsAtIndexPaths:arrayWithIndexPaths];
        [self updateUI];
    }
}

- (void) updateUI {
    NSMutableArray *indexesToDelete = [[NSMutableArray alloc] init];
    
    for (CardCollectionViewCell *cell in [self.cardCollectionView visibleCells]) {
        NSIndexPath *indexPath = [self.cardCollectionView indexPathForCell:cell];
        Card *card = [self.game cardAtIndex:indexPath.item];
        
        if (card.isUnplayable) {
            [indexesToDelete addObject:indexPath];
        } else {
            [self updateCell:cell usingCard:card];
        }
    }
    
    if (self.game.isMatched) {
        [self.game removeCards:[indexesToDelete copy]];
        [self.cardCollectionView deleteItemsAtIndexPaths:indexesToDelete];
    }
    
    self.threeMoreCardsButton.enabled = [self.deck numberOfCardsInDeck] < 3 ? NO : YES;
    self.threeMoreCardsButton.alpha = [self.deck numberOfCardsInDeck] < 3 ? 0.3 : 1.0;
    self.scoresLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
}

@end
