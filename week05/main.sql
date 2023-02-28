-- 1)
select title from course where dept_name='Comp. Sci.' and credits=3

-- 2)
select cr.course_id, cr.title
from takes as tk, student as st, course as cr
where tk.id=st.id and st.id='12345' and tk.course_id=cr.course_id

-- 3)
select SUM(cr.credits)
from takes as tk, student as st, course as cr
where tk.id=st.id and st.id='12345' and tk.course_id=cr.course_id

-- select SUM(credits) 
-- from course as Cr, student as St
-- where Cr.dept_name=St.dept_name and St.id='12345'

-- 4)
select st.id, SUM(cr.credits)
from takes as tk, student as st, course as cr
where tk.id=st.id and tk.course_id=cr.course_id
GROUP BY st.id;

-- SELECT St.id, SUM(Cr.credits)
-- FROM student AS St, course AS Cr
-- WHERE Cr.dept_name = St.dept_name 
-- GROUP BY St.id;

-- 5)
select distinct name
from student as st, takes as tk
where tk.course_id like 'CS%' and tk.id=st.id

-- 6)
select ins.id
from instructor as ins left join teaches as tch on ins.id=tch.id
where tch.id is null

-- 7)
select ins.id, ins.name
from instructor as ins left join teaches as tch on ins.id=tch.id
where tch.id is null

