VAR m_neutral = true
VAR f_neutral = true
VAR m_happy = false
VAR f_happy = false
VAR m_anger = false
VAR f_nervous = false
VAR f_name = "Jenny"
VAR m_name = "Jimmy"
VAR quest_1 = false
VAR status_update = 0

Hey {f_name}, how was your first day of class? #jimmy
*[Great!]->OK 
*[Not Great...]->Not_Great

===OK===
~f_happy = true
~f_neutral = false
The teacher was really friendly. #jenny
*[con't]->homework

===homework===
~quest_1 = true
~f_happy = false
~f_nervous = true
{OK:But the teacher gave us a bunch of reading on the first day!}{Not_Great: And on top of that, I got extra reading for being late!} #jenny
*[con't]->return_q

===Not_Great===
~f_nervous = true
~f_neutral = false
I slept through my alarm and was over an hour late... #jenny
*[con't]->homework

===return_q===
~f_happy = false
~f_nervous = false
~f_neutral = true
What about you, {m_name}? #jenny
*[Excellent!]->excellent
*[Well..]->canceled

===excellent===
~m_happy = true
~m_neutral = false
I got signed into an elective I really wanted! #jimmy
*[con't]->counselor

===canceled===
~m_anger = true
~m_neutral = false
... a class I needed to graduate got canceled suddenly. #jimmy
*[con't]->counselor

===counselor===
~m_anger = false
~m_happy = false
~m_neutral = true
{excellent:I just need to get my academic advisor to sign off!}{canceled:I gotta go ask my acadmic advisor if I'm going to graduate on time.}#jimmy
*[con't]->but_end

===but_end===
So it's going to be an eventful day. #jimmy
*[Can I help?]->help_jimmy
*[Sounds like it!] ->hear_you

===help_jimmy===
~m_happy = true
~m_neutral = false
~status_update += 1
Is there anything I can do to help? #jenny
*[con't] ->hear_you

===hear_you===
~m_happy = false
~m_neutral = true
{help_jimmy: No, I think I got it. }I just hope this semester is... #jimmy
*[... better than last.]->better
*[... as fun as the Fall!]->fun_fall

===better===
~m_anger = true
~m_neutral = false
I fell behind early in homework and I can't let that happen again. #jimmy
*[Why not?]->why_not
*[You won't!]->you_wont

===why_not===
~m_anger = false
~m_neutral = true
Because my scholarship depends on keeping my grades up. #jimmy
*[You'll be fine.]->gotta_go

===you_wont===
~m_anger = false
~m_happy = true
~status_update += 1
Thanks, {f_name}. That made my day. #jimmy
*[Anytime!]->gotta_go

===fun_fall===
~f_happy = true
~f_neutral = false
Well, don't let "having fun" distract you! #jenny
*[con't]->I_wont

===I_wont===
~f_neutral = true
~f_happy = false
~m_neutral = true
Don't worry, I won't. I'm going to keep my head down and really focus this semester. #jimmy
*[You've got this!]->gotta_go

===gotta_go===
~f_happy = true
~f_neutral = false
~m_anger = false
~m_neutral = true
~m_happy = false
For now, though, I gotta get to my next class!#jenny
*[See ya!]->END



