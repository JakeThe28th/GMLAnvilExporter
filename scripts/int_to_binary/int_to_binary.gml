function int_to_binary(argument0, argument1) {
	//--- init args
	  var Dec = round(argument0);
	  var Digits = argument1; // bit Str length

	//--- Divide by 2. Add 0's and 1's depending on the remainder, modulo: %
	  var Rem;
	  var BitStack = ds_stack_create();
  
	  while Dec > 0
	  {
	    Rem = Dec % 2;
	    ds_stack_push(BitStack,Rem);
	    Dec /= 2;
	    Dec = floor(Dec);
	  }

	//--- Convert the stack into a single Str
	  var BitStr = "";
	  for(var i=ds_stack_size(BitStack);i>0;i--)
	    BitStr += string(ds_stack_pop(BitStack));

	//--- append x amount of 0's to the left to make binary String correct amount of digits
	  var StrLength = string_length(BitStr);
	  while StrLength < Digits
	  {
	    BitStr = string_insert("0",BitStr,0);
	    StrLength++;
	  }

	//--- Clean up to avoid memory leak! Do it!
	  //show_debug_message("Binary Conversion: "+string(BitStr));
	  ds_stack_destroy(BitStack);
	  return(string(BitStr));
  
	//https://www.reddit.com/r/gamemaker/comments/46cjvv/created_two_scripts_binary_conversion_and_integer/


}
