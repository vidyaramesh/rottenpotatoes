# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_rottenpotatoes_session',
  :secret      => 'fe39eab6d5d56501e3cedf42ba7e0c0f268a2966201b0c16353a3db032a5eadc432318ed5e5e138ef56edda39792b47d137e4238c3ac4186f3c7f276ee7027d7'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
