
#import "LRPopupMenuPath.h"
#import "LRRectConst.h"

@implementation LRPopupMenuPath

+ (CAShapeLayer *)lr_maskLayerWithRect:(CGRect)rect
                            rectCorner:(UIRectCorner)rectCorner
                          cornerRadius:(CGFloat)cornerRadius
                            arrowWidth:(CGFloat)arrowWidth
                           arrowHeight:(CGFloat)arrowHeight
                         arrowPosition:(CGFloat)arrowPosition
                        arrowDirection:(LRPopupMenuArrowDirection)arrowDirection
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = [self lr_bezierPathWithRect:rect rectCorner:rectCorner cornerRadius:cornerRadius borderWidth:0 borderColor:nil backgroundColor:nil arrowWidth:arrowWidth arrowHeight:arrowHeight arrowPosition:arrowPosition arrowDirection:arrowDirection].CGPath;
    return shapeLayer;
}


+ (UIBezierPath *)lr_bezierPathWithRect:(CGRect)rect
                             rectCorner:(UIRectCorner)rectCorner
                           cornerRadius:(CGFloat)cornerRadius
                            borderWidth:(CGFloat)borderWidth
                            borderColor:(UIColor *)borderColor
                        backgroundColor:(UIColor *)backgroundColor
                             arrowWidth:(CGFloat)arrowWidth
                            arrowHeight:(CGFloat)arrowHeight
                          arrowPosition:(CGFloat)arrowPosition
                         arrowDirection:(LRPopupMenuArrowDirection)arrowDirection
{
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    if (borderColor) {
        [borderColor setStroke];
    }
    if (backgroundColor) {
        [backgroundColor setFill];
    }
    bezierPath.lineWidth = borderWidth;
    rect = CGRectMake(borderWidth / 2, borderWidth / 2, LRRectWidth(rect) - borderWidth, LRRectHeight(rect) - borderWidth);
    CGFloat topRightRadius = 0,topLeftRadius = 0,bottomRightRadius = 0,bottomLeftRadius = 0;
    CGPoint topRightArcCenter,topLeftArcCenter,bottomRightArcCenter,bottomLeftArcCenter;
    
    if (rectCorner & UIRectCornerTopLeft) {
        topLeftRadius = cornerRadius;
    }
    if (rectCorner & UIRectCornerTopRight) {
        topRightRadius = cornerRadius;
    }
    if (rectCorner & UIRectCornerBottomLeft) {
        bottomLeftRadius = cornerRadius;
    }
    if (rectCorner & UIRectCornerBottomRight) {
        bottomRightRadius = cornerRadius;
    }
    
    if (arrowDirection == LRPopupMenuArrowDirectionTop) {
        topLeftArcCenter = CGPointMake(topLeftRadius + LRRectX(rect), arrowHeight + topLeftRadius + LRRectX(rect));
        topRightArcCenter = CGPointMake(LRRectWidth(rect) - topRightRadius + LRRectX(rect), arrowHeight + topRightRadius + LRRectX(rect));
        bottomLeftArcCenter = CGPointMake(bottomLeftRadius + LRRectX(rect), LRRectHeight(rect) - bottomLeftRadius + LRRectX(rect));
        bottomRightArcCenter = CGPointMake(LRRectWidth(rect) - bottomRightRadius + LRRectX(rect), LRRectHeight(rect) - bottomRightRadius + LRRectX(rect));
        if (arrowPosition < topLeftRadius + arrowWidth / 2) {
            arrowPosition = topLeftRadius + arrowWidth / 2;
        }else if (arrowPosition > LRRectWidth(rect) - topRightRadius - arrowWidth / 2) {
            arrowPosition = LRRectWidth(rect) - topRightRadius - arrowWidth / 2;
        }
        [bezierPath moveToPoint:CGPointMake(arrowPosition - arrowWidth / 2, arrowHeight + LRRectX(rect))];
        [bezierPath addLineToPoint:CGPointMake(arrowPosition, LRRectTop(rect) + LRRectX(rect))];
        [bezierPath addLineToPoint:CGPointMake(arrowPosition + arrowWidth / 2, arrowHeight + LRRectX(rect))];
        [bezierPath addLineToPoint:CGPointMake(LRRectWidth(rect) - topRightRadius, arrowHeight + LRRectX(rect))];
        [bezierPath addArcWithCenter:topRightArcCenter radius:topRightRadius startAngle:M_PI * 3 / 2 endAngle:2 * M_PI clockwise:YES];
        [bezierPath addLineToPoint:CGPointMake(LRRectWidth(rect) + LRRectX(rect), LRRectHeight(rect) - bottomRightRadius - LRRectX(rect))];
        [bezierPath addArcWithCenter:bottomRightArcCenter radius:bottomRightRadius startAngle:0 endAngle:M_PI_2 clockwise:YES];
        [bezierPath addLineToPoint:CGPointMake(bottomLeftRadius + LRRectX(rect), LRRectHeight(rect) + LRRectX(rect))];
        [bezierPath addArcWithCenter:bottomLeftArcCenter radius:bottomLeftRadius startAngle:M_PI_2 endAngle:M_PI clockwise:YES];
        [bezierPath addLineToPoint:CGPointMake(LRRectX(rect), arrowHeight + topLeftRadius + LRRectX(rect))];
        [bezierPath addArcWithCenter:topLeftArcCenter radius:topLeftRadius startAngle:M_PI endAngle:M_PI * 3 / 2 clockwise:YES];
        
    }else if (arrowDirection == LRPopupMenuArrowDirectionBottom) {
        topLeftArcCenter = CGPointMake(topLeftRadius + LRRectX(rect),topLeftRadius + LRRectX(rect));
        topRightArcCenter = CGPointMake(LRRectWidth(rect) - topRightRadius + LRRectX(rect), topRightRadius + LRRectX(rect));
        bottomLeftArcCenter = CGPointMake(bottomLeftRadius + LRRectX(rect), LRRectHeight(rect) - bottomLeftRadius + LRRectX(rect) - arrowHeight);
        bottomRightArcCenter = CGPointMake(LRRectWidth(rect) - bottomRightRadius + LRRectX(rect), LRRectHeight(rect) - bottomRightRadius + LRRectX(rect) - arrowHeight);
        if (arrowPosition < bottomLeftRadius + arrowWidth / 2) {
            arrowPosition = bottomLeftRadius + arrowWidth / 2;
        }else if (arrowPosition > LRRectWidth(rect) - bottomRightRadius - arrowWidth / 2) {
            arrowPosition = LRRectWidth(rect) - bottomRightRadius - arrowWidth / 2;
        }
        [bezierPath moveToPoint:CGPointMake(arrowPosition + arrowWidth / 2, LRRectHeight(rect) - arrowHeight + LRRectX(rect))];
        [bezierPath addLineToPoint:CGPointMake(arrowPosition, LRRectHeight(rect) + LRRectX(rect))];
        [bezierPath addLineToPoint:CGPointMake(arrowPosition - arrowWidth / 2, LRRectHeight(rect) - arrowHeight + LRRectX(rect))];
        [bezierPath addLineToPoint:CGPointMake(bottomLeftRadius + LRRectX(rect), LRRectHeight(rect) - arrowHeight + LRRectX(rect))];
        [bezierPath addArcWithCenter:bottomLeftArcCenter radius:bottomLeftRadius startAngle:M_PI_2 endAngle:M_PI clockwise:YES];
        [bezierPath addLineToPoint:CGPointMake(LRRectX(rect), topLeftRadius + LRRectX(rect))];
        [bezierPath addArcWithCenter:topLeftArcCenter radius:topLeftRadius startAngle:M_PI endAngle:M_PI * 3 / 2 clockwise:YES];
        [bezierPath addLineToPoint:CGPointMake(LRRectWidth(rect) - topRightRadius + LRRectX(rect), LRRectX(rect))];
        [bezierPath addArcWithCenter:topRightArcCenter radius:topRightRadius startAngle:M_PI * 3 / 2 endAngle:2 * M_PI clockwise:YES];
        [bezierPath addLineToPoint:CGPointMake(LRRectWidth(rect) + LRRectX(rect), LRRectHeight(rect) - bottomRightRadius - LRRectX(rect) - arrowHeight)];
        [bezierPath addArcWithCenter:bottomRightArcCenter radius:bottomRightRadius startAngle:0 endAngle:M_PI_2 clockwise:YES];
        
    }else if (arrowDirection == LRPopupMenuArrowDirectionLeft) {
        topLeftArcCenter = CGPointMake(topLeftRadius + LRRectX(rect) + arrowHeight,topLeftRadius + LRRectX(rect));
        topRightArcCenter = CGPointMake(LRRectWidth(rect) - topRightRadius + LRRectX(rect), topRightRadius + LRRectX(rect));
        bottomLeftArcCenter = CGPointMake(bottomLeftRadius + LRRectX(rect) + arrowHeight, LRRectHeight(rect) - bottomLeftRadius + LRRectX(rect));
        bottomRightArcCenter = CGPointMake(LRRectWidth(rect) - bottomRightRadius + LRRectX(rect), LRRectHeight(rect) - bottomRightRadius + LRRectX(rect));
        if (arrowPosition < topLeftRadius + arrowWidth / 2) {
            arrowPosition = topLeftRadius + arrowWidth / 2;
        }else if (arrowPosition > LRRectHeight(rect) - bottomLeftRadius - arrowWidth / 2) {
            arrowPosition = LRRectHeight(rect) - bottomLeftRadius - arrowWidth / 2;
        }
        [bezierPath moveToPoint:CGPointMake(arrowHeight + LRRectX(rect), arrowPosition + arrowWidth / 2)];
        [bezierPath addLineToPoint:CGPointMake(LRRectX(rect), arrowPosition)];
        [bezierPath addLineToPoint:CGPointMake(arrowHeight + LRRectX(rect), arrowPosition - arrowWidth / 2)];
        [bezierPath addLineToPoint:CGPointMake(arrowHeight + LRRectX(rect), topLeftRadius + LRRectX(rect))];
        [bezierPath addArcWithCenter:topLeftArcCenter radius:topLeftRadius startAngle:M_PI endAngle:M_PI * 3 / 2 clockwise:YES];
        [bezierPath addLineToPoint:CGPointMake(LRRectWidth(rect) - topRightRadius, LRRectX(rect))];
        [bezierPath addArcWithCenter:topRightArcCenter radius:topRightRadius startAngle:M_PI * 3 / 2 endAngle:2 * M_PI clockwise:YES];
        [bezierPath addLineToPoint:CGPointMake(LRRectWidth(rect) + LRRectX(rect), LRRectHeight(rect) - bottomRightRadius - LRRectX(rect))];
        [bezierPath addArcWithCenter:bottomRightArcCenter radius:bottomRightRadius startAngle:0 endAngle:M_PI_2 clockwise:YES];
        [bezierPath addLineToPoint:CGPointMake(arrowHeight + bottomLeftRadius + LRRectX(rect), LRRectHeight(rect) + LRRectX(rect))];
        [bezierPath addArcWithCenter:bottomLeftArcCenter radius:bottomLeftRadius startAngle:M_PI_2 endAngle:M_PI clockwise:YES];
        
    }else if (arrowDirection == LRPopupMenuArrowDirectionRight) {
        topLeftArcCenter = CGPointMake(topLeftRadius + LRRectX(rect),topLeftRadius + LRRectX(rect));
        topRightArcCenter = CGPointMake(LRRectWidth(rect) - topRightRadius + LRRectX(rect) - arrowHeight, topRightRadius + LRRectX(rect));
        bottomLeftArcCenter = CGPointMake(bottomLeftRadius + LRRectX(rect), LRRectHeight(rect) - bottomLeftRadius + LRRectX(rect));
        bottomRightArcCenter = CGPointMake(LRRectWidth(rect) - bottomRightRadius + LRRectX(rect) - arrowHeight, LRRectHeight(rect) - bottomRightRadius + LRRectX(rect));
        if (arrowPosition < topRightRadius + arrowWidth / 2) {
            arrowPosition = topRightRadius + arrowWidth / 2;
        }else if (arrowPosition > LRRectHeight(rect) - bottomRightRadius - arrowWidth / 2) {
            arrowPosition = LRRectHeight(rect) - bottomRightRadius - arrowWidth / 2;
        }
        [bezierPath moveToPoint:CGPointMake(LRRectWidth(rect) - arrowHeight + LRRectX(rect), arrowPosition - arrowWidth / 2)];
        [bezierPath addLineToPoint:CGPointMake(LRRectWidth(rect) + LRRectX(rect), arrowPosition)];
        [bezierPath addLineToPoint:CGPointMake(LRRectWidth(rect) - arrowHeight + LRRectX(rect), arrowPosition + arrowWidth / 2)];
        [bezierPath addLineToPoint:CGPointMake(LRRectWidth(rect) - arrowHeight + LRRectX(rect), LRRectHeight(rect) - bottomRightRadius - LRRectX(rect))];
        [bezierPath addArcWithCenter:bottomRightArcCenter radius:bottomRightRadius startAngle:0 endAngle:M_PI_2 clockwise:YES];
        [bezierPath addLineToPoint:CGPointMake(bottomLeftRadius + LRRectX(rect), LRRectHeight(rect) + LRRectX(rect))];
        [bezierPath addArcWithCenter:bottomLeftArcCenter radius:bottomLeftRadius startAngle:M_PI_2 endAngle:M_PI clockwise:YES];
        [bezierPath addLineToPoint:CGPointMake(LRRectX(rect), arrowHeight + topLeftRadius + LRRectX(rect))];
        [bezierPath addArcWithCenter:topLeftArcCenter radius:topLeftRadius startAngle:M_PI endAngle:M_PI * 3 / 2 clockwise:YES];
        [bezierPath addLineToPoint:CGPointMake(LRRectWidth(rect) - topRightRadius + LRRectX(rect) - arrowHeight, LRRectX(rect))];
        [bezierPath addArcWithCenter:topRightArcCenter radius:topRightRadius startAngle:M_PI * 3 / 2 endAngle:2 * M_PI clockwise:YES];
        
    }else if (arrowDirection == LRPopupMenuArrowDirectionNone) {
        topLeftArcCenter = CGPointMake(topLeftRadius + LRRectX(rect),  topLeftRadius + LRRectX(rect));
        topRightArcCenter = CGPointMake(LRRectWidth(rect) - topRightRadius + LRRectX(rect),  topRightRadius + LRRectX(rect));
        bottomLeftArcCenter = CGPointMake(bottomLeftRadius + LRRectX(rect), LRRectHeight(rect) - bottomLeftRadius + LRRectX(rect));
        bottomRightArcCenter = CGPointMake(LRRectWidth(rect) - bottomRightRadius + LRRectX(rect), LRRectHeight(rect) - bottomRightRadius + LRRectX(rect));
        [bezierPath moveToPoint:CGPointMake(topLeftRadius + LRRectX(rect), LRRectX(rect))];
        [bezierPath addLineToPoint:CGPointMake(LRRectWidth(rect) - topRightRadius, LRRectX(rect))];
        [bezierPath addArcWithCenter:topRightArcCenter radius:topRightRadius startAngle:M_PI * 3 / 2 endAngle:2 * M_PI clockwise:YES];
        [bezierPath addLineToPoint:CGPointMake(LRRectWidth(rect) + LRRectX(rect), LRRectHeight(rect) - bottomRightRadius - LRRectX(rect))];
        [bezierPath addArcWithCenter:bottomRightArcCenter radius:bottomRightRadius startAngle:0 endAngle:M_PI_2 clockwise:YES];
        [bezierPath addLineToPoint:CGPointMake(bottomLeftRadius + LRRectX(rect), LRRectHeight(rect) + LRRectX(rect))];
        [bezierPath addArcWithCenter:bottomLeftArcCenter radius:bottomLeftRadius startAngle:M_PI_2 endAngle:M_PI clockwise:YES];
        [bezierPath addLineToPoint:CGPointMake(LRRectX(rect), arrowHeight + topLeftRadius + LRRectX(rect))];
        [bezierPath addArcWithCenter:topLeftArcCenter radius:topLeftRadius startAngle:M_PI endAngle:M_PI * 3 / 2 clockwise:YES];
    }
    
    [bezierPath closePath];
    return bezierPath;
}

@end
