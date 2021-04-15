echo 'Setting up repository...'
python "${0%/*}"/setup.py
if [ $? -eq 0 ]
then
    rm -- "$0"
    echo 'Repository setup complete...'
else
    echo 'Issue setting up repository...'
fi