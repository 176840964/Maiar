//
//  UILabel+VerticalAlign.m
//  MaiYa
//
//  Created by zxl on 15/8/28.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "UILabel+VerticalAlign.h"

@implementation UILabel (VerticalAlign)
- (void)alignTop {
//    CGSize fontSize =[self.text sizeWithFont:self.font];
    CGSize fontSize = [self.text sizeWithAttributes:@{NSFontAttributeName: self.font}];
    double finalHeight = fontSize.height * self.numberOfLines;
    double finalWidth = self.frame.size.width;//expected width of label
//    CGSize theStringSize =[self.text sizeWithFont:self.font constrainedToSize:CGSizeMake(finalWidth, finalHeight) lineBreakMode:self.lineBreakMode];
    CGSize theStringSize = [self.text boundingRectWithSize:CGSizeMake(finalWidth, finalHeight) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: self.font} context:nil].size;
    int newLinesToPad =(finalHeight - theStringSize.height)/ fontSize.height;
    for(int i=0; i<newLinesToPad; i++)
        self.text =[self.text stringByAppendingString:@"\n "];
}

- (void)alignBottom {
//    CGSize fontSize =[self.text sizeWithFont:self.font];
    CGSize fontSize = [self.text sizeWithAttributes:@{NSFontAttributeName: self.font}];
    double finalHeight = fontSize.height *self.numberOfLines;
    double finalWidth =self.frame.size.width;//expected width of label
//    CGSize theStringSize =[self.text sizeWithFont:self.font constrainedToSize:CGSizeMake(finalWidth, finalHeight) lineBreakMode:self.lineBreakMode];
    CGSize theStringSize = [self.text boundingRectWithSize:CGSizeMake(finalWidth, finalHeight) options:NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName: self.font} context:nil].size;
    int newLinesToPad =(finalHeight - theStringSize.height)/ fontSize.height;
    for(int i=0; i<newLinesToPad; i++)
        self.text =[NSString stringWithFormat:@" \n%@",self.text];
}
@end
