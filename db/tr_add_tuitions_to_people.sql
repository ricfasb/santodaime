CREATE OR REPLACE FUNCTION add_tuitions_to_people()
RETURNS text AS $$
DECLARE
  category int; 
  tuition int; 
  insert_tuition boolean;
  actual_month int;
  actual_year int;
  actual_day int;
  due_day int;
  due_month int;
  due_date date;
  person  RECORD;
  cur_people CURSOR 
       FOR SELECT id, category_id
       FROM people where id <> 1;
BEGIN

    OPEN cur_people;
    
    LOOP 
        FETCH cur_people INTO person;
        category = person.category_id;

        select c.tuition_id, c.insert_tuition into tuition, insert_tuition from categories c 
        where c.id = category;

        due_day = 5;
        actual_year = 2019;
        IF insert_tuition THEN
            FOR i in 7..12 LOOP  
                due_month = i;
                if due_month < 10 then
                    select to_date( actual_year::text||'0'||due_month::text||'05','YYYYMMDD')::timestamp into due_date;	
                else
                    select to_date( actual_year::text||due_month::text||'05','YYYYMMDD')::timestamp into due_date;	
                end if;
                INSERT INTO tuition_people (created_at, updated_at,
                person_id, tuition_id, due_date, status_payment)
                values (current_date, current_date, person.id, tuition, due_date, 'pending');
            END LOOP;
        END IF;

        EXIT WHEN NOT FOUND;
    END LOOP;

    CLOSE cur_people;
        
    RETURN 'NEW';
END; $$

LANGUAGE plpgsql VOLATILE
COST 100;