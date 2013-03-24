//
//  GameResult.h
//  CardGame
//
//  Created by David Eleazar García Santiago on 23/03/13.
//  Copyright (c) 2013 David Eleazar García Santiago. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameResult : NSObject
@property (readonly, nonatomic) NSDate *start;
@property (readonly, nonatomic) NSDate *end;
@property (readonly, nonatomic) NSTimeInterval duration;
@property (nonatomic) int score;
+ (NSArray *) allGameResults;
- (NSComparisonResult) compareByDate:(GameResult *) otherResut;
- (NSComparisonResult) compareByScore:(GameResult *) otherResut;
- (NSComparisonResult) compareByDuration:(GameResult *) otherResut;
@end
