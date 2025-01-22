/*### 5. Advanced exercise
Here is a draft database schema for an online role-playing game. It currently lacks primary keys and other constraints.

players(name, level, money)
items(id, itemname, value)
equippable(id, equipslot)
player_inventory(player, item)
equipped(player, item, equipslot)
*/

/*ON DELETE 
(1)CASCADE the whole row deleted
(2)SET NULL the coloumn sets to null
(3)RESTRICT prevents deleting action at the moment
(4)NO ACTION prevents deleting action at the end of the transaction
(5)SET DEFAULT the coloumn is set to the default value
*/

CREATE TABLE players (
    name VARCHAR(50) NOT NULL PRIMARY KEY,
    level INT NOT NULL CHECK (level >= 0),
    money DECIMAL(10, 2) NOT NULL CHECK (money >= 0)
);

/* items** describes all the items players can find in the game.
Each item has an ID number, a name (multiple items can have the same name) and a monetary value. */
CREATE TABLE items (
    id INT NOT NULL PRIMARY KEY,
    itemname VARCHAR(100) NOT NULL,
    value DECIMAL(10, 2) NOT NULL CHECK (value >= 0)
);

/* equippable** describes another subset of items that can be carried by players.
Each such item has an _equipslot_ (eg “ring”, “weapon”, “helmet” or similar) that indicates where players can put the item on.*/

CREATE TABLE equippable (
    id INT PRIMARY KEY,
    equipslot VARCHAR(50) NOT NULL,
    FOREIGN KEY (id) REFERENCES items (id), -- Ensure item exists in items table
    CHECK (equipslot IN ('ring', 'weapon', 'helmet', 'armor', 'shield', 'gauntlet', 'gorget', 'belt')) -- Restrict valid slots
);



/*player_inventory** shows the items that all players are carrying (not items that the player is currently wearing). 
If players are currently wearing a helmet, it will not be visible here.*/
CREATE TABLE player_inventory (
    player VARCHAR(50) NOT NULL,
    item INT NOT NULL,
    PRIMARY KEY (player, item), -- Avoid duplicate item/player: e.g: Kristinas/knife is different from Kristian/helmet and Rlobert/knife.
    FOREIGN KEY (player) REFERENCES players(name) ON DELETE CASCADE,
    FOREIGN KEY (item) REFERENCES items(id) ON DELETE CASCADE
);

/*equipped** contains the items that all players are currently wearing, 
note that a player can carry a maximum of one item in each _equipslot_. */
CREATE TABLE equipped (
    player VARCHAR(50) NOT NULL,
    item INT NOT NULL,
    equipslot VARCHAR(50) NOT NULL,
    PRIMARY KEY (player, equipslot), -- Ensure a player cannot equip multiple items in the same slot
    FOREIGN KEY (item) REFERENCES equippable (id), -- Ensure item exists in equippable
    CHECK (equipslot IN ('ring', 'weapon', 'helmet', 'armor', 'shield', 'gauntlet', 'gorget', 'belt')) -- Restrict valid slots
);


/* 1. Your first task is to add meaningful primary keys and constraints.
Besides making sure objects really exist, etc.
You should ensure that a player cannot equip multiple items in the same _equipslot_ and 
prevent players from equipping items in the wrong _equipslot_. 
Also, make sure all monetary values ​​are non-negative.

Tip: Check out CHECK and UNIQUE

2. Create the database via `CREATE TABLE` statements.*/

/* 3. Now you should insert the data into your table.
Write INSERT statements for the table with this data (adding missing values ​​as needed):
 - An item named "Vorpal sword", worth 10,000 and equipped as a _weapon_.
 - A non-wearable item named "Java Direct with Swing" worth 542.
 - An item named "Databases: The Complete Book" worth 495 and equipped as a _weapon_.
 - An item named "Oven Gloves", worth 999 and equips as _gauntlet_.
 - A user named "kristian" who is level 100, carries the mighty Vorpal Sword and has "Databases: The Complete Book" and "Oven Glove" in his inventory.
 - A user named "thomas" who is level 2, wears "Oven Gloves" and has "Databases: The Complete Book" in his inventory.*/

INSERT INTO items (id, itemname, value) VALUES
(1, 'Vorpal Sword', 10000), 
(2, 'Java Direct with Swing', 542),
(3, 'Databases: The Complete Book', 495),
(4, 'Oven Gloves', 999);

INSERT INTO equippable (id, equipslot) VALUES
(1, 'weapon'), 
(3, 'weapon'),
(4, 'gauntlet');

INSERT INTO players (name, level, money) VALUES
('kristian', 100, 50000),
('thomas', 2, 200);

INSERT INTO player_inventory (player, item) VALUES
('kristian', 3), -- Databases: The Complete Book
('kristian', 4), -- Oven Gloves
('thomas', 3);   -- Databases: The Complete Book

INSERT INTO equipped (player, item, equipslot) VALUES
('kristian', 1, 'weapon'), -- Kristian is equipped with the Vorpal Sword.
('thomas', 4, 'gauntlet'); -- Thomas is wearing Oven Gloves.


/* 4. Test your constraints. 
Write INSERTS for each of the following actions, they should all FAIL if you've implemented your constraints correctly.

 - To equip "Java directly with Swing" as Kristian's weapon (the item cannot be worn).
 - Equipping "Databases: The Complete Book" as Kristian's helmet (wrong slot).
 - To equip "Databases: The Complete Book" as Kristian's weapon (he already has a weapon).
 - Create another user with the name "kristian".*/

 INSERT INTO equipped (player, item, equipslot) VALUES
('kristian', 2, 'weapon'); -- Should FAIL: Item is not wearable.

/* Query with errors. Please, check the error below.
duplicate key value violates unique constraint "equipped_pkey"*/

INSERT INTO equipped (player, item, equipslot) VALUES
('kristian', 3, 'helmet'); -- Should FAIL: Incorrect slot for the item.

INSERT INTO equipped (player, item, equipslot) VALUES
('kristian', 3, 'weapon'); -- Should FAIL: Kristian already has a weapon equipped.

INSERT INTO players (name, level, money) VALUES
('kristian', 1, 100); -- Should FAIL: Duplicate username.



SELECT * FROM players;
SELECT * FROM items;
SELECT * FROM equippable;
SELECT * FROM player_inventory;
SELECT * FROM equipped;
