# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_crm_session',
  :secret      => 'ed0ec9d1d1202ffc3471e3b2dfe4da6131eecaf58a8379ff1aa90c221189536aeea7551c7470b7bbdb6c33c14f6890488d73266dba069385ca26c6697fd1b278'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
