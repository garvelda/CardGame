//
//  CardCollectionViewCell.h
//  CardGame
//
//  Created by David Eleazar García Santiago on 30/03/13.
//  Copyright (c) 2013 David Eleazar García Santiago. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayingCardView.h"

@interface CardCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet CardView *cardView;
@end
