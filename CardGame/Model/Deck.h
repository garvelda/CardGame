//
//  Deck.h
//  CardGame
//
//  Created by David Eleazar García Santiago on 17/03/13.
//  Copyright (c) 2013 David Eleazar García Santiago. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject
- (void) addcard:(Card *) card atTop:(BOOL) top;
- (Card *) drawRamdonCard;
@end
