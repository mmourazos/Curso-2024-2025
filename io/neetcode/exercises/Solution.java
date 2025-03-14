package io.neetcode.exercises;

public class Solution {
  public static void main(String[] args) {
    System.out.println("Hello, World.");
    System.out.println("Hello, Java.");
  }

  public boolean isValid(String s) {
    Stack<Character> roundBrackets = new Stack<>();
    Stack<Character> squareBrackets = new Stack<>();
    Stack<Character> curlyBrackets = new Stack<>();

    for (char c in s.toCharArray()) {
      try {

        switch (c) {
          case '(':
            roundBracets.push(c);
            break;
          case ')':
            roundBracets.pop();
            break;
          case '[':
            squareBrackets.push(c);
            break;
          case ']':
            squareBrackets.pop();
            break;
          case '{':
            curlyBrackets.push(c);
            break;
          case '}':
            curlyBrackets.pop();
            break;
        }
      } catch (EmptyStackException e) {
        return false;
    }

    if (roundBrackets != 0 || squareBrackets != 0 || curlyBrackets != 0) {
      return false;
    }

    return true;
  }
}
