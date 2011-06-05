//
//  secondViewController.m
//  Bling Home
//
//  Created by Y WT on 11-4-21.
//  Copyright 2011 TJU. All rights reserved.
//

#import "secondViewController.h"
#import "nstimer.h"
#import "generateQuestion.h"
#import <NSArray.h>

@implementation secondViewController
@synthesize firstNumb,secondNum,resultNum,symbol,question,total,correct, answer;
@synthesize buttonPressed,runNotRepeat,gameTime;//moveVelocity;
@synthesize answer1,answer2,answer3,answer4;
@synthesize lastAnimation;
@synthesize finshView;
#define speed 3.92//这样设置可以改变按钮走过的时间

- (id)initWithNibName:(NSString*)nibName bundle:(NSBundle*)nibBundle onPage:(int)button_id
{
    self = [super initWithNibName:nibName bundle:nibBundle];
    if(self == nil)
    {
        return nil;
    }
    selectQuestionSender = button_id;
    return self;
}



-(IBAction)answer1Pressed:(UIButton*)answerButton1{
    buttonPressed=YES;
    if(answerButton1.tag!=symbol)
    {
        total++;
    }
    else
    {
        total++;
        correct++;
    }
    if (total>10) 
    {
        [self runGameState2];

    }	
}


-(void)timeOver{
    if(total<11){
        [self runGameState2];
    }
    else {  
        NSLog(@"Time over!");
        answer1.userInteractionEnabled=NO;
        answer2.userInteractionEnabled=NO;
        answer3.userInteractionEnabled=NO;
        answer4.userInteractionEnabled=NO;
   }
}


-(void)runGame{
    gameTime=[NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(buttonMove) userInfo:nil repeats:YES];
}

-(void)runGameState2{
    answer1.userInteractionEnabled=NO;
    answer2.userInteractionEnabled=NO;
    answer3.userInteractionEnabled=NO;
    answer4.userInteractionEnabled=NO;
    [gameTime invalidate];

    CGRect lastViewFrame=CGRectMake(20, 20, 280, 179);//某一个四边形
    finshView=[[UIView alloc] initWithFrame:lastViewFrame];
    finshView.backgroundColor=[UIColor blackColor];
    finshView.alpha=0.7;	
    UIButton* finshButton1= [[UIButton alloc] initWithFrame:CGRectMake(60,142, 72, 37)];
    UIButton* finshButton2= [[UIButton alloc] initWithFrame:CGRectMake(174,142, 72, 37)];
    [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [finshButton1 setBackgroundImage:nil forState:UIControlStateNormal];
    [finshButton1 addTarget:self 
       action:@selector(finshButton1Pressed)
    forControlEvents:UIControlEventTouchDown]; 
    [finshButton2 setBackgroundImage:nil forState:UIControlStateNormal];
    [finshButton2 addTarget:self action:@selector(finshButton2Pressed)
    forControlEvents:UIControlEventTouchDown];
    [finshButton1 setBackgroundColor:[UIColor blueColor]];
    [finshButton2 setBackgroundColor:[UIColor whiteColor]];
    //finshButton2.hidden=YES;
    [finshView addSubview:finshButton1];
    [finshView addSubview:finshButton2];
    [finshButton1 release];
    [finshButton2 release];
    //[self a:@selector(flicker) interval:1];
    [self flicker];
    [self.view addSubview:finshView];
    [self flicker];
    if (correct>10*0.8) {
        NSLog(@"正确");
    }
    else
        NSLog(@"11题结束后错误");
}

-(void)finshButton1Pressed{
    [finshView removeFromSuperview];
    [self viewDidLoad];
}

-(void)finshButton2Pressed{
    [self.view removeFromSuperview];
}

-(void)flicker{
    CATransition *animation = [CATransition animation];
    animation.delegate = self;
    animation.duration = 1.5f;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.fillMode = kCAFillModeForwards;
    animation.endProgress = 1;
    animation.removedOnCompletion = NO;
    animation.type = @"rippleEffect";
    [self.view.layer addAnimation:animation forKey:@"animation"];
    self.lastAnimation = animation;

    [self.view exchangeSubviewAtIndex:1 withSubviewAtIndex:0];//Just remove, not release or dealloc
    isHalfAnimation = YES;
}

-(void)changeAccordingSelectQuestionSender:(int)questionSort {
    generateQuestion(selectQuestionSender, &num1, &num2, &symbol, options, &answer);
    NSString *questionText = [[NSString alloc]initWithFormat:@"%d %c %d", num1, symbol, num2];
    question.text = questionText;
    [questionText release];
}


}
-(void)changeNumAndCheckAnswer {
    NSString *itemText[3];
    int i;

    [self changeAccordingSelectQuestionSender:selectQuestionSender];

    for (i = 0; i < 4; i++) {
        itemText[i] = @"%s", options[i];
    }
    [answer1 setTitle:itemText[0] forState:NO];
    [answer2 setTitle:itemText[1] forState:NO];
    [answer3 setTitle:itemText[2] forState:NO];
    [answer4 setTitle:itemText[3] forState:NO];

    for (i = 0; i < 4; i++) {
        [itemText[i] release];
    }
}

-(void)buttonFly{
    [UIView beginAnimations:nil context:answer1];//开始动画
    [UIView beginAnimations:nil context:answer2];
    [UIView beginAnimations:nil context:answer3];
    [UIView beginAnimations:nil context:answer4];
    [UIView setAnimationDuration:0.5];
    answer1.frame = CGRectMake(393, answer1.frame.origin.y,answer1.frame.size.width, answer1.frame.size.height);//
    answer2.frame = CGRectMake(393, answer2.frame.origin.y,answer2.frame.size.width, answer2.frame.size.height);
    answer3.frame = CGRectMake(393, answer3.frame.origin.y,answer3.frame.size.width, answer3.frame.size.height);
    answer4.frame = CGRectMake(393, answer4.frame.origin.y,answer4.frame.size.width, answer4.frame.size.height);
    [UIView setAnimationDelegate:self]; 
    [UIView commitAnimations];
}

-(void)buttonMove {
    if(!buttonPressed)//如果没有点击按钮，按钮正常移动
    {
    if (answer2.frame.origin.x<392){
    answer2.frame = CGRectMake(answer2.frame.origin.x+speed,
       answer2.frame.origin.y,
       answer2.frame.size.width,
       answer2.frame.size.height);
    answer1.frame = CGRectMake(answer1.frame.origin.x+speed,
       answer1.frame.origin.y,
       answer1.frame.size.width,
       answer1.frame.size.height);
    answer3.frame = CGRectMake(answer3.frame.origin.x+speed,
       answer3.frame.origin.y,
       answer3.frame.size.width,
       answer3.frame.size.height);
    answer4.frame = CGRectMake(answer4.frame.origin.x+speed,
       answer4.frame.origin.y,
       answer4.frame.size.width,
       answer4.frame.size.height);
    }
    else
    {
    answer2.frame = CGRectMake(-72,
       answer2.frame.origin.y,
       answer2.frame.size.width,
       answer2.frame.size.height);

    answer3.frame = CGRectMake(-72, 
       answer3.frame.origin.y,
       answer3.frame.size.width,
       answer3.frame.size.height);

    answer4.frame = CGRectMake(-72, 
       answer4.frame.origin.y,
       answer4.frame.size.width,
       answer4.frame.size.height);

    answer1.frame = CGRectMake(-72, 
       answer1.frame.origin.y,
       answer1.frame.size.width,
       answer1.frame.size.height);
    [self changeNumAndCheckAnswer];//出界后就便换

    }
    }	
    else
    {
    [self buttonFly];
    [self changeNumAndCheckAnswer];
    buttonPressed=NO;
    }
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    total=0;
    correct=0;
    [self changeNumAndCheckAnswer];
    [self runGame];
    answer1.userInteractionEnabled=YES;
    answer2.userInteractionEnabled=YES;
    answer3.userInteractionEnabled=YES;
    answer4.userInteractionEnabled=YES;
    [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(timeOver) userInfo:nil 
    repeats:NO];
}



- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [finshView release];
    [gameTime fire];
    //[stopTime release];
    [question release];
    [answer1 release];
    [answer2 release];
    [answer3 release];
    [answer4 release];
    [super dealloc];
}

@end
