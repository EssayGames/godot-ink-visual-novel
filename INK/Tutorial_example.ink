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
*[M: I should go...]->gotta_go

===gotta_go===
~f_happy = true
~f_neutral = false
F: Cool, see you around!->END
