//
//  DotView.h
//  Exercise 2
//
//  Created by Mike on 2/10/14.
//  Copyright (c) 2014 Mike. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DotView : UIView

@property (nonatomic, strong) NSNumber *rows;
@property (nonatomic, strong) NSNumber *coloumns;
@property (nonatomic, strong) NSArray *colors;

-(UIImage *)imageRepresentation;
-(void)clearDots;

@end
