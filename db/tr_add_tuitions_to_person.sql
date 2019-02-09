CREATE OR REPLACE FUNCTION add_tuitions_to_person()
RETURNS trigger AS
$BODY$
DECLARE
  category int; 
  tuition int; 
  insert_tuition boolean;
  actual_month int;
  actual_year int;
  actual_day int;
  due_day int;
  due_day_str varchar;
  due_date date;
BEGIN
    --pega a categoria
    category := NEW.category_id;
    --perga a mensalidade e se insere mensalidade para a categoria desta pessoa
    select c.tuition_id, c.insert_tuition into tuition, insert_tuition from categories c 
     where c.id = category;

    select t.day into due_day from tuitions t where id = tuition;

    --pega o mes atual
    SELECT EXTRACT(month FROM CURRENT_DATE) into actual_month;
    SELECT EXTRACT(year FROM CURRENT_DATE) into actual_year;
    SELECT EXTRACT(day FROM CURRENT_DATE) into actual_day;
    
    --caso a categoria gera mensalidade faz o loop inserindo
    IF insert_tuition THEN
      --realiza um loop do mes atual ate o mes final
      FOR i in actual_month..12 LOOP   
	  --verifica se o dia de vencimento da mensalidade 
	  --eh maior que o dia atual do mes atual 
	  --caso seja maior nao inclui a mensalidade
	  --ver com Lourenco
	  if due_day < actual_day and i = actual_month then
	    CONTINUE;
	  end if;
	  -- normaliza zero a esquerda para criar a data de vencimento
	  if length( i::text ) = 1 then
            due_day_str := '0'||i::text;
	  else
	   due_day_str := i::text;
	  end if;

	  select to_date( actual_year::text||due_day_str||due_day::text,'YYYYMMDD')::timestamp into due_date;	  
          --insere as mensalidades para a perssoa
          INSERT INTO tuition_people (created_at, updated_at,
          person_id, tuition_id, due_date, status_payment)
          values (current_date, current_date, NEW.id, tuition, due_date, 'pending');
      END LOOP;
    END IF;
        
    RETURN NEW;
END;
$BODY$

LANGUAGE plpgsql VOLATILE
COST 100;

create trigger tr_add_tuitions_to_person after insert on people
for each row execute procedure add_tuitions_to_person();