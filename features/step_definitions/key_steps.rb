$public_key = <<-EOF
-----BEGIN PUBLIC KEY-----
MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCOVDlhvRq0/FypeRGctd1t8YdQ
EQUFAzzye+ICzTJS2lgJAnVx8v7pFlhenRkfdCL+cFbFFAzUKu2OeuY/x6tAdds3
Mb1xHnLa/53unfoyF09VNDozfiTKNpm6tSGr11HLfcGbstNlntivpMUzKsMjjfo7
fdJ06mvgCa+D2ra4yQIDAQAB
-----END PUBLIC KEY-----
EOF

# password == 'testing'
$private_key = <<-EOF
-----BEGIN ENCRYPTED PRIVATE KEY-----
MIICzzBJBgkqhkiG9w0BBQ0wPDAbBgkqhkiG9w0BBQwwDgQIcr+AY81p67ACAggA
MB0GCWCGSAFlAwQBAgQQ+MZ40SX/K9W8nxetEKPfHQSCAoBSGqUKsTPXNX/qpAoD
cn9DvWZcCUQpWiLCtuaYp8trh51/OG8dj2+Mwq/xFFH+qlDM/QZZ2lEUEHSiDDOi
ojBxtGiIDEKsHKDt9RKXij1FhVfW8TLaTYNoIJS1CnU3L+MG0sEAMyiReKJgPaBO
uDYZ5aSfscPQ2BElzjOAEciWCF7Tc+8rn32pf4yGL2hximTxBGSVDiQdefKFH32C
sujw5yzkHBStU5J4nlMYax7+yG48SecpP+EaR2n3kVWfM6Y1y85RLsVX4Yw91d5c
02q6/TUggAwHbAuBBC/3u6+S+sTXRqx+oXkRdw/0sGOAEUViDzwPBkiK01Tk44Uy
VsyHHG4u/Hk0/lLspv++Ee9BL4+KIWjZImvnJ7t6f3UnwdA9nLp5wfrdf13F+ENW
1C3Gv+stu6SPJkpmo15BrXkM5gJtFrDn35kqGmvT+YA0TfRG8FI46LbwjbUDJhQ9
S/g9Ks0Ps4MoyZpzi+3QD7DyxcnZ1wRGsPtTgIK4XKqQDTxvboe7/6d/D7TLRLcS
99GuC7QfcfH6O0yH4C1NJ/6qtphY8yLNsodg61qNd1CL/tgpEzDWaDWngMg8To0h
4elzhixvU9baXvTuQFvyCLlkh5AGCOJgqZChWkR64G+izvodUfjEggDpKfjEcNKy
wITPbTHg0x6ibl72XGXiCU8+D4baxvThniwdMJAEWqmB3+2cvlU6dHkQzRxZHBEM
dXzdv9xtiQfkuiMEyaYS7+72/GQ2ghSdZBUxB0qqq5ZbCz4AGLc/nGeP+DH6q57u
ws8SDVgntQ9CB3mFaCyQQbRPhxcq1mNEnuJkDrZfrL8S7Nmi7anWPccTnZJ+97Qr
yu9t
-----END ENCRYPTED PRIVATE KEY-----
EOF

Given '"$email" has generated a key' do |email|
  user = User.first(:email => email)
  user.public_key = $public_key
  user.save!

  page.execute_script "localStorage['privateKey'] = #{$private_key.to_json}"
end
