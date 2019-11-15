
#import <UIKit/UIKit.h>
#import "LRPopupMenuPath.h"

// 过期提醒
#define LRDeprecated(instead) NS_DEPRECATED(2_0, 2_0, 2_0, 2_0, instead)

typedef NS_ENUM(NSInteger , LRPopupMenuType) {
    LRPopupMenuTypeDefault = 0,
    LRPopupMenuTypeDark
};

typedef NS_OPTIONS(NSInteger, LRPopupMenuStyle) {
    LRPopupMenuStyle_Default = 0,
    LRPopupMenuStyle_TextOnly = 1,
    LRPopupMenuStyle_ImageOnly = 2,
};

/**
 箭头方向优先级

 当控件超出屏幕时会自动调整成反方向
 */
typedef NS_ENUM(NSInteger , LRPopupMenuPriorityDirection) {
    LRPopupMenuPriorityDirectionTop = 0,  //Default
    LRPopupMenuPriorityDirectionBottom,
    LRPopupMenuPriorityDirectionLeft,
    LRPopupMenuPriorityDirectionRight,
    LRPopupMenuPriorityDirectionNone      //不自动调整
};

@class LRPopupMenu;
@protocol LRPopupMenuDelegate <NSObject>

@optional

- (void)lrPopupMenuBeganDismiss;
- (void)lrPopupMenuDidDismiss;
- (void)lrPopupMenuBeganShow;
- (void)lrPopupMenuDidShow;

///////新版本/////////
- (void)lrPopupMenu:(LRPopupMenu *)lrPopupMenu didSelectedAtIndex:(NSInteger)index;

/**
 自定义cell
 
 可以自定义cell，设置后会忽略 fontSize textColor backColor type 属性
 cell 的高度是根据 itemHeight 的，直接设置无效
 建议cell 背景色设置为透明色，不然切的圆角显示不出来
 */
- (UITableViewCell *)lrPopupMenu:(LRPopupMenu *)lrPopupMenu cellForRowAtIndex:(NSInteger)index;

@end

@interface LRPopupMenu : UIView

/**
 标题数组 只读属性
 */
@property (nonatomic, strong, readonly) NSArray  * titles;

/**
 图片数组 只读属性
 */
@property (nonatomic, strong, readonly) NSArray  * images;

/**
 tableView  Default separatorStyle is UITableViewCellSeparatorStyleNone
 */
@property (nonatomic, strong) UITableView * tableView;

/**
 圆角半径 Default is 5.0
 */
@property (nonatomic, assign) CGFloat cornerRadius;

/**
 自定义圆角 Default is UIRectCornerAllCorners
 
 当自动调整方向时corner会自动转换至镜像方向
 */
@property (nonatomic, assign) UIRectCorner rectCorner;

/**
 是否显示阴影 Default is YES
 */
@property (nonatomic, assign , getter=isShadowShowing) BOOL isShowShadow;

/**
 是否显示灰色覆盖层 Default is YES
 */
@property (nonatomic, assign) BOOL showMaskView;

/**
 覆盖层颜色 Default is [[UIColor blackColor] colorWithAlphaComponent:0.1]
 */
@property (nonatomic, strong) UIColor *maskViewColor;

/**
 选择菜单项后消失 Default is YES
 */
@property (nonatomic, assign) BOOL dismissOnSelected;

/**
 点击菜单外消失  Default is YES
 */
@property (nonatomic, assign) BOOL dismissOnTouchOutside;

/**
 设置字体大小 自定义cell时忽略 Default is 15
 */
@property (nonatomic, assign) CGFloat fontSize;

/**
 设置图片大小 自定义cell时忽略 Default is (18, 18)
 */
@property (nonatomic, assign) CGSize iconSize;

/**
 设置字体颜色 自定义cell时忽略 Default is [UIColor blackColor]
 */
@property (nonatomic, strong) UIColor * textColor;

/**
 设置偏移距离 (>= 0) Default is 0.0
 */
@property (nonatomic, assign) CGFloat offset;

/**
 边框宽度 Default is 0.0
 
 设置边框需 > 0
 */
@property (nonatomic, assign) CGFloat borderWidth;

/**
 边框颜色 Default is LightGrayColor
 
 borderWidth <= 0 无效
 */
@property (nonatomic, strong) UIColor * borderColor;

/**
 箭头宽度 Default is 15
 */
@property (nonatomic, assign) CGFloat arrowWidth;

/**
 箭头高度 Default is 10
 */
@property (nonatomic, assign) CGFloat arrowHeight;

/**
 箭头位置 Default is center
 
 只有箭头优先级是LRPopupMenuPriorityDirectionLeft/LRPopupMenuPriorityDirectionRight/LRPopupMenuPriorityDirectionNone时需要设置
 */
@property (nonatomic, assign) CGFloat arrowPosition;

/**
 箭头方向 Default is LRPopupMenuArrowDirectionTop
 */
@property (nonatomic, assign) LRPopupMenuArrowDirection arrowDirection;

/**
 箭头优先方向 Default is LRPopupMenuPriorityDirectionTop
 
 当控件超出屏幕时会自动调整箭头位置
 */
@property (nonatomic, assign) LRPopupMenuPriorityDirection priorityDirection;

/**
 可见的最大行数 Default is 5;
 */
@property (nonatomic, assign) NSInteger maxVisibleCount;

/**
 menu背景色 自定义cell时忽略 Default is WhiteColor
 */
@property (nonatomic, strong) UIColor * backColor;

/**
 item的高度 Default is 44;
 */
@property (nonatomic, assign) CGFloat itemHeight;

/**
 popupMenu距离最近的Screen的距离 Default is 10
 */
@property (nonatomic, assign) CGFloat minSpace;

/**
 设置显示模式 自定义cell时忽略 Default is LRPopupMenuTypeDefault
 */
@property (nonatomic, assign) LRPopupMenuType type;

/**
 设置显示风格 自定义cell时忽略 Default is LRPopupMenuStyle_Default
 */
@property (nonatomic, assign) LRPopupMenuStyle style;

/**
 代理
 */
@property (nonatomic, weak) id <LRPopupMenuDelegate> delegate;

/**
 在指定位置弹出
 
 @param titles    标题数组  数组里是NSString/NSAttributedString
 @param icons     图标数组  数组里是NSString/UIImage
 @param itemWidth 菜单宽度
 @param delegate  代理
 */
+ (LRPopupMenu *)showAtPoint:(CGPoint)point
                     titles:(NSArray *)titles
                      icons:(NSArray *)icons
                  menuWidth:(CGFloat)itemWidth
                   delegate:(id<LRPopupMenuDelegate>)delegate;

/**
 在指定位置弹出(推荐方法)
 
 @param point          弹出的位置
 @param titles         标题数组  数组里是NSString/NSAttributedString
 @param icons          图标数组  数组里是NSString/UIImage
 @param itemWidth      菜单宽度
 @param otherSetting   其他设置
 */
+ (LRPopupMenu *)showAtPoint:(CGPoint)point
                      titles:(NSArray *)titles
                       icons:(NSArray *)icons
                   menuWidth:(CGFloat)itemWidth
               otherSettings:(void (^) (LRPopupMenu * popupMenu))otherSetting;

/**
 依赖指定view弹出
 
 @param titles    标题数组  数组里是NSString/NSAttributedString
 @param icons     图标数组  数组里是NSString/UIImage
 @param itemWidth 菜单宽度
 @param delegate  代理
 */
+ (LRPopupMenu *)showRelyOnView:(UIView *)view
                        titles:(NSArray *)titles
                         icons:(NSArray *)icons
                     menuWidth:(CGFloat)itemWidth
                      delegate:(id<LRPopupMenuDelegate>)delegate;

/**
 依赖指定view弹出(推荐方法)

 @param titles         标题数组  数组里是NSString/NSAttributedString
 @param icons          图标数组  数组里是NSString/UIImage
 @param itemWidth      菜单宽度
 @param otherSetting   其他设置
 */
+ (LRPopupMenu *)showRelyOnView:(UIView *)view
                         titles:(NSArray *)titles
                          icons:(NSArray *)icons
                      menuWidth:(CGFloat)itemWidth
                  otherSettings:(void (^) (LRPopupMenu * popupMenu))otherSetting;

/**
 消失
 */
- (void)dismiss;

@end
