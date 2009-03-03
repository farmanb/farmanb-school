#include <list>
#include <string>

/* Test function.  Uses a turing machine to
 check to see if the string is a member of the 
 language. */
bool memberLanguage(std::string input);

/* PDA */
void pda(std::list<char> *stack, std::string input);
/* Delta function for the PDA.  Theoretically, accepts 
   the state, input char and uses the stack to 
   see what the char on the top of the stack is.  This
   PDA only has one state, however. */
bool delta(std::list<char> *stack, char input);
/* Pushes a character onto the stack. */
void push(std::list<char> *stack, char c);
/* Pops a char off the stack */
void pop(std::list<char> *stack);
/* Reads the top char on the stack */
char read(std::list<char> *stack);
/* "Consumes" a character from the input */
void consume(int *inputPointer);

int main(int argc, char **argv){
  std::list<char> *stack = new std::list<char>;
  std::string input[4];

  if (argc < 2){
    printf("Usage:\n%s [input string]\n", argv[0]);
    return 1;
  }
  
  /* Push the empty stack symbol onto the stack. */
  stack->push_back('$');

  if (argv[1])
    printf("memberLanguage: String is a member of the language\n");
  else
    printf("memberLanguage: String is not a member of the language\n");

  /* Pass the input string to the PDA.  */
  pda(stack, input[3]);
  
  return 0;
}

void consume(int *inputPointer){
  (*inputPointer)++;
}

bool memberLanguage(std::string input){
  int aCount, bCount;
  
  aCount = bCount = 0;
  
  for (int i = 0; i < input.length(); i++){
    if (input[i] == 'a')
      aCount++;
    else if (input[i] == 'b')
      bCount++;
    else
      printf("Error: memberLanguage: Unrecognized character!\n");

  }

  printf("Number of a's: %d\nNumber of b's: %d\n",
	 aCount, bCount);
  
  if (aCount == bCount)
    return true;
  else
    return false;
}


void pda(std::list<char> *stack, std::string input){
  int *ip = new int;
  *ip = 0;
  
  while (*ip < input.size()){
    if (!delta(stack, input[*ip])){
      printf("The string is not a member of the language!\n");
      return;
    }
    consume(ip);
  }
  
  /* If the PDA reaches this point and the stack is empty, then
   the string must be a member of the language, otherwise it is
   not a member of the language. */
  if (*(stack->begin()) == '$')
    printf("The string is a member of the language.\n");
  else
    printf("The string is not a member of the language!\n");
}

bool delta(std::list<char> *stack, const char input){
  switch(input){
  case 'a':
    switch(read(stack)){
    case '$':
      push(stack, '$');
      push(stack, input);
      return true;
      break;
    case 'a':
      push(stack, input);
      push(stack, input);
      return true;
      break;
    default:
      return true;
      break;
    }
    break;
  case 'b':
    switch(read(stack)){
    case '$':
      push(stack, '$');
      push(stack, input);
      return true;
      break;
    case 'b':
      push(stack, input);
      push(stack, input);
      return true;
      break;
    default:
      return true;
      break;
    }
  }   
  return false;
}

void push(std::list<char> *stack, char c){
  switch(c){
  case ' ': /* Push "lambda" onto the stack*/
    break;
  default:
    stack->push_front(c);
  }
}

void pop(std::list<char> *stack){
  stack->pop_front();
}

char read(std::list<char> *stack){
  char retVal = *(stack->begin());
  pop(stack);
  return retVal;
}
