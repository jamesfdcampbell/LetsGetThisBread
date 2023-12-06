Rails.configuration.stripe = { 
  :publishable_key => ENV['STRIPE_PUBLISHABLE_KEY'],
  :secret_key => ENV['STRIPE_SECRET_KEY']
} 

# PUBLISHABLE KEY = pk_test_51OAK27JN9RIezLoDOSCUZA8JBEGHm43XZggbn9ZPpD0tUYUu3xmH4HxR0prgI5ZNIi5Nirx4e7QO2nk1bq7VG5u800TDxPCd7k
# SECRET KEY = sk_test_51OAK27JN9RIezLoDNlxGtN2Y3ycXwizmJkyGEKPqIFLN5UgkMtUG4BIwfHMU2IYBl5mLF2GtUWXqsDMInxfs1zp700z16vUBNO

Stripe.api_key = Rails.configuration.stripe[:secret_key]