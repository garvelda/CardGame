//
//  GameResult.m
//  CardGame
//
//  Created by David Eleazar García Santiago on 23/03/13.
//  Copyright (c) 2013 David Eleazar García Santiago. All rights reserved.
//

#import "GameResult.h"

@interface GameResult()
@property (readwrite, nonatomic) NSDate *start;
@property (readwrite, nonatomic) NSDate *end;
@end

@implementation GameResult

#define ALL_RESULTS_KEYS @"allResultsKey"
#define START_KEY @"starKey"
#define END_KEY @"endKey"
#define SCORE_KEY @"durationKey"

// designated initializer
- (id) init {
    self = [super init];
    
    if (self) {
        _start = [NSDate date];
        _end = _start;
    }
    
    return self;
}

- (id) initFromPropertyList:(id)plist {
    self = [self init];
    
    if (self) {
        if ([plist isKindOfClass:[NSDictionary class]]) {
            NSDictionary *propertyList = (NSDictionary *) plist;
            _start = propertyList[START_KEY];
            _end = propertyList[END_KEY];
            _score = [propertyList[SCORE_KEY] intValue];
        }
    }
    
    return self;
}

- (NSTimeInterval) duration {
    return [self.end timeIntervalSinceDate:self.start];
}

- (void) setScore:(int)score {
    _score = score;
    _end = [NSDate date];
    [self synchronize];
}

- (id) asPropertyList {
    return @{START_KEY:self.start, END_KEY:self.end, SCORE_KEY:@(self.score)};
}

- (void) synchronize {
    NSMutableDictionary *dictionaryForAllKeys = [[[NSUserDefaults standardUserDefaults] dictionaryForKey:ALL_RESULTS_KEYS] mutableCopy];
    
    if (!dictionaryForAllKeys) {
        dictionaryForAllKeys = [[NSMutableDictionary alloc] init];
    }
    
    dictionaryForAllKeys[[self.start description]] = [self asPropertyList];
    [[NSUserDefaults standardUserDefaults] setObject:dictionaryForAllKeys forKey:ALL_RESULTS_KEYS];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSArray *) allGameResults {
    NSMutableArray *allGameResults = [[NSMutableArray alloc] init];
    
    for (id plist in [[[NSUserDefaults standardUserDefaults] dictionaryForKey:ALL_RESULTS_KEYS] allValues]) {
        [allGameResults addObject:[[GameResult alloc] initFromPropertyList:plist]];
    }
    
    return allGameResults;
}

- (NSComparisonResult) compareByDate:(GameResult *) otherResult {
    return [self.start compare: otherResult.start];
}

- (NSComparisonResult) compareByScore:(GameResult *) otherResut {
    NSComparisonResult comparisonResult;
    
    if (self.score > otherResut.score) {
        comparisonResult = NSOrderedDescending;
    } else if (self.score < otherResut.score) {
        comparisonResult = NSOrderedAscending;
    } else {
        comparisonResult = NSOrderedSame;
    }
    
    return comparisonResult;
}

- (NSComparisonResult) compareByDuration:(GameResult *) otherResut {
    NSComparisonResult comparisonResult;
    
    if (self.duration > otherResut.duration) {
        comparisonResult = NSOrderedDescending;
    } else if (self.duration < otherResut.duration) {
        comparisonResult = NSOrderedAscending;
    } else {
        comparisonResult = NSOrderedSame;
    }
    
    return comparisonResult;
}

@end
