Day 06 – Linux Fundamentals: Read and Write Text Files.

This is a continuation of Day 05, but much simpler.

Today’s goal is to practice basic file read/write using only fundamental commands.

--- 
1. create file : ( touch notes.txt ) verify now using this command : ls -l notes.txt



2. write text to a file : echo "Linux Day 06 Practice" > notes.txt

echo "Learning file operations" >> notes.txt

note : > - overwrites , >> appends.



3. Append using tee (write and display at the same time)

 :  echo "Practicing tee command" | tee -a notes.txt

note : -a : append mode , without -a it overwrites.



4. Add more Lines : echo "Reading file using cat" >> notes.txt

echo "Reading first lines using head" >> notes.txt

echo "Reading last lines using tail" >> notes.txt



5. To Read full file : cat notes.txt



6. To read first 2 lines : head -n 2 notes.txt



7. To read last 2 lines : tail -n 2 notes.txt