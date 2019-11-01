
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, LRPopupMenuArrowDirection) {
    LRPopupMenuArrowDirectionTop = 0,  //箭头朝上
    LRPopupMenuArrowDirectionBottom,   //箭头朝下
    LRPopupMenuArrowDirectionLeft,     //箭头朝左
    LRPopupMenuArrowDirectionRight,    //箭头朝右
    LRPopupMenuArrowDirectionNone      //没有箭头
};

@interface LRPopupMenuPath : NSObject

+ (CAShapeLayer *)lr_maskLayerWithRect:(CGRect)rect
                            rectCorner:(UIRectCorner)rectCorner
                          cornerRadius:(CGFloat)cornerRadius
                            arrowWidth:(CGFloat)arrowWidth
                           arrowHeight:(CGFloat)arrowHeight
                         arrowPosition:(CGFloat)arrowPosition
                        arrowDirection:(LRPopupMenuArrowDirection)arrowDirection;

+ (UIBezierPath *)lr_bezierPathWithRect:(CGRect)rect
                             rectCorner:(UIRectCorner)rectCorner
                           cornerRadius:(CGFloat)cornerRadius
                            borderWidth:(CGFloat)borderWidth
                            borderColor:(UIColor *)borderColor
                        backgroundColor:(UIColor *)backgroundColor
                             arrowWidth:(CGFloat)arrowWidth
                            arrowHeight:(CGFloat)arrowHeight
                          arrowPosition:(CGFloat)arrowPosition
                         arrowDirection:(LRPopupMenuArrowDirection)arrowDirection;
@end
