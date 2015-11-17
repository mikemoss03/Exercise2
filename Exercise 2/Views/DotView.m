//
//  DotView.m
//  Exercise 2
//
//  Created by Mike on 2/10/14.
//  Copyright (c) 2014 Mike. All rights reserved.
//

#import "DotView.h"

@implementation DotView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

//Draw dots view
- (void)drawRect:(CGRect)rect
{
    NSInteger colorIndex = 0;
    NSInteger dotWidth = MAX((self.bounds.size.width / _coloumns.integerValue), 2);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //Loop through each row
    for (int i = 0; i < _rows.integerValue; i++) {
        //Add a dot for each column
        for (int j = 0; j < _coloumns.integerValue; j++) {
            CGRect rect = CGRectMake(j * dotWidth, i * dotWidth, dotWidth, dotWidth);
            
            //Add dot
            CGContextAddEllipseInRect(ctx, rect);
            CGContextSetFillColorWithColor(ctx, ((UIColor *)[_colors objectAtIndex:colorIndex]).CGColor);
            CGContextFillPath(ctx);
            
            //Stroke dot with white outline
            CGContextSetLineWidth(ctx, 1);
            CGContextSetStrokeColorWithColor(ctx, [UIColor whiteColor].CGColor);
            CGContextStrokeEllipseInRect(ctx, rect);
            
            //move to the next color
            colorIndex = (colorIndex >= _colors.count - 1) ? 0 : colorIndex + 1;
        }
    }
}

//Return an UIImage from UIView
-(UIImage *)imageRepresentation
{
    UIGraphicsBeginImageContext(self.frame.size);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    return UIGraphicsGetImageFromCurrentImageContext();
}

//Remove all dots
-(void)clearDots
{
    _coloumns = 0;
    _rows = 0;
    [self setNeedsDisplay];
}

@end
