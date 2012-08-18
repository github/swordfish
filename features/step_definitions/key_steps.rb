$public_key = <<-EOF
-----BEGIN PUBLIC KEY-----
MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQChmAIxel2F9o+7Jc94vskhGYhY
GpfhXiQWSRjR35cArSj+YlQtvVu83fuawB1bQt+pZqPuj9IMxAQslrtpnuPBk61I
XxYRGiL0EuKPTlmyEYLqARQT3+YYw+/uPjuBFBpzdIuBThAOV+MTya7R1hTdN23b
dQXoBlkZ2G7vgXASAQIDAQAB
-----END PUBLIC KEY-----
EOF

# password == 'testing'
$private_key = <<-EOF
-----BEGIN ENCRYPTED PRIVATE KEY-----
MIICzzBJBgkqhkiG9w0BBQ0wPDAbBgkqhkiG9w0BBQwwDgQIclFRkvEdEs8CAggA
MB0GCWCGSAFlAwQBAgQQn+bGq1SHCZ8SOmiwo6XwLASCAoCirBviz/7w/EMSyIQI
Z5Hdvjvjt0rtaRoa/RuZH53zKeEdi0suioeanduPTwzE7/dWcZK2GCsel5J2sf7l
0kG463SCAkLVmpQEFJ5KlgwKf5N+PGmqpDVAyKxNAUt60P18YaiZiRAeovsw+Nxz
/berByCG9O6pDbrVGzDggTD2tQW6pNksOI4zxm6dbOqNnaBB3CvVPkW4tR53ltsl
EnRy/SXOiZpfz5CDmRwfYZ6/3hnKKRigQG8ZdSo/9WU23rNfdMh5ifodqfAAeNv8
lnxQBxzw0e2KL/EbEh7EH1qSygQfRGK93WNTFZtE0z4UZ+lBzNS/UJJi71OgZDu1
a65MwBhJhZidx3cOAY3d6wTwm+1R3dBfF12JIIZzuxnZTjoV2ZGCzPJmJyvG82Fk
eJaJkfh+kMvUbKUSdsKc3JxcMgiwLeIvXZ1xjM0DeIGAsoy6tzq5YAHNxcppbK3m
Yf2cKjg0yApsO3InotlXWlPaVxCXc9Uxkvat/Tnv5nNmyoB26IGDqonHkZ2MccGc
rdlt/fBMcreeuWwlXJdL7Ftwl8VXiRFAM60kqswHBB2V/TtkFSdK2sf1BCMDTUdp
GF2xaFDEMEKPgGHqVyfa0wncQm4KisxC3mUrA2lzJIyBtXfo7WNAMUHu7iuDxBLs
A5/AXLg9punxSalob1K0aj4zablyrUPm46aeE5451mMFBn4+vaBItMjXSlrIJsH/
BjvbU5vG9U2f0RZG+OZ7l8RfvASIjZNtr+wvXiZJa8mQW4cAFbrPy8x6qbECSfgJ
KZ/usGJRtIUbe/8F9J3DcBqM4Hn+GYtWjSThNHtrhuizhKzJ/9uDsToYrKUZD+4s
owQY
-----END ENCRYPTED PRIVATE KEY-----
EOF

And /^"Download Private Key" should contain the private key$/ do
  find('a[download="swordfish.pem"]')['href'].should =~ /BEGIN%20ENCRYPTED%20PRIVATE%20KEY/
end

Given '"$email" has generated a key' do |email|
  user = User.first(:email => email)
  user.public_key = $public_key
  user.save!

  page.execute_script "localStorage['privateKey'] = #{$private_key.to_json}"
end