//
//  secondViewController.m
//  Bling Home
//
//  Created by He Anda
//  Copyright 2011 TJU. All rights reserved.
//

#import "secondViewController.h"
#import "nstimer.h"
#import "generateQuestion.h"

@implementation secondViewController

@synthesize num1, num2, answer, symbol, question, total, correct;
@synthesize option0, option1, option2, option3;
@synthesize buttonPressed,runNotRepeat,gameTime;//moveVelocity;
@synthesize answer1,answer2,answer3,answer4;
@synthesize lastAnimation;
@synthesize finshView;
#define speed 2.5

- (id)initWithNibName:(NSString*)nibName bundle:(NSBundle*)nibBundle onPage:(int)button_id
{
    self = [super initWithNibName:nibName bundle:nibBundle];
    if(self == nil)
    {
        return nil;
    }
    selectQuestionSender = button_id;

NSLog(@"entering second view");
    return self;
}

- (void)play
{
    if (total++ <= 10) {
        [self revealButtonsInLeft];
        [self revealQuestionAndAnswer];
        if (total) {
            [mytimer resume];
        }
        else {
            mytimer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(buttonMove) userInfo:nil repeats:YES];
            NSLog(@"selector set");
        }
    }
    else {
        [self gameover];
    }
}

-(IBAction)answer1Pressed:(UIButton*)answerButton1{
    [mytimer pause];
    NSString *ans = [[NSString alloc]initWithFormat:@"%d",answer];
    if([answerButton1.titleLabel.text isEqualToString: ans] ) {
        NSLog(@"correct");
        correct++;
    }
    [ans release];
    NSLog(@"you made an answer, total: %d; correct: %d", total, correct);
    [self play];
}

- (void)timeout
{
    NSLog(@"time out!");
    [mytimer pause];
    [self play];
}

-(void)gameover
{
    NSLog(@"game over");

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
    if (correct > 7) {
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

-(void)revealQuestionAndAnswer {    
    int options_c[4];

    NSLog(@"in method revealQuestionAndAnswer");	
    generateQuestion(selectQuestionSender, &num1, &num2, &symbol, options_c, &answer);
    option0 = options_c[0];
    option1 = options_c[1];
    option2 = options_c[2];
    option3 = options_c[3];
    
    NSString *ans1 = [[NSString alloc]initWithFormat:@"%d",option0];
    NSString *ans2 = [[NSString alloc]initWithFormat:@"%d",option1];
    NSString *ans3 = [[NSString alloc]initWithFormat:@"%d",option2];
    NSString *ans4 = [[NSString alloc]initWithFormat:@"%d",option3];

    [answer1 setTitle:ans1 forState:NO];
    [answer2 setTitle:ans2 forState:NO];
    [answer3 setTitle:ans3 forState:NO];
    [answer4 setTitle:ans4 forState:NO];

    [ans1 release];
    [ans2 release];
    [ans3 release];
    [ans4 release];

    NSString *questionText = [[NSString alloc]initWithFormat:@"%d %c %d", num1, symbol, num2];
    question.text = questionText;
    [questionText release];
}

-(void)buttonMove {
    NSLog(@"in method button__move");
    if (answer2.frame.origin.x<392) {
        answer2.frame = CGRectMake(answer2.frame.origin.x+speed, answer2.frame.origin.y, answer2.frame.size.width, answer2.frame.size.height);
        answer1.frame = CGRectMake(answer1.frame.origin.x+speed, answer1.frame.origin.y, answer1.frame.size.width, answer1.frame.size.height);
        answer3.frame = CGRectMake(answer3.frame.origin.x+speed, answer3.frame.origin.y, answer3.frame.size.width, answer3.frame.size.height);
        answer4.frame = CGRectMake(answer4.frame.origin.x+speed, answer4.frame.origin.y, answer4.frame.size.width, answer4.frame.size.height);
    }
    else {
        [self timeout];
    }
}

-(void) revealButtonsInLeft
{
    answer1.frame = CGRectMake(-72, answer1.frame.origin.y, answer1.frame.size.width, answer1.frame.size.height);			
    answer2.frame = CGRectMake(-72, answer2.frame.origin.y, answer2.frame.size.width, answer2.frame.size.height);
    answer3.frame = CGRectMake(-72, answer3.frame.origin.y, answer3.frame.size.width, answer3.frame.size.height);
    answer4.frame = CGRectMake(-72, answer4.frame.origin.y, answer4.frame.size.width, answer4.frame.size.height);
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    NSLog(@"view did load");
    total = 0;
    correct = 0;
    buttonPressed = NO;
    [self revealQuestionAndAnswer];
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
