//
//  GameViewController.h
//  CardGame
//
//  Created by David Eleazar García Santiago on 28/03/13.
//  Copyright (c) 2013 David Eleazar García Santiago. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameResult.h"
#import "CardGame.h"
#import "CardCollectionViewCell.h"

@interface CardGameViewController : UIViewController
@property (weak, nonatomic) IBOutlet UICollectionView *cardCollectionView;
@property (weak, nonatomic) IBOutlet UILabel *scoresLabel;
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastFlipLabel;
@property (strong, nonatomic) GameResult *gameResult;
@property (strong, nonatomic) CardGame *game;
@property (nonatomic) NSInteger startingCardCount;
@property (nonatomic) int flipCount;
- (Deck *) createDeck; // abstract
- (void) updateCell:(CardCollectionViewCell *)cell usingCard:(Card *)card; // abstract
@end
