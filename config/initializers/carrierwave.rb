CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',       # required
    :aws_access_key_id      => 'AKIAIYSLIYWFJR2QQ6UA',       # required
    :aws_secret_access_key  => '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',       # required
    :region                 => 'us-west-2'  # optional, defaults to 'us-east-1'
  }
  config.fog_directory  = "lbuell" # required
  # see https://github.com/jnicklas/carrierwave#using-amazon-s3
  # for more optional configuration
end
