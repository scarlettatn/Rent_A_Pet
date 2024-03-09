# exit on error
set -o errexit

bundle install
bundle exec rails db:seed
bundle exec rails db:migrate
bundle exec rails assets:precompile
bundle exec rails assets:clean

#if you have seeds to run add:
