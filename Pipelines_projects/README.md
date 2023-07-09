## Airflow Space Project 🛫

This is a project using the tool Apache Airflow to create a Data Pipeline from 2 different data sources.

![](https://33333.cdn.cke-cs.com/kSW7V9NHUXugvhoQeFaf/images/92e31e7f820e2f44a0b6db5250bc97c15f2dad4806924eb9.png)

## Airflow Space Project 

Platzi's analyst and marketing teams need data from the students who have accessed the satellite and history information Spacex events, therefore we need help to execute the following tasks:

1.  Wait for NASA to give us authorization to access the data of the satellite.
2.  Collect data from the satellite and leave it in a file.
3.  Collect data from the SpaceX API and put it in a file.
4.  Send a message to the teams that the final data is available.

### Workflow

![](https://33333.cdn.cke-cs.com/kSW7V9NHUXugvhoQeFaf/images/fda3a64ce6299e5e8802286ba0de564fb5440abeca123bbc.png)

### Graph

![](https://33333.cdn.cke-cs.com/kSW7V9NHUXugvhoQeFaf/images/dfda20bc4a0dc1e383a8dc5a9812ba70b3990e7fe8db9b76.png)

## Requirements

*   Docker or WSL
*   Airflow

## Execute the Project

1.  `airflow webserver -p 8080`
2.  `airflow scheduler`
3.  [http://localhost:8080](http://localhost:8080)