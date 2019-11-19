//
//  LRViewController.m
//  LRPopupMenu
//
//  Created by huawentao on 11/01/2019.
//  Copyright (c) 2019 huawentao. All rights reserved.
//

#import "LRViewController.h"
#import <LRPopupMenu/LRPopupMenu.h>

@interface LRViewController ()

@end

@implementation LRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor yellowColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor redColor];
    button.frame = CGRectMake(100, 100, 20, 20);
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
}

- (IBAction)touchssss:(id)sender {
    
    NSMutableArray *titles = @[@"hahaha", @"hahaha"].mutableCopy;
    NSMutableArray *icons = @[@"", @""].mutableCopy;

    [LRPopupMenu showRelyOnView:sender titles:titles icons:icons menuWidth:140 otherSettings:^(LRPopupMenu *popupMenu) {
        popupMenu.priorityDirection = LRPopupMenuPriorityDirectionTop;
        popupMenu.borderWidth = 1;
        popupMenu.delegate = self;
        popupMenu.fontSize = 14;
        popupMenu.borderColor = [UIColor lightGrayColor];
        popupMenu.style = LRPopupMenuStyle_TextOnly;
    }];
}

- (void)buttonAction:(UIButton *)sender
{
    NSMutableArray *titles = @[@"hahaha", @"hahaha"].mutableCopy;
    NSMutableArray *icons = @[@"", @""].mutableCopy;

    [LRPopupMenu showRelyOnView:sender titles:titles icons:icons menuWidth:140 otherSettings:^(LRPopupMenu *popupMenu) {
        popupMenu.priorityDirection = LRPopupMenuPriorityDirectionTop;
        popupMenu.borderWidth = 1;
        popupMenu.delegate = self;
        popupMenu.fontSize = 14;
        popupMenu.borderColor = [UIColor lightGrayColor];
        popupMenu.style = LRPopupMenuStyle_TextOnly;
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
