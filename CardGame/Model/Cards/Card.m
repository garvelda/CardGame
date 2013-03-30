//
//  Card.m
//  CardGame
//
//  Created by David Eleazar García Santiago on 17/03/13.
//  Copyright (c) 2013 David Eleazar García Santiago. All rights reserved.
//

#import "Card.h"

@implementation Card

- (int) match:(NSArray *)otherCards {
    int score = 0;
    
    if (otherCards) {
        for (Card *card in otherCards) {
            if ([card.contents isEqualToString:self.contents]) {
                score = 1;
            }
        }
    }
    
    return score;
}

@end
