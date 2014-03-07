                        SuperEasyJSON
            http://www.sourceforge.net/p/supereasyjson
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

PURPOSE:
========

Why write another C++ JSON library? I was getting frustrated
with the other offerings for a variety of reasons. 

1. I didn't want to install Boost or any other library 
2. I didn't want to install any programs/scripts that I didn't already have just to
    create the library (I'm looking at you flex and bison and python)
3. I didn't want to have to run 'make'
4. I just wanted a header and cpp file that I could drop into
    any project and it would work. 
5. I wanted an interface that was easy to use

This library is easy to use, requires no installation (other than adding
it into your project), and doesn't depend on anything else.

It is NOT the library for you if you demand extreme speed or amazing
memory performance. There are already other libraries out there if that's
what you need. For my purposes, I'm neither creating gigantic JSON objects
nor am I making lots of them nor am I making them in some super critical
time-dependent block of code that any of this would have any effect
whatsoever. As an iOS game programmer, I don't think I'd ever be in this
position. 

Could it have been written more efficiently? Of course. But for my
needs, the performance cost of the code as-is is negligible, and the
trade-off was I was able to write and test it very quickly. If
I needed a high performance implementation I'd have used an existing
library or written things completely differently.

So if you want a brain-dead simple library to get started with, and
you can live with the performance trade-offs, then give it a shot.

Any bugs, please email me at my gmail account: jeff.weinstein.
Please use the subject-line "EasyJSON" followed by whatever else. 
Preferably not profanity.

INSTALLATION:
============
Drop json.h and json.cpp into your project. Seriously, that's it.

USAGE:
======
Just include "json.h" and you're ready to go. See the examples below
for more help. 

You need to make a json::Object variable, and then fill it with
whatever you like. Populate it like you would a std::map. For
example: my_obj_instance["some key"] = <some value>

Where <some value> is an int/flot/bool/string/array/object.

What about arrays? Make a json::Array instance, and fill
it with whatever values you like using its .push_back method.
It acts like a std::vector. You can fill it with a mix of types.

You can access any element in a json::Array with the familiar [] notation.
The same applies for a json::Object, supplying the string key to get
the value. 

Everything is stored as a json::Value, which has a lot of convenience
operator methods to cast it (or construct it) to (or from) any of the
valid types.

For the NULL type, simply use an empty json::Value instance.

You can use the new C++11 style for loop with Array and Object like so:

for (auto& kv : my_object)...



EXAMPLE:
========

A less complicated example:
	#include "json.h"
	
	json::Object obj;
	obj["int"] = 1;
	obj["float"] = 1.1f;
	obj["bool"] = true;
	obj["string"] = "hi";
	
	std::string str = json::Serialize(obj);
	
The value of "str" winds up being this: 
{"bool":true,"float":1.100000,"int":1,"string":"hi"}

Which looks a lot nicer when it's run through a formatter:
{
   "bool":true,
   "float":1.100000,
   "int":1,
   "string":"hi"
}

Now for a complicated example with lots of nesting:
	#include "json.h"
	
	json::Object sub_obj;
	sub_obj["string"] = "sub_obj's string";

	json::Array sub_array;
	sub_array.push_back("sub_array string 1");
	sub_array.push_back("sub_array string 2");
	sub_array.push_back(1.234f);

	json::Array a;
	a.push_back(10);
	a.push_back(10.0f);
	a.push_back(false);
	a.push_back("array a's string");
	a.push_back(sub_obj);
	a.push_back(sub_array);

	json::Object sub_obj3;
	sub_obj3["sub_obj3 string"] = "whoah, I'm sub_obj3's string";
	sub_obj3["sub_obj3 int"] = 31337;

	json::Object sub_obj2;
	sub_obj2["int"] = 1000;
	sub_obj2["bool"] = false;
	sub_obj2["x"] = sub_array;
	sub_obj2["z"] = sub_obj3;

	json::Object obj;
	obj["int"] = 1;
	obj["float"] = 1.1f;
	obj["bool"] = true;
	obj["string"] = "come here often?";
	obj["array"] = a;
	obj["sub_obj2"] = sub_obj2;
	obj["null value"] = json::Value();

	std::string str = json::Serialize(obj);

The value of "str" winds up being this (returns added for wrapping purposes)

{"array":[10,10.000000,false,"array a's string",{"string":"sub_obj's string"},[
"sub_array string 1","sub_array string 2",1.234000]],"bool":true,
"float":1.100000,"int":1,"null value":null,"string":"come here often?",
"sub_obj2":{"bool":false,"int":1000,
"x":["sub_array string 1","sub_array string 2",1.234000],
"z":{"sub_obj3 int":31337,"sub_obj3 string":"whoah, I'm sub_obj3's string"}}}

Which looks a whole lot easier to understand formatted thusly:
{
   "array":[
      10,
      10.000000,
      false,
      "array a's string",
      {
         "string":"sub_obj's string"
      },
      [
         "sub_array string 1",
         "sub_array string 2",
         1.234000
      ]
   ],
   "bool":true,
   "float":1.100000,
   "int":1,
   "null value":null,
   "string":"come here often?",
   "sub_obj2":{
      "bool":false,
      "int":1000,
      "x":[
         "sub_array string 1",
         "sub_array string 2",
         1.234000
      ],
      "z":{
         "sub_obj3 int":31337,
         "sub_obj3 string":"whoah, I'm sub_obj3's string"
      }
   }
}

CHANGELOG:
==========
2/8/2014:
--------- 
MAJOR BUG FIXES, all courtesy of Per Rovegård, Ph.D.
* Feature request: HasKey and HasKeys added to Value for convenience and
	to avoid having to make a temporary object.
* Strings should now be properly unescaped. Previously, as an example, the
	string "\/Date(1390431949211+0100)\/\" would be parsed as
	\/Date(1390431949211+0100)\/. The string is now properly parsed as
	/Date(1390431949211+0100)/.
	As per http://www.json.org the other escape characters including
	\u+4 hex digits will now be properly unescaped. So for example,
	\u0061 now becomes "A".
* Serialize now supports serializing a toplevel array (which is valid JSON).
	The parameter it takes is now a Value, but existing code doesn't
	need to be changed.
* Fixed bug with checking for proper opening/closing sequence for braces/brackets.
	Previously, this code: 
		const char *json = "{\"arr\":[{}}]}";
		auto val = json::Deserialize(json);
	worked fine with no errors. That's a bug. I did a major overhaul so that
	now improperly formatted pairs will now correctly result in an error.
* Made internal deserialize methods static

1/30/2014:
----------
* Changed #pragma once to the standard #ifndef header guard style for
	better compatibility.
* Added a [] operator for Value that takes a const char* as an argument
	to avoid having to explicitly (and annoyingly) cast to std::string.
	Thus, my_value["asdf"] = "a string" should now work fine.
	The same has been added to the Object class.
* Added non-operator methods of casting a Value to int/string/bool/etc.
	Implicitly casting a Value to a std::string doesn't work as per C++
	rules. As such, previously to assign a Value to a std::string you
	had to do:
		my_std_string = (std::string)my_value;
	You can now instead do:
		my_std_string = my_value.ToString();
	If you want more information on why this can't be done, please read
	this topic for more details:
	http://stackoverflow.com/questions/3518145/c-overloading-conversion-operator-for-custom-type-to-stdstring
		
1/27/2014
----------
* Deserialize will now return a NULLType Value instance if there was an
	error instead of asserting. This way you can handle however you want to
	invalid JSON being passed in. As a top level object must be either an
	array or an object, a NULL value return indicates an invalid result.
		
1/11/2014
---------
* Major bug fix: Strings containing []{} characters could cause
	parsing errors under certain conditions. I've just tested
	the class parsing a 300KB JSON file with all manner of bizarre
	characters and permutations and it worked, so hopefully this should
	be the end of "major bug" fixes.
		
1/10/2014
---------
Bug fixes courtesy of Gerry Beauregard:
* Pretty big bug: was using wrong string paramter in ::Deserialize
	and furthermore it wasn't being trimmed. 
* Object::HasKeys now casts the return value to avoid compiler warnings.
* Slight optimization to the Trim function
* Made asserts in ::Deserialize easier to read
 	
1/9/2014
--------
* Major bug fix: for JSON strings containing \" (as in, two characters,
	not the escaped " character), the lib would mess up and not parse
	correctly.
* Major bug fix: I erroneously was assuming that all root JSON types
	had to be an object. This was an oversight, as a root JSON
	object can be an array. I have therefore changed the Deserialize
	method to return a json::Value rather than a json::Object. This
	will NOT impact any existing code you have, as a json::Value will
	cast to a json::Object (if it is indeed an object). But for 
	correctness, you should be using json::Value = Deserialize...
	The Value type can be checked if it's an array (or any other type),
	and furthermore can even be accessed with the [] operator for
	convenience.
* I've made the NULL value type set numeric fields to 0 and bool to false.
	This is for convenience for using the NULL type as a default return
	value in your code.
* asserts added to casting (Gerry Beauregard)
* Added method HasKeys to json::Object which will check if all the keys
	specified are in the object, returning the index of the first key
	not found or -1 if all found (hoppe).

1/4/2014
--------
* Fixed bug where booleans were being parsed as doubles (Gerry Beauregard).

1/2/2014 v3
------------
* More missing headers added for VisualStudio 2012
* Switched to snprintf instead of sprintf (or sprintf_s in MSVC)

1/2/2014 v2
-----------
* Added yet more missing headers for compiling on GNU and Linux systems
* Made Deserialize copy the passed in string so it won't mangle it

1/2/2014
--------
* Fixed previous changelog years. Got ahead of myself and marked them
	as 2014 when they were in fact done in 2013.
* Added const version of [] to Array/Object/Value
* Removed C++11 requirements, should work with older compilers
	(thanks to Meng Wang for pointing that out)
* Made ValueMap and ValueVector typedefs in Object/Value public
	so you can actually iterate over the class
* Added HasKey and HasValue to Object/Array for convenience
	(note this could have been done comparing .find to .end)

12/29/2013 v2
-------------
* Added .size() field to Value. Returns 1 for non Array/Object types,
	otherwise the number of elements contained.
* Added .find() to Object to search for a key. Returns Object::end()
	if not found, otherwise the Value.
	Example: bool found = my_obj.find("some key") != my_obj.end();
* Added .find() to Array to search for a value. Just a convenience
	wrapper for std::find(Array::begin(), Array::end(), Value)
* Added ==, !=, <, >, <=, >= operators to Object/Array/Value.
	For Objects/Arrays, the operators function just like they do for a
	std::map and std::vector, respectively.
* Added IsNumeric to Value to indicate if it's an int/float/double type.

12/29/2013
----------
* Added the DoubleVal type which stores, you guessed it, double values.
* Bug fix for floats with an exact integer value. Now, setting any numerical
	field will also set the fields for the other numerical types. So if you
	have obj["value"] = 12, then the int/float/double cast methods will
	return 12/12.0f/12.0. Previously, in the example above, only the int
	value was set, making a cast to float return 0.
* Bug fix for deserializing JSON strings that contained large integer values.
	Now if the numerical value of a key in a JSON string contains a number
	less than INT_MIN or greater than INT_MAX it will be stored as a double.
	Note that as mentioned above, all numerical fields are set.
* Should work fine with scientific notation values now.

12/28/2013
----------

* Fixed a bug where if there were spaces around values or key names in a JSON
string passed in to Deserialize, invalid results or asserts would occur.
(Fix courtesy of Gerry Beauregard)

* Added method named "Clear()" to Object/Array/Value to reset state

* Added license to header file for easyness (totally valid word).