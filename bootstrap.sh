#!/bin/bash
echo "----> Modifying Gemfile"
cp Gemfile.prod Gemfile

echo "----> Modifying Database"
cp config/initializers/db_reconcilation.rb.prd config/initializers/db_reconcilation.rb


echo "----> Done!!"