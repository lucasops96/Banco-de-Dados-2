query = "CREATE TABLE IF NOT EXISTS livro"
query = query + "( id int, title text, author text, year int, gender text, language text, PRIMARY KEY (id))"
try:
    session.execute(query)
except Exception as e:
    print(e)


query = "INSERT INTO livro (id, title, author, year, gender, language)"
query = query + " VALUES (%s, %s, %s, %s, %s, %s)"

try:
    session.execute(query, (1,"O Senhor dos Anéis","J.R.R. Tolkien",1954,"Fantasia","Inglês"))
except Exception as e:
    print(e)

try:
    session.execute(query, (2,"1984","George Orwell",1949,"Ficção Científica","Espanhol"))
except Exception as e:
    print(e)

try:
    session.execute(query, (3,"Dom Casmurro","Machado de Assis",1899,"Romance","Português"))
except Exception as e:
    print(e)


query = "select * from livro WHERE id=2" 
try:
    rows = session.execute(query)
except Exception as e:
    print(e)
    
for row in rows:
    print ('-ID:',row.id,'-Título:', row.title, '-Autor:', row.author,'-Ano de publicação:', row.year ,'-Gênero:', row.gender,'-Idioma:', row.language)



query = "CREATE TABLE IF NOT EXISTS livro_idioma"
query = query + "( id int, title text, author text, year int, gender text, language text, PRIMARY KEY (language,id))"
try:
    session.execute(query)
except Exception as e:
    print(e)

query = "INSERT INTO livro_idioma (language, id, title, author, year, gender)"
query = query + " VALUES (%s, %s, %s, %s, %s, %s)"

try:
    session.execute(query, ("Inglês",1,"O Senhor dos Anéis","J.R.R. Tolkien",1954,"Fantasia"))
except Exception as e:
    print(e)

try:
    session.execute(query, ("Espanhol",2,"1984","George Orwell",1949,"Ficção Científica"))
except Exception as e:
    print(e)

try:
    session.execute(query, ("Português",3,"Dom Casmurro","Machado de Assis",1899,"Romance"))
except Exception as e:
    print(e)

query = "select * from livro_idioma WHERE language='Inglês'" 
try:
    rows = session.execute(query)
except Exception as e:
    print(e)
    
for row in rows:
    print ('-Título:', row.title)



query = "CREATE TABLE IF NOT EXISTS livro_autor"
query = query + "( id int, title text, author text, year int, gender text, language text, PRIMARY KEY (author,id))"
try:
    session.execute(query)
except Exception as e:
    print(e)


query = "INSERT INTO livro_autor (author, id, title, year, gender, language)"
query = query + " VALUES (%s, %s, %s, %s, %s, %s)"

try:
    session.execute(query, ("J.R.R. Tolkien",1,"O Senhor dos Anéis",1954,"Fantasia","Inglês"))
except Exception as e:
    print(e)

try:
    session.execute(query, ("George Orwell",2,"1984",1949,"Ficção Científica","Espanhol"))
except Exception as e:
    print(e)

try:
    session.execute(query, ("Machado de Assis",3,"Dom Casmurro",1899,"Romance","Português"))
except Exception as e:
    print(e)

query = "select * from livro_autor WHERE author='Machado de Assis'" 
try:
    rows = session.execute(query)
except Exception as e:
    print(e)
    
for row in rows:
    print ('-Título:', row.title)