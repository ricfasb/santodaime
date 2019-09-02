CREATE OR REPLACE FUNCTION add_profile_to_user()
RETURNS trigger AS
$BODY$
BEGIN
    
    UPDATE users SET profile_id = 1 WHERE id = NEW.id; 
        
    RETURN NEW;
END;
$BODY$

LANGUAGE plpgsql VOLATILE
COST 100;

create trigger tr_add_profile_to_user after insert on users
for each row execute procedure add_profile_to_user();