CREATE OR REPLACE FUNCTION validate_tuition()
RETURNS trigger AS
$BODY$
BEGIN
    if NEW.amount < 1 then
      RAISE NOTICE 'Valor incompatível para mensalidade';
    end if;        
    RETURN NEW;
END;
$BODY$

LANGUAGE plpgsql VOLATILE
COST 100;

create trigger tr_validate_tuition after insert on tuitions
for each row execute procedure validate_tuition();

