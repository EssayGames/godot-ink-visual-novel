VAR m_neutral = true
VAR f_neutral = true
VAR m_happy = false
VAR f_happy = false
VAR m_anger = false
VAR f_nervous = false

M: Hey F, how was your first day of class?
*[Great!]->OK
*[Not Great...]->Not_Great

===OK===
~f_happy = true
~f_neutral = false
F: The teacher was really friendly.
*[con't]->return_q

===Not_Great===
~f_nervous = true
~f_neutral = false
F: I slept through my alarm and was over an hour late...
*[con't]->return_q

===return_q===
~f_happy = false
~f_nervous = false
~f_neutral = true
F: What about you M?
*[Excellent!]->excellent
*[Well..]->canceled

===excellent===
~m_happy = true
~m_neutral = false
M: I got signed into an elective I really wanted!
*[con't]->but_end

===canceled===
~m_anger = true
~m_neutral = false
M: ... a class I needed to graduate got canceled suddenly
*[con't]->but_end

===but_end===
~m_anger = false
~m_neutral = true
~m_happy = false
M: So an eventful day. 
*[M: I hear you...]->hear_you

===hear_you===
M: I hope this semester is...
*[...better than last.]->better
*[...is just as fun as the Fall!]->fun_fall

===better===
M: I fell behind early in homework and I can't let that happen again.
*[F: Why not?]->why_not
*[F: You won't]->you_wont

===why_not===
M: Because my scholarship depends on keeping my grades up.
*[F: You'll be fine]->gotta_go

===you_wont===
M: Thanks F. That made my day.
*[F: Anytime!]->gotta_go

===fun_fall===
F: Well, as fun as it was, don't let it distract you!
*[M: Distract me?!]->distract
*[M: I won't]->I_wont

===distract===
M: It's not distracting to have fun, it's part of being in school!
*[F: Ok... whatever you say...]->gotta_go

===I_wont===
M: I'm going to keep my head down and really focus this semester.
*[F: You've got this, M!]->gotta_go

===gotta_go===
~f_happy = true
~f_neutral = false
F: For now, though, I gotta get to my next class!`M: Cool, see you around!->END



