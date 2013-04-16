//
//  CardSetGame.h
//  CardGame
//
//  Created by David Eleazar García Santiago on 27/03/13.
//  Copyright (c) 2013 David Eleazar García Santiago. All rights reserved.
//

#import "CardGame.h"
#import "SetCardDeck.h"

@interface SetCardGame : CardGame
- (void) addCardUsingDeck:(SetCardDeck *)deck;
@end
