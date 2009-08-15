# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_openaustralia2_session',
  :secret      => 'e4bff2e1c84d57ce95504be947a24d0c448b93be1cffc369cedde2484f1392110c422ff93aa88a8285ec6f15066e3d129a2a72ae3595865dde8038bd089b8bb0'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
