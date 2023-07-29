
while ps -p 5657 > /dev/null; do 
echo "Process with PID 5657 is still running."
sleep 600 
done
echo "Process with PID 5657 has completed." | mail -s "Process Completed" "your@email.com"
