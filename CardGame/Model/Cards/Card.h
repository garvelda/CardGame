//
//  Card.h
//  CardGame
//
//  Created by David Eleazar García Santiago on 17/03/13.
//  Copyright (c) 2013 David Eleazar García Santiago. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject
@property (strong, nonatomic) NSString *contents;
@property (nonatomic, getter=isFaceUp) BOOL faceUp;
@property (nonatomic, getter = isUnplayable) BOOL unplayable;
- (int) match: (NSArray *) otherCards;
@end
