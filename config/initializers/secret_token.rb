# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
PollingApp::Application.config.secret_key_base = 'b5a205c25cc50f0d368af708ca229df1dbdc2edecff9f429a866cbcb8464467f509bd983cbb5604ffb7ab73cf9cd777e8f1ba19aa708ea13f606ad8e2c8af4b3'
