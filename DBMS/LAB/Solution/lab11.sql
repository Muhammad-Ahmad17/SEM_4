-- Use the superhero database
USE superhero;

-- Implicit Transaction 
SET IMPLICIT_TRANSACTIONS ON;

INSERT INTO superhero (id ,superhero_name, full_name, gender_id) 
VALUES (758 ,'Night Owl', 'Daniel Dreiberg', 1);

UPDATE superhero 
SET full_name = 'Dan Dreiberg' 
WHERE superhero_name = 'Night Owl';


ROLLBACK;
-- Commit or rollback explicitly after your operations
COMMIT; 
--
SELECT * FROM superhero 
WHERE superhero_name = 'Night Owl';
--



-- 
INSERT INTO superhero (superhero_name, full_name, gender_id) VALUES ('Night Owl', 'Daniel Dreiberg', 1);
UPDATE superhero SET full_name = 'Dan Dreiberg' WHERE superhero_name = 'Night Owl';
DELETE FROM superhero WHERE superhero_name = 'Night Owl';

SELECT * FROM superhero;


--


-- Explicit Transaction Example with Savepoints
BEGIN TRANSACTION;

    -- Insert a new superhero
    INSERT INTO superhero (id ,superhero_name, full_name, gender_id) VALUES (759 ,'Photon', 'Monica Rambeau', 2);

    -- Savepoint after insert
    SAVE TRANSACTION SaveAfterInsert;

    -- Update superhero's full name
    UPDATE superhero SET full_name = 'M. Rambeau' WHERE superhero_name = 'Photon';

    -- Savepoint after update
    SAVE TRANSACTION SaveAfterUpdate;

    -- Rollback the last update
    ROLLBACK TRANSACTION SaveAfterUpdate;

    -- Delete the superhero
    DELETE FROM superhero WHERE superhero_name = 'Photon';

    -- Savepoint after delete
    SAVE TRANSACTION SaveAfterDelete;

    -- Rollback to the insert (undo delete)
    ROLLBACK TRANSACTION SaveAfterInsert;

COMMIT; -- Commit the transaction
SELECT * FROM superhero WHERE superhero_name = 'Photon';



-- Check the current state of the table
SELECT * FROM superhero;