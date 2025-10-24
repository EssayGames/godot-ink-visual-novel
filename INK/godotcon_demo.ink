VAR Speaker = ""
VAR had_lunch = false

There once was a conference. 
*[con't]
-It was called GodotCon.

*[I went to this awesome workshop.]->workshop
*[I had an awesome lunch.]->lunch

===workshop===
At the workshop I...
*[Met Nicholas]-> Nicholas
*[Met Rawb]-> Rawb

===Nicholas===
~Speaker = "Nicholas"
Me: Oh hello, Nicholas.
Nicholas: Nice to meet you! Did you like the workshop?
*[Yes.]->simple_yes
*[Heck yes!] ->heck_yes

===Rawb===
~Speaker = "Rawb"
Me: Oh hello, Rawb!
Rawb: Hi there, thanks for coming to the workshop. Did you learn something?
*[Yes.]->simple_yes
*[Heck yes!]->heck_yes

===lunch===
~had_lunch = true
At lunch, I called my friend...
*[Nancy]->Nancy
*[Billy]->Billy

===Nancy===
~Speaker = "Nancy"
Me: Hey, Nancy. How's it going?
Nancy: Great! How's GodotCon? Are you having a good time?
*[Yes.]->simple_yes
*[Heck yes.]->heck_yes

===Billy===
~Speaker = "Billy"
Me: Hey, Billy. Sup bruh?
Nancy: Sup! How's GodotCon? Is it chill?
*[Yes.]->simple_yes
*[Heck yes.] ->heck_yes

===simple_yes===
Me: Yup.
{Speaker}: Cool, see ya later. ->END

===heck_yes===
Me: Heck yes!
{Speaker}: Heck yes! ->END

