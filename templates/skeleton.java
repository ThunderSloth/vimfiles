/* ... description ...
 * Eli Bell
 * [:VIM_EVAL:]strftime('%F')[:END_EVAL:]
 */

import java.util.Scanner;

class [:VIM_EVAL:]substitute(expand('%:t'), '\.java$', '', '')[:END_EVAL:]{
   public static void main(String[] args){
       Scanner input = new Scanner(System.in);
       System.out.println("\nWelcome to my program!\n");
       
       // ...

       System.out.println("\n\nThanks for using my program!");
   }
}
