# ETL RUN

- Run ```main.bat``` to process movements on file ```etl/in/Movements.xls```

## Extra - Load in parts

- Run ```etl/movimientos.ktr``` to load new Movements on staging area

- Run ```etl/main.kjb``` after loading new movements ins taging to update public analysis model

# Dimensional model
- File ```doc/dimensional.drawio```

![Screenshot](doc/dimensional.drawio.png)

# Backup de los ficheros de movimeintos
etl\in_todos

# WIP

- TODO: Load new movements by script
