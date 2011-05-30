//
//  generateQuestion.h
//  Bling Home
//
//  Created by He Anda on 11-5-30.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//


void swap(int *pa, int *pb);
int getRandomFromZero(int range);
int getRandomFromOne(int range);
int getRandom(int begin, int end);
int getBinaryRandom();
void generateQuestion(int kind, int *pNum1, int *pNum2, char *pSymbol, int options[]);
void getTwoRandomFromOne(int *pa, int *pb, int range);
void getTwoUniqueRandomFromOne(int *pa, int *pb, int range);
void getWrongAnswers(int kind, int answer, int wrongAnswer[]);
int getAnswerRange(int kind);
void getOptions(int answer, const int wrongAnswer[], int options[]);
int getGeneratorRange(int kind);
void getThreeUniqueOtherThanNum(int begin, int end, int result[], int num);
void getWrongNum(int num1, int wrongAnswer[]);