/*
* This class calculates divisibility test for given input
*/
public class Divisible {

    public String calculateDivisible(Integer inputNum) {
    
        //Verify and return the input if it is not in between 0 and 15
        if(inputNum < 0 || inputNum > 15){
            return 'Invalid input';
        }        
                         
        if(Math.Mod(inputNum,3) == 0 && Math.Mod(inputNum,5) == 0) {           
            return 'FizzBuzz';
        }
        else if(Math.Mod(inputNum,5) == 0) {
            return 'Buzz';
        }
        else if(Math.Mod(inputNum,3) == 0) {
            return 'Fizz';
        }
        else {
            return String.valueOf(inputNum);
        }               
    }

}