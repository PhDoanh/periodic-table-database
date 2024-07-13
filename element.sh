#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only --no-align -c"

if [[ ! $1 =~ ^[0-9]+$ ]]; then
  OUTPUT=$($PSQL "SELECT * FROM properties FULL JOIN elements USING (atomic_number) FULL JOIN types USING (type_id) WHERE symbol='$1' OR name='$1'")
else
  OUTPUT=$($PSQL "SELECT * FROM properties FULL JOIN elements USING (atomic_number) FULL JOIN types USING (type_id) WHERE atomic_number=$1")
fi

if [[ -z $OUTPUT ]]; then
  echo "I could not find that element in the database."
else
  IFS="|" read TYPE_ID ATOMIC_NUMBER ATOMIC_MASS MELTING_POINT_CELSIUS BOILING_POINT_CELSIUS SYMBOL NAME TYPE <<< "$OUTPUT"
  echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT_CELSIUS celsius and boiling point of $BOILING_POINT_CELSIUS celsius."
fi
