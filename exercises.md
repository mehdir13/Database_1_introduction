### 1. **Create Tables**

Implement the following tables with the specified columns:

- `books(__id__, title, author, price)`
- `customers(__id__, first_name, last_name, email)`

### 2. **Insert Data**

Insert the following data into the `books` table:

| id  | title                   | author                | price |
| --- | ----------------------- | --------------------- | ----- |
| 1   | "The Great Gatsby"      | "F. Scott Fitzgerald" | 10.99 |
| 2   | "1984"                  | "George Orwell"       | 8.99  |
| 3   | "To Kill a Mockingbird" | "Harper Lee"          | 12.50 |

Insert the following data into the `customers` table:

| id  | first_name | last_name | email                     |
| --- | ---------- | --------- | ------------------------- |
| 1   | Alice      | Johnson   | alice.johnson@example.com |
| 2   | Bob        | Smith     | bob.smith@example.com     |

### 3. **Add Foreign Keys**

Implement

```
orders(__id__, customer_id, book_id, order_date)
    customer_id --> customers.id
    book_id --> books.id
```

Insert the following data into the `orders` table:

| id  | customer_id | book_id | order_date |
| --- | ----------- | ------- | ---------- |
| 1   | 1           | 1       | 2024-11-15 |
| 2   | 2           | 2       | 2024-11-16 |

Now also verify your foreign keys.

---

### 4. **Foreign keys 2**

Create a `reviews` table which stores user reviews on books. A review has a text and a rating.

- Can you figure out which columns are needed?
- Which keys does the table have?
- Assume that a user can only leave one review per book at most. Come up with one or more primary keys for the table.

### 5. Advanced exercise

Här är ett utkast till ett schema för databasen till ett online-rollspel. Den saknar för tillfället primary keys och andra constraints.

```
players(name, level, money)
items(id, itemname, value)
equippable(id, equipslot)
player_inventory(player, item)
equipped(player, item, equipslot)

```

**players** innehåller användarnamn, level och in-gamepengar för alla spelare.

**items** beskriver alla föremål som spelare kan hitta i spelet. Varje föremål har ett ID-nummer, ett namn (flera föremål kan ha samma namn) och ett monetärt värde.

**equippable** beskriver ytterligare en delmängd av föremål som kan bäras av spelare. Varje sådant föremål har en _equipslot_ (t.ex. ”ring”, ”vapen”, ”hjälm” eller liknande) som indikerar var spelare kan ta på sig föremålet.

**player_inventory** visar de föremål som alla spelare bär på (ej föremål som spelaren har på sig just nu). Om spelare har på sig en hjälm just nu syns den alltså inte här.

**equipped** innehåller föremålen som alla spelare har på sig just nu, observera att en spelare kan bära högst ett föremål i varje _equipslot_.

1. Din första uppgift är att lägga till meningsfulla primary keys och constraints. Förutom att se till att föremål verkligen existerar osv. bör du se till att en spelare inte kan utrusta flera föremål i samma _equipslot_ och förhindra spelare från att utrusta föremål i fel _equipslot_. Se också till att alla monetära värden är icke-negativa.
   Tips: Kolla in CHECK och UNIQUE

2. Skapa databasen via `CREATE TABLE`-statements.

3. Nu ska du sätta in data i din tabell. Skriv INSERT-statements för tabellen med dessa data (lägg till saknade värden vid behov):
   - Ett föremål med namnet "Vorpal sword", värt 10 000 och som utrustas som _weapon_.
   - Ett föremål som inte går att ta på sig med namnet "Java direkt med Swing" värt 542.
   - Ett föremål med namnet "Databaser: Den kompletta boken" värt 495 och som utrustas som _weapon_.
   - Ett föremål med namnet "Ugnsvantar", värt 999 och utrustas som _gloves_.
   - En användare med namnet "kristian" som är level 100, bär det mäktiga Vorpal Sword och har "Databaser: Den kompletta boken" och "Ugnsvantar" i sitt inventory.
   - En användare med namnet "thomas" som är level 2, bär ”Ugnsvantar” och har "Databaser: Den kompletta boken" i sitt inventory.
4. Testa dina constraints. Skriv INSERTS för var och en av följande åtgärder, de bör alla misslyckas om du har implementerat dina constraints korrekt.
   - Att utrusta "Java direkt med Swing" som Kristians weapon (föremålet går ej att ha på sig).
   - Att utrusta "Databaser: Den kompletta boken" som Kristians helmet (fel slot).
   - Att utrusta "Databaser: Den kompletta boken" som Kristians weapon (han har redan ett vapen).
   - Skapa en annan användare med namnet "kristian".